/* JestokyCraft Hardcore integration. GPL-2.0-or-later, matching AzerothCore. */
#include "Player.h"
#include "HardcoreMemorialHooks.h"
#include "SpellInfo.h"
#include "GameObject.h"
#include "DBCStores.h"
#include "ItemTemplate.h"
#include "LootMgr.h"
#include "ObjectMgr.h"
#include "Map.h"
#include "Random.h"
#include <bit>
#include "Config.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "Log.h"
#include "WorldSession.h"

#include <cstdio>
#include <filesystem>
#include <fstream>
#include <mutex>
#include <sstream>
#include <stdexcept>
#ifdef _WIN32
#include <io.h>
#else
#include <unistd.h>
#endif

namespace
{
std::mutex journalMutex;
bool journalReady = false;
std::filesystem::path journalPath;
thread_local Player* deathSourcePlayer = nullptr;
thread_local Unit* deathSourceKiller = nullptr;
thread_local uint32 deathSourceSpell = 0;
thread_local Player* environmentPlayer = nullptr;
thread_local uint8 environmentType = 255;

struct DeathIntent
{
    uint32 guid, account, level, map, zone, time, played;

    uint32 Checksum() const
    {
        return 0x48433101u ^ guid ^ account ^ level ^ map ^ zone ^ time ^ played;
    }
};

uint8 ReadState(uint32 guid, uint32 account, uint16* pacts = nullptr, uint8 playerClass = 0)
{
    auto* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_HARDCORE_ATTEMPT);
    stmt->SetData(0, guid);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
        throw std::runtime_error("Hardcore state read failed; refusing an unverified life");
    Field* row = result->Fetch();
    uint64 count = row[0].Get<uint64>();
    if (!count)
        return 0;
    uint8 state = row[1].Get<uint8>();
    if (count != 1 || row[2].Get<uint32>() != 1 || row[3].Get<uint32>() != account || state < 1 || state > 4)
        throw std::runtime_error("Hardcore state/schema invalid");
    uint16 mask = row[4].Get<uint16>();
    // Journal replay includes deleted characters. Validate mask structure there;
    // the immutable class restriction is checked at creation and Player load.
    if (row[5].Get<uint16>() != 1 || !Player::ValidateHardcorePacts(mask, playerClass ? playerClass : CLASS_HUNTER))
        throw std::runtime_error("Hardcore pact selection invalid");
    if (pacts)
        *pacts = mask;
    return state;
}

void CommitDeath(DeathIntent const& event)
{
    auto* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_HARDCORE_DEATH);
    stmt->SetData(0, event.level);
    stmt->SetData(1, event.map);
    stmt->SetData(2, event.zone);
    stmt->SetData(3, event.time);
    stmt->SetData(4, event.played);
    stmt->SetData(5, event.guid);
    stmt->SetData(6, event.account);
    CharacterDatabase.DirectExecute(stmt);
    uint8 state = ReadState(event.guid, event.account);
    if (state != 2 && state != 3)
        throw std::runtime_error("Hardcore death commit not confirmed; durable intent retained");
}

void FlushIntent(DeathIntent const& event)
{
    std::FILE* file = std::fopen(journalPath.string().c_str(), "ab");
    if (!file)
        throw std::runtime_error("Hardcore journal unavailable");
    int written = std::fprintf(file, "HC1 %u %u %u %u %u %u %u %u\n", event.guid, event.account,
        event.level, event.map, event.zone, event.time, event.played, event.Checksum());
    bool ok = written > 0 && std::fflush(file) == 0;
#ifdef _WIN32
    ok = ok && _commit(_fileno(file)) == 0;
#else
    ok = ok && fsync(fileno(file)) == 0;
#endif
    ok = std::fclose(file) == 0 && ok;
    if (!ok)
        throw std::runtime_error("Hardcore journal flush failed; refusing death processing");
}
}

void Player::InitializeHardcoreJournal()
{
    std::lock_guard<std::mutex> lock(journalMutex);
    if (journalReady)
        return;
    journalPath = sConfigMgr->GetOption<std::string>("Hardcore.Journal", "hardcore-deaths.journal");
    if (!journalPath.is_absolute() || !std::filesystem::is_directory(journalPath.parent_path()))
        throw std::runtime_error("Hardcore.Journal must be an absolute path in an existing state directory");
    if (std::filesystem::exists(journalPath))
    {
        std::ifstream input(journalPath, std::ios::binary);
        if (!input)
            throw std::runtime_error("Hardcore journal cannot be read");
        std::string line;
        while (std::getline(input, line))
        {
            DeathIntent event{};
            uint32 checksum = 0;
            std::string magic, extra;
            std::istringstream record(line);
            if (input.eof() || !(record >> magic >> event.guid >> event.account >> event.level >> event.map
                >> event.zone >> event.time >> event.played >> checksum) || (record >> extra)
                || magic != "HC1" || checksum != event.Checksum())
                throw std::runtime_error("Hardcore journal incomplete or damaged; manual recovery required");
            CommitDeath(event);
        }
        if (input.bad())
            throw std::runtime_error("Hardcore journal read error");
    }
    journalReady = true;
    LOG_INFO("server.loading", "Hardcore: durable death journal recovered; rules version 1, unranked candidate");
}

void Player::AppendHardcoreCreation(CharacterDatabaseTransaction transaction, uint16 pacts)
{
    // The handler validated the explicit request before asynchronous creation.
    // A config reload must not silently turn an accepted Hardcore request into ordinary play.
    if (GetSession()->IsBot())
        return;
    auto* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_HARDCORE_ATTEMPT);
    stmt->SetData(0, GetGUID().GetCounter());
    stmt->SetData(1, GetSession()->GetAccountId());
    stmt->SetData(2, uint32(GetLevel()));
    stmt->SetData(3, pacts);
    m_hardcorePacts = pacts;
    transaction->Append(stmt);
    m_hardcoreState = 1;
}

bool Player::LoadHardcoreState()
{
    try
    {
        InitializeHardcoreJournal();
        m_hardcoreState = ReadState(GetGUID().GetCounter(), GetSession()->GetAccountId(), &m_hardcorePacts, getClass());
        return true;
    }
    catch (std::exception const& error)
    {
        LOG_ERROR("entities.player", "Hardcore login refused: {}", error.what());
        return false;
    }
}

void Player::RecordHardcoreDeath()
{
    if (m_hardcoreState != 1)
        return;
    InitializeHardcoreJournal();
    std::lock_guard<std::mutex> lock(journalMutex);
    DeathIntent event{GetGUID().GetCounter(), GetSession()->GetAccountId(), GetLevel(), GetMapId(),
        GetZoneId(), uint32(GameTime::GetGameTime().count()), GetTotalPlayedTime()};
    // Persist intent before changing death state or running death scripts. Startup replays it after a crash.
    HardcoreMemorialCapture(this, deathSourcePlayer == this ? deathSourceKiller : nullptr,
        deathSourcePlayer == this ? deathSourceSpell : 0, environmentPlayer == this ? environmentType : 255, event.time);
    FlushIntent(event);
    m_hardcoreState = 2;
    CommitDeath(event);
    HardcoreMemorialPublish(this);
    LOG_INFO("entities.player", "Hardcore attempt ended for {} at level {}, map {}", GetGUID().ToString(),
        event.level, event.map);
}

void HardcoreRecordDeathWithSource(Player* player, Unit* killer, SpellInfo const* spell)
{
    Player* oldPlayer = deathSourcePlayer;
    Unit* oldKiller = deathSourceKiller;
    uint32 oldSpell = deathSourceSpell;
    deathSourcePlayer = player; deathSourceKiller = killer; deathSourceSpell = spell ? spell->Id : 0;
    try { player->RecordHardcoreDeath(); }
    catch (...) { deathSourcePlayer = oldPlayer; deathSourceKiller = oldKiller; deathSourceSpell = oldSpell; throw; }
    deathSourcePlayer = oldPlayer; deathSourceKiller = oldKiller; deathSourceSpell = oldSpell;
}

HardcoreEnvironmentScope::HardcoreEnvironmentScope(Player* player, uint8 type)
    : previousPlayer(environmentPlayer), previousType(environmentType)
{ environmentPlayer = player; environmentType = type; }
HardcoreEnvironmentScope::~HardcoreEnvironmentScope()
{ environmentPlayer = previousPlayer; environmentType = previousType; }

bool Player::LeaveHardcore()
{
    if (!IsHardcore() || IsInCombat() || (m_hardcoreState == 1 && !HasPlayerFlag(PLAYER_FLAGS_RESTING)))
        return false;
    auto* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_HARDCORE_LEAVE);
    stmt->SetData(0, GetGUID().GetCounter());
    stmt->SetData(1, GetSession()->GetAccountId());
    CharacterDatabase.DirectExecute(stmt);
    uint8 expected = m_hardcoreState == 1 ? 4 : 3;
    uint8 actual = ReadState(GetGUID().GetCounter(), GetSession()->GetAccountId());
    if (actual != expected)
        return false;
    m_hardcoreState = actual;
    return true;
}

bool Player::ValidateHardcorePacts(uint16 mask, uint8 playerClass)
{
    return !(mask & ~0x0FFFu) && std::popcount(uint32(mask)) <= 4 &&
        (mask & 0x00C0u) != 0x00C0u && (!(mask & 0x0800u) || playerClass == CLASS_HUNTER || playerClass == CLASS_WARLOCK);
}

bool Player::IsHardcoreCharacter(ObjectGuid guid)
{
    auto* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_HARDCORE_ATTEMPT);
    stmt->SetData(0, guid.GetCounter());
    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
        return true; // Mail fails closed when the recipient's state cannot be verified.
    Field* row = result->Fetch();
    return row[0].Get<uint64>() && (row[1].Get<uint8>() == 1 || row[1].Get<uint8>() == 2);
}

uint32 Player::HardcoreGatherCount(uint32 itemId, uint32 count, Loot const* loot) const
{
    if (!HasHardcorePact(6) || !loot || !count)
        return count;
    ItemTemplate const* item = sObjectMgr->GetItemTemplate(itemId);
    if (!item || item->Quality != ITEM_QUALITY_NORMAL || item->MaxCount ||
        item->Class != ITEM_CLASS_TRADE_GOODS ||
        (item->SubClass != ITEM_SUBCLASS_HERB && item->SubClass != ITEM_SUBCLASS_METAL_STONE &&
         item->SubClass != ITEM_SUBCLASS_LEATHER))
        return count;
    bool gathering = loot->loot_type == LOOT_SKINNING && item->SubClass == ITEM_SUBCLASS_LEATHER;
    if (loot->sourceWorldObjectGUID.IsGameObject())
        if (GameObject* node = GetMap()->GetGameObject(loot->sourceWorldObjectGUID))
            if (node->GetGoType() == GAMEOBJECT_TYPE_CHEST)
                if (LockEntry const* lock = sLockStore.LookupEntry(node->GetGOInfo()->chest.lockId))
                    for (uint8 i = 0; i < MAX_LOCK_CASE; ++i)
                        if (lock->Type[i] == LOCK_KEY_SKILL &&
                            (lock->Index[i] == LOCKTYPE_HERBALISM || lock->Index[i] == LOCKTYPE_MINING))
                            gathering = true;
    return gathering ? count + count / 2 + ((count % 2 && roll_chance_i(50)) ? 1 : 0) : count;
}
