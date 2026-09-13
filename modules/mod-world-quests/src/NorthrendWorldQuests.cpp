#include "Chat.h"
#include "AllGameObjectScript.h"
#include "CharacterDatabase.h"
#include "CommandScript.h"
#include "Config.h"
#include "Creature.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "PlayerScript.h"
#include "GameObject.h"
#include "Item.h"
#include "Log.h"
#include "Spell.h"
#include "QuestDef.h"
#include "Random.h"
#include "RBAC.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "WorldScript.h"
#include "WorldSession.h"
#include "WorldQuestObjectiveData.h"
#include "World.h"
#include "WorldConfig.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <sstream>
#include <unordered_map>
#include <unordered_set>
#include <vector>

using namespace Acore::ChatCommands;

namespace
{
enum class WorldQuestState : uint8
{
    Available,
    Active,
    Completed,
    Expired,
    Completing
};

enum class RewardType : uint8
{
    Emblem,
    Arena,
    Honor,
    Gold
};

struct WorldQuestConfig
{
    bool Enabled = true;
    bool Announce = true;
    bool IncludeBots = false;
    uint32 QuestsPerWave = 3;
    uint32 DurationHours = 24;
    float BaseRefreshHours = 6.0f;
    uint32 CooldownHours = 72;
    float ActivationRadius = 200.0f;
    std::array<uint32, 4> RewardWeights = { 1, 1, 1, 1 };
    std::vector<uint32> EmblemItems = { 49426, 47241, 45624, 40753, 40752 };
};

struct WorldQuestEntry
{
    uint32 QuestId = 0;
    WorldQuestState State = WorldQuestState::Available;
    uint32 StartsAt = 0;
    uint32 ExpiresAt = 0;
    RewardType Reward = RewardType::Gold;
    uint32 RewardId = 0;
    uint32 RewardAmount = 0;
    RewardType Reward2 = RewardType::Gold;
    uint32 RewardId2 = 0;
    uint32 RewardAmount2 = 0;
    uint32 CompletedAt = 0;
    uint32 NextRewardRetryAt = 0;
    std::array<uint32, QUEST_OBJECTIVES_COUNT> Progress = {};
};

struct RareTarget
{
    uint32 Entry;
    uint32 Zone;
    float X;
    float Y;
    char const* Name;
};

constexpr uint32 RareQuestOffset = 1000000;
constexpr std::array<RareTarget, 23> RareTargets = {{
    {32357, 3537, 3550.59f, 7169.73f, "Old Crystalbark"}, {32358, 3537, 4107.78f, 4981.30f, "Fumblub Gearwind"},
    {32361, 3537, 3565.27f, 3635.40f, "Icehorn"}, {32377, 495, 2402.76f, -5545.49f, "Perobas the Bloodthirster"},
    {32386, 495, 1091.68f, -5756.49f, "Vigdis the War Maiden"}, {32398, 495, 827.64f, -3283.51f, "King Ping"},
    {32400, 65, 4423.20f, -191.61f, "Tukemuth"}, {32409, 65, 3425.29f, 1811.42f, "Crazed Indu'le Survivor"},
    {32417, 65, 4105.49f, -1132.07f, "Scarlet Highlord Daion"}, {32422, 394, 3570.74f, -1748.55f, "Grocklar"},
    {32429, 394, 3913.28f, -2804.43f, "Seething Hate"}, {32438, 394, 4064.03f, -4598.68f, "Syreian the Bonecarver"},
    {32447, 66, 5693.95f, -2871.76f, "Zul'drak Sentinel"}, {32471, 66, 5115.49f, -1652.65f, "Griegen"},
    {32475, 66, 6711.42f, -4186.12f, "Terror Spinner"}, {32481, 3711, 5368.74f, 4427.76f, "Aotona"},
    {32485, 3711, 4865.04f, 4679.54f, "King Krush"}, {32487, 210, 6726.49f, 2521.46f, "Putridus the Ancient"},
    {32495, 210, 7514.08f, 3663.15f, "Hildana Deathstealer"}, {32500, 67, 8392.22f, -1189.11f, "Dirkee"},
    {32501, 210, 6155.10f, 2377.94f, "High Thane Jorfus"}, {32517, 3711, 4920.73f, 4710.52f, "Loque'nahak"},
    {32630, 67, 6748.21f, -1664.31f, "Vyragosa"}
}};

RareTarget const* GetRareTarget(uint32 worldQuestId)
{
    if (worldQuestId < RareQuestOffset)
        return nullptr;
    uint32 entry = worldQuestId - RareQuestOffset;
    auto itr = std::find_if(RareTargets.begin(), RareTargets.end(), [entry](RareTarget const& rare) { return rare.Entry == entry; });
    return itr == RareTargets.end() ? nullptr : &*itr;
}

struct CharacterWorldQuests
{
    std::unordered_map<uint32, WorldQuestEntry> Entries;
    uint32 NextWaveAt = 0;
    uint32 NextUpdateAt = 0;
    uint32 SyncSerial = 0;
};

WorldQuestConfig Config;

constexpr std::array<uint32, 11> NorthrendZones = {
    65,   // Dragonblight
    66,   // Zul'Drak
    67,   // The Storm Peaks
    210,  // Icecrown
    394,  // Grizzly Hills
    495,  // Howling Fjord
    3537, // Borean Tundra
    3711, // Sholazar Basin
    4197, // Wintergrasp
    4395, // Dalaran
    2817  // Crystalsong Forest
};

uint32 Now()
{
    return static_cast<uint32>(GameTime::GetGameTime().count());
}

bool IsNorthrendZone(int32 zone)
{
    return zone > 0 && std::find(NorthrendZones.begin(), NorthrendZones.end(), uint32(zone)) != NorthrendZones.end();
}

bool HasOnlySupportedObjectives(Quest const* quest)
{
    bool hasObjective = false;

    // World quests deliberately support only direct kill, collect/drop and
    // creature/gameobject interaction objectives. Item-use/cast objectives
    // require original quest scripting and are excluded from the pool.
    if (quest->GetSrcItemId() != 0 || quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_CAST))
        return false;

    for (uint8 i = 0; i < QUEST_SOURCE_ITEM_IDS_COUNT; ++i)
        if (quest->ItemDrop[i] != 0)
            return false;

    for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
    {
        if (!quest->RequiredItemId[i] && !quest->RequiredItemCount[i])
            continue;

        if (!quest->RequiredItemId[i] || !quest->RequiredItemCount[i])
            return false;

        hasObjective = true; // collect
    }

    for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
    {
        if (!quest->RequiredNpcOrGo[i] && !quest->RequiredNpcOrGoCount[i])
            continue;

        if (!quest->RequiredNpcOrGo[i] || !quest->RequiredNpcOrGoCount[i])
            return false;

        // Positive IDs are creature kills, or use-item/spell targets when a spell is present.
        // Negative IDs are gameobject interactions, optionally through a required spell/item.
        hasObjective = true;
    }

    return hasObjective;
}

bool IsEligibleTemplate(Quest const* quest)
{
    if (!quest || !IsNorthrendZone(quest->GetZoneOrSort()))
        return false;

    // Scripted scenario: its NPC AI explicitly requires QUEST_STATUS_INCOMPLETE
    // in the real quest log, so it cannot run in the external-progress model.
    if (quest->GetQuestId() == 12644)
        return false;

    switch (quest->GetType())
    {
        case QUEST_TYPE_PVP:
        case QUEST_TYPE_RAID:
        case QUEST_TYPE_DUNGEON:
        case QUEST_TYPE_WORLD_EVENT:
        case QUEST_TYPE_LEGENDARY:
        case QUEST_TYPE_ESCORT:
        case QUEST_TYPE_HEROIC:
        case QUEST_TYPE_RAID_10:
        case QUEST_TYPE_RAID_25:
            return false;
        default:
            break;
    }

    if (quest->IsRepeatable() || quest->IsDaily() || quest->IsWeekly() || quest->IsMonthly() || quest->IsSeasonal())
        return false;

    if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT | QUEST_SPECIAL_FLAGS_TIMED |
        QUEST_SPECIAL_FLAGS_PLAYER_KILL | QUEST_SPECIAL_FLAGS_SPEAKTO))
        return false;

    if (quest->GetSuggestedPlayers() > 1 || quest->GetRepObjectiveFaction() || quest->GetRepObjectiveFaction2() ||
        quest->GetRequiredMinRepFaction() || quest->GetRequiredMaxRepFaction())
        return false;

    return HasOnlySupportedObjectives(quest);
}

bool IsEligibleForPlayer(Player* player, Quest const* quest)
{
    return IsEligibleTemplate(quest) && player->SatisfyQuestRace(quest, false) &&
        player->SatisfyQuestClass(quest, false);
}

bool GetQuestWorldPosition(Quest const* quest, float& x, float& y)
{
    if (!quest)
        return false;

    x = quest->GetPOIx();
    y = quest->GetPOIy();
    if (x != 0.0f || y != 0.0f)
        return true;

    if (QuestPOIVector const* pois = sObjectMgr->GetQuestPOIVector(quest->GetQuestId()))
        for (QuestPOI const& poi : *pois)
            if (!poi.points.empty())
            {
                x = float(poi.points.front().x);
                y = float(poi.points.front().y);
                return true;
            }

    return false;
}

std::vector<uint32> ParseItemList(std::string const& value)
{
    std::vector<uint32> result;
    std::stringstream stream(value);
    std::string token;
    while (std::getline(stream, token, ','))
    {
        try
        {
            uint32 itemId = uint32(std::stoul(token));
            if (itemId)
                result.push_back(itemId);
        }
        catch (...)
        {
        }
    }
    return result;
}

class NorthrendWorldQuestMgr
{
public:
    static NorthrendWorldQuestMgr& Instance()
    {
        static NorthrendWorldQuestMgr instance;
        return instance;
    }

    void Load(Player* player)
    {
        if (!ShouldProcess(player))
            return;

        uint32 guid = player->GetGUID().GetCounter();
        CharacterWorldQuests& data = _characters[guid];
        data = {};

        if (QueryResult result = CharacterDatabase.Query(
            "SELECT quest, state, startsAt, expiresAt, rewardType, rewardId, rewardAmount, completedAt, "
            "rewardType2, rewardId2, rewardAmount2, progress0, progress1, progress2, progress3 "
            "FROM character_world_quest WHERE guid = {}", guid))
        {
            do
            {
                Field* fields = result->Fetch();
                WorldQuestEntry entry;
                entry.QuestId = fields[0].Get<uint32>();
                entry.State = WorldQuestState(fields[1].Get<uint8>());
                entry.StartsAt = fields[2].Get<uint32>();
                entry.ExpiresAt = fields[3].Get<uint32>();
                entry.Reward = RewardType(fields[4].Get<uint8>());
                entry.RewardId = fields[5].Get<uint32>();
                entry.RewardAmount = fields[6].Get<uint32>();
                entry.CompletedAt = fields[7].Get<uint32>();
                entry.Reward2 = RewardType(fields[8].Get<uint8>());
                entry.RewardId2 = fields[9].Get<uint32>();
                entry.RewardAmount2 = fields[10].Get<uint32>();
                for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
                    entry.Progress[i] = fields[11 + i].Get<uint32>();
                data.Entries[entry.QuestId] = entry;
            } while (result->NextRow());
        }

        if (QueryResult result = CharacterDatabase.Query(
            "SELECT nextWaveAt FROM character_world_quest_schedule WHERE guid = {}", guid))
            data.NextWaveAt = result->Fetch()[0].Get<uint32>();

        Process(player, true);
        RefreshVisualObjectives(player);
    }

    void Unload(Player* player)
    {
        if (player)
            _characters.erase(player->GetGUID().GetCounter());
    }

    void Update(Player* player)
    {
        if (!ShouldProcess(player))
            return;

        auto itr = _characters.find(player->GetGUID().GetCounter());
        if (itr == _characters.end())
            return;

        uint32 now = Now();
        if (itr->second.NextUpdateAt > now)
            return;

        itr->second.NextUpdateAt = now + 10;
        Process(player, false);
        UpdateActivationByDistance(player);
    }

    void Process(Player* player, bool login)
    {
        CharacterWorldQuests& data = _characters[player->GetGUID().GetCounter()];
        uint32 now = Now();

        for (auto& [questId, entry] : data.Entries)
        {
            if (login && !GetRareTarget(questId) &&
                (entry.State == WorldQuestState::Completed || entry.State == WorldQuestState::Expired))
                if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
                    CleanupObjectiveItems(player, quest, questId, true, false);

            if ((entry.State == WorldQuestState::Available || entry.State == WorldQuestState::Active) &&
                entry.ExpiresAt <= now)
            {
                if (!GetRareTarget(questId))
                    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
                        CleanupObjectiveItems(player, quest, questId, false, true);
                entry.State = WorldQuestState::Expired;
                entry.CompletedAt = now;
                SaveState(player, entry);
                continue;
            }

            if (entry.State == WorldQuestState::Active && !GetRareTarget(questId))
                CheckCompletion(player, entry);
        }

        float intervalHours = GetRefreshHours(player);
        uint32 interval = std::max<uint32>(60, uint32(std::lround(intervalHours * HOUR)));
        uint32 duration = Config.DurationHours * HOUR;

        if (!data.NextWaveAt)
            data.NextWaveAt = now > duration ? now - duration + interval : now;

        uint32 processed = 0;
        while (data.NextWaveAt <= now && processed < 16)
        {
            if (data.NextWaveAt + duration > now)
                GenerateWave(player, data.NextWaveAt);
            data.NextWaveAt += interval;
            ++processed;
        }

        if (data.NextWaveAt <= now)
            data.NextWaveAt = now + interval;

        SaveSchedule(player, data.NextWaveAt);

        if (login && Config.Announce)
        {
            auto [available, active] = CountCurrent(player);
            ChatHandler(player->GetSession()).PSendSysMessage(
                "World quests: {} available, {} active. Next wave in {} minutes.", available, active,
                data.NextWaveAt > now ? (data.NextWaveAt - now) / MINUTE : 0);
        }
    }

    void ForceRefresh(Player* player)
    {
        CharacterWorldQuests& data = _characters[player->GetGUID().GetCounter()];
        data.NextWaveAt = Now();
        Process(player, false);
    }

    void RefreshVisualObjectives(Player* player)
    {
        WorldQuestObjectiveData* visual = player->CustomData.GetDefault<WorldQuestObjectiveData>("NorthrendWorldQuestObjectives");
        visual->GameObjects.clear();
        visual->Items.clear();

        auto charItr = _characters.find(player->GetGUID().GetCounter());
        if (charItr != _characters.end())
        {
            for (auto const& [questId, entry] : charItr->second.Entries)
            {
                if (entry.State != WorldQuestState::Active || entry.ExpiresAt <= Now())
                    continue;

                if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
                {
                    for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
                    {
                        if (quest->RequiredNpcOrGo[i] < 0 && entry.Progress[i] < quest->RequiredNpcOrGoCount[i])
                            visual->GameObjects.insert(uint32(-quest->RequiredNpcOrGo[i]));
                    }

                    for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
                    {
                        if (quest->RequiredItemId[i] && quest->RequiredItemCount[i] &&
                            player->GetItemCount(quest->RequiredItemId[i], true) < quest->RequiredItemCount[i])
                        {
                            visual->Items[quest->RequiredItemId[i]] = std::max(
                                visual->Items[quest->RequiredItemId[i]], quest->RequiredItemCount[i]);
                        }
                    }
                }
            }
        }

        player->UpdateObjectVisibility(true);
    }

    bool Activate(Player* player, uint32 questId)
    {
        auto charItr = _characters.find(player->GetGUID().GetCounter());
        if (charItr == _characters.end())
            return false;

        auto itr = charItr->second.Entries.find(questId);
        if (itr == charItr->second.Entries.end() || itr->second.State != WorldQuestState::Available ||
            itr->second.ExpiresAt <= Now())
            return false;

        if (GetRareTarget(questId))
        {
            itr->second.State = WorldQuestState::Active;
            SaveState(player, itr->second);
            return true;
        }

        Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
        if (!quest)
            return false;

        itr->second.State = WorldQuestState::Active;
        SaveState(player, itr->second);
        RefreshVisualObjectives(player);
        return true;
    }

    void Abandon(Player* player, uint32 questId)
    {
        auto charItr = _characters.find(player->GetGUID().GetCounter());
        if (charItr == _characters.end())
            return;

        auto itr = charItr->second.Entries.find(questId);
        if (itr == charItr->second.Entries.end() || itr->second.State != WorldQuestState::Active)
            return;

        itr->second.State = itr->second.ExpiresAt > Now() ? WorldQuestState::Available : WorldQuestState::Expired;
        SaveState(player, itr->second);
        RefreshVisualObjectives(player);
    }

    void CreatureKilled(Player* player, uint32 creatureEntry)
    {
        if (!player || !player->IsInWorld())
            return;
        auto charItr = _characters.find(player->GetGUID().GetCounter());
        if (charItr == _characters.end())
            return;

        uint32 questId = RareQuestOffset + creatureEntry;
        auto itr = charItr->second.Entries.find(questId);
        if (itr != charItr->second.Entries.end() && itr->second.State == WorldQuestState::Active &&
            itr->second.ExpiresAt > Now())
            Reward(player, itr->second);

        CreditTarget(player, int32(creatureEntry));
    }

    void ItemCollected(Player* player)
    {
        CheckAllActive(player);
        ChatHandler handler(player->GetSession());
        Sync(&handler, player);
    }

    bool HasQuestForItem(Player const* player, uint32 itemId, bool* showInLoot) const
    {
        if (!player || !itemId)
            return false;

        auto charItr = _characters.find(player->GetGUID().GetCounter());
        if (charItr == _characters.end())
            return false;

        bool isWorldQuestObjective = false;
        uint32 ownedCount = player->GetItemCount(itemId, true);
        uint32 now = Now();
        for (auto const& [questId, entry] : charItr->second.Entries)
        {
            if (GetRareTarget(questId))
                continue;

            Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
            if (!quest)
                continue;

            for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
            {
                if (quest->RequiredItemId[i] != itemId || !quest->RequiredItemCount[i])
                    continue;

                isWorldQuestObjective = true;
                if (entry.State == WorldQuestState::Active && entry.ExpiresAt > now &&
                    ownedCount < quest->RequiredItemCount[i])
                    return true;
            }
        }

        if (isWorldQuestObjective && showInLoot)
            *showInLoot = false;

        return false;
    }

    void SpellCast(Player* player, Spell* spell)
    {
        if (!player || !spell || !spell->GetSpellInfo())
            return;
        int32 target = 0;
        if (GameObject* go = spell->m_targets.GetGOTarget())
            target = -int32(go->GetEntry());
        else if (Unit* unit = spell->m_targets.GetUnitTarget())
            if (Creature* creature = unit->ToCreature())
                target = int32(creature->GetEntry());
        if (target)
            CreditTarget(player, target);
    }

    void GameObjectUsed(Player* player, uint32 entry)
    {
        CreditTarget(player, -int32(entry));
    }

    std::pair<uint32, uint32> CountCurrent(Player* player) const
    {
        uint32 available = 0;
        uint32 active = 0;
        auto itr = _characters.find(player->GetGUID().GetCounter());
        if (itr == _characters.end())
            return { available, active };

        for (auto const& [questId, entry] : itr->second.Entries)
        {
            (void)questId;
            if (entry.ExpiresAt <= Now())
                continue;
            if (entry.State == WorldQuestState::Available)
                ++available;
            else if (entry.State == WorldQuestState::Active)
                ++active;
        }
        return { available, active };
    }

    void List(ChatHandler* handler, Player* player) const
    {
        auto itr = _characters.find(player->GetGUID().GetCounter());
        if (itr == _characters.end())
            return;

        uint32 now = Now();
        for (auto const& [questId, entry] : itr->second.Entries)
        {
            if ((entry.State != WorldQuestState::Available && entry.State != WorldQuestState::Active) ||
                entry.ExpiresAt <= now)
                continue;

            Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
            handler->PSendSysMessage("{} [{}] - {}, reward {}:{} x{}, {} min", questId,
                entry.State == WorldQuestState::Available ? "available" : "active",
                quest ? quest->GetTitle() : "unknown", uint32(entry.Reward), entry.RewardId,
                entry.RewardAmount, (entry.ExpiresAt - now) / MINUTE);
        }
    }

    void Sync(ChatHandler* handler, Player* player)
    {
        auto itr = _characters.find(player->GetGUID().GetCounter());
        if (itr == _characters.end())
            return;

        uint32 now = Now();
        uint32 serial = ++itr->second.SyncSerial;
        handler->PSendSysMessage("WQ|B|{}|{}|{:.4f}", serial, itr->second.NextWaveAt, GetProgress(player));
        for (auto const& [questId, entry] : itr->second.Entries)
        {
            if ((entry.State != WorldQuestState::Available && entry.State != WorldQuestState::Active) ||
                entry.ExpiresAt <= now)
                continue;

            RareTarget const* rare = GetRareTarget(questId);
            Quest const* quest = rare ? nullptr : sObjectMgr->GetQuestTemplate(questId);
            if (!rare && !quest)
                continue;

            float x = rare ? rare->X : quest->GetPOIx();
            float y = rare ? rare->Y : quest->GetPOIy();
            if (!rare && x == 0.0f && y == 0.0f)
            {
                if (QuestPOIVector const* pois = sObjectMgr->GetQuestPOIVector(questId))
                {
                    for (QuestPOI const& poi : *pois)
                    {
                        if (poi.points.empty())
                            continue;
                        x = float(poi.points.front().x);
                        y = float(poi.points.front().y);
                        break;
                    }
                }
            }

            uint32 zone = rare ? rare->Zone : uint32(quest->GetZoneOrSort());
            Map2ZoneCoordinates(x, y, zone);
            x = std::clamp(x / 100.0f, 0.0f, 1.0f);
            y = std::clamp(y / 100.0f, 0.0f, 1.0f);

            std::string title = rare ? rare->Name : quest->GetTitle();
            std::string objectives = rare ? "Убейте редкое существо." : quest->GetObjectives();
            int localeIndex = player->GetSession()->GetSessionDbLocaleIndex();
            if (rare && localeIndex >= 0)
                if (CreatureLocale const* locale = sObjectMgr->GetCreatureLocale(rare->Entry))
                    if (locale->Name.size() > uint8(localeIndex) && !locale->Name[uint8(localeIndex)].empty())
                        title = locale->Name[uint8(localeIndex)];
            if (!rare && localeIndex >= 0)
                if (QuestLocale const* locale = sObjectMgr->GetQuestLocale(questId))
                {
                    if (locale->Title.size() > uint8(localeIndex) && !locale->Title[uint8(localeIndex)].empty())
                        title = locale->Title[uint8(localeIndex)];
                    if (locale->Objectives.size() > uint8(localeIndex) && !locale->Objectives[uint8(localeIndex)].empty())
                        objectives = locale->Objectives[uint8(localeIndex)];
                }
            std::replace(title.begin(), title.end(), '|', '/');
            std::replace(title.begin(), title.end(), '\t', ' ');
            std::replace(objectives.begin(), objectives.end(), '|', '/');
            std::replace(objectives.begin(), objectives.end(), '\t', ' ');
            std::replace(objectives.begin(), objectives.end(), '\r', ' ');
            std::replace(objectives.begin(), objectives.end(), '\n', ' ');
            std::string objectiveProgress;
            std::string objectiveData;
            if (rare)
                objectiveProgress = entry.State == WorldQuestState::Active ? "Редкое существо: 0/1" : "Редкое существо: 0/1";
            else
            {
                for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
                    if (quest->RequiredNpcOrGoCount[i])
                    {
                        if (!objectiveProgress.empty()) objectiveProgress += "; ";
                        std::string label = quest->ObjectiveText[i].empty() ? "Цель" : quest->ObjectiveText[i];
                        objectiveProgress += fmt::format("{}: {}/{}", label,
                            std::min(entry.Progress[i], quest->RequiredNpcOrGoCount[i]), quest->RequiredNpcOrGoCount[i]);
                        if (!objectiveData.empty()) objectiveData += ";";
                        objectiveData += fmt::format("N:{},{},{}", quest->RequiredNpcOrGo[i], entry.Progress[i], quest->RequiredNpcOrGoCount[i]);
                    }
                for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
                    if (quest->RequiredItemCount[i])
                    {
                        if (!objectiveProgress.empty()) objectiveProgress += "; ";
                        std::string label = "Предмет";
                        if (ItemTemplate const* item = sObjectMgr->GetItemTemplate(quest->RequiredItemId[i]))
                            label = item->Name1;
                        objectiveProgress += fmt::format("{}: {}/{}", label,
                            std::min(player->GetItemCount(quest->RequiredItemId[i], true), quest->RequiredItemCount[i]),
                            quest->RequiredItemCount[i]);
                        if (!objectiveData.empty()) objectiveData += ";";
                        objectiveData += fmt::format("I:{},{},{}", quest->RequiredItemId[i],
                            player->GetItemCount(quest->RequiredItemId[i], true), quest->RequiredItemCount[i]);

                    }
            }
            std::replace(objectiveProgress.begin(), objectiveProgress.end(), '|', '/');
            if (rare)
                objectiveData = fmt::format("N:{},0,1", rare->Entry);
            handler->PSendSysMessage("WQ|Q|{}|{}|{}|{}|{}|{}|{}|{}|{:.5f}|{:.5f}|{}|{}|{}|{}|{}|{}|{}|{}", serial, questId,
                uint8(entry.State), entry.ExpiresAt, uint8(entry.Reward), entry.RewardId, entry.RewardAmount,
                zone, x, y, title, objectives, rare ? 1 : 0, uint8(entry.Reward2), entry.RewardId2, entry.RewardAmount2,
                objectiveProgress, objectiveData);

            // Item objectives and their creature sources are separate packets:
            // keeping them out of WQ|Q prevents the 3.3.5 chat packet limit from
            // truncating a quest that has many valid drop sources.
            if (!rare)
                for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
                    if (quest->RequiredItemCount[i])
                        if (QueryResult sources = WorldDatabase.Query(fmt::format(
                            "SELECT clt.Entry FROM creature_loot_template clt "
                            "WHERE clt.Item = {} AND clt.QuestRequired = 1 AND clt.Chance <> 0 "
                            "AND (ABS(clt.Chance) >= 5 OR NOT EXISTS ("
                            "SELECT 1 FROM gameobject_loot_template glt "
                            "JOIN gameobject_template gt ON gt.data1 = glt.Entry "
                            "WHERE glt.Item = clt.Item AND glt.QuestRequired = 1 AND ABS(glt.Chance) >= 50)) "
                            "GROUP BY clt.Entry ORDER BY MAX(ABS(clt.Chance)) DESC, clt.Entry LIMIT 32",
                            quest->RequiredItemId[i])))
                            do
                            {
                                handler->PSendSysMessage("WQ|L|{}|{}|{}|{}|{}", serial, questId,
                                    sources->Fetch()[0].Get<uint32>(),
                                    player->GetItemCount(quest->RequiredItemId[i], true), quest->RequiredItemCount[i]);
                            } while (sources->NextRow());

            // Send every quest POI point. The server already uses this set for
            // entering/leaving a world-quest area, so the client highlight now
            // describes the actual activation area instead of a guessed circle.
            if (!rare)
            {
                if (QuestPOIVector const* pois = sObjectMgr->GetQuestPOIVector(questId))
                {
                    uint32 sent = 0;
                    for (QuestPOI const& poi : *pois)
                        for (QuestPOIPoint const& point : poi.points)
                        {
                            float areaX = float(point.x);
                            float areaY = float(point.y);
                            Map2ZoneCoordinates(areaX, areaY, zone);
                            areaX = std::clamp(areaX / 100.0f, 0.0f, 1.0f);
                            areaY = std::clamp(areaY / 100.0f, 0.0f, 1.0f);
                            handler->PSendSysMessage("WQ|A|{}|{}|{:.5f}|{:.5f}", serial, questId, areaX, areaY);
                            if (++sent >= 48)
                                break;
                        }
                }
            }
            else
                handler->PSendSysMessage("WQ|A|{}|{}|{:.5f}|{:.5f}", serial, questId, x, y);
        }
        handler->PSendSysMessage("WQ|E|{}", serial);
    }

    float GetProgress(Player* player) const
    {
        uint32 total = 0;
        uint32 completed = 0;
        for (auto const& [questId, quest] : sObjectMgr->GetQuestTemplates())
        {
            if (!IsEligibleForPlayer(player, quest))
                continue;
            ++total;
            if (player->IsQuestRewarded(questId))
                ++completed;
        }
        return total ? float(completed) / float(total) : 0.0f;
    }

    float GetRefreshHours(Player* player) const
    {
        // Cadence grows in discrete one-percent steps and reaches its 2x cap at 50% completion.
        float percent = std::floor(GetProgress(player) * 100.0f) / 100.0f;
        float cappedProgress = std::min(percent, 0.50f);
        return Config.BaseRefreshHours / (1.0f + cappedProgress / 0.50f);
    }

    uint32 GetNextWave(Player* player) const
    {
        auto itr = _characters.find(player->GetGUID().GetCounter());
        return itr == _characters.end() ? 0 : itr->second.NextWaveAt;
    }

private:
    uint32 GetOtherWorldQuestItemRequirement(Player const* player, uint32 itemId, uint32 excludeQuestId) const
    {
        auto charItr = _characters.find(player->GetGUID().GetCounter());
        if (charItr == _characters.end())
            return 0;

        uint32 required = 0;
        uint32 now = Now();
        for (auto const& [questId, entry] : charItr->second.Entries)
        {
            if (questId == excludeQuestId || entry.State != WorldQuestState::Active || entry.ExpiresAt <= now ||
                GetRareTarget(questId))
                continue;

            Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
            if (!quest)
                continue;

            for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
                if (quest->RequiredItemId[i] == itemId)
                    required = std::max(required, quest->RequiredItemCount[i]);
        }
        return required;
    }

    void CleanupObjectiveItems(Player* player, Quest const* quest, uint32 worldQuestId, bool stale, bool expired) const
    {
        for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
        {
            uint32 itemId = quest->RequiredItemId[i];
            uint32 required = quest->RequiredItemCount[i];
            if (!itemId || !required)
                continue;

            ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemId);
            if (!itemTemplate)
                continue;

            bool questBound = itemTemplate->Bonding == BIND_QUEST_ITEM;
            if ((stale || expired) && !questBound)
                continue;

            bool nativeQuestNeedsItem = player->HasQuestForItem(itemId, 0, true);
            uint32 otherWorldQuestRequirement = GetOtherWorldQuestItemRequirement(player, itemId, worldQuestId);
            uint32 owned = player->GetItemCount(itemId, true);
            if (!owned)
                continue;

            uint32 removeCount = 0;
            if (stale)
            {
                // A completed/expired record is revisited at login only to remove
                // orphaned quest-bound leftovers. Never consume a newly needed item.
                if (!nativeQuestNeedsItem && !otherWorldQuestRequirement)
                    removeCount = owned;
            }
            else if (expired)
            {
                if (!nativeQuestNeedsItem && owned > otherWorldQuestRequirement)
                    removeCount = std::min(required, owned - otherWorldQuestRequirement);
            }
            else if (questBound && !quest->IsRepeatable() && !nativeQuestNeedsItem && !otherWorldQuestRequirement)
                removeCount = owned;
            else
                removeCount = std::min(required, owned);

            if (removeCount)
                player->DestroyItemCount(itemId, removeCount, true);
        }
    }

    void CheckAllActive(Player* player)
    {
        auto charItr = _characters.find(player->GetGUID().GetCounter());
        if (charItr == _characters.end())
            return;
        std::vector<uint32> ids;
        for (auto const& [id, entry] : charItr->second.Entries)
            if (entry.State == WorldQuestState::Active && !GetRareTarget(id))
                ids.push_back(id);
        for (uint32 id : ids)
        {
            auto itr = charItr->second.Entries.find(id);
            if (itr != charItr->second.Entries.end())
                CheckCompletion(player, itr->second);
        }
    }

    void CreditTarget(Player* player, int32 target)
    {
        auto charItr = _characters.find(player->GetGUID().GetCounter());
        if (charItr == _characters.end())
            return;
        std::vector<uint32> changed;
        for (auto& [id, entry] : charItr->second.Entries)
        {
            if (entry.State != WorldQuestState::Active || GetRareTarget(id))
                continue;
            Quest const* quest = sObjectMgr->GetQuestTemplate(id);
            if (!quest)
                continue;
            bool dirty = false;
            for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
                if (quest->RequiredNpcOrGo[i] == target && entry.Progress[i] < quest->RequiredNpcOrGoCount[i])
                {
                    ++entry.Progress[i];
                    dirty = true;
                }
            if (dirty)
            {
                SaveEntry(player, entry);
                changed.push_back(id);
            }
        }
        for (uint32 id : changed)
        {
            auto itr = charItr->second.Entries.find(id);
            if (itr != charItr->second.Entries.end())
                CheckCompletion(player, itr->second);
        }
        if (!changed.empty())
        {
            ChatHandler handler(player->GetSession());
            Sync(&handler, player);
        }
    }

    void CheckCompletion(Player* player, WorldQuestEntry& entry)
    {
        if (entry.State != WorldQuestState::Active)
            return;
        Quest const* quest = sObjectMgr->GetQuestTemplate(entry.QuestId);
        if (!quest)
            return;
        for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
            if (quest->RequiredNpcOrGoCount[i] && entry.Progress[i] < quest->RequiredNpcOrGoCount[i])
                return;
        for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
            if (quest->RequiredItemCount[i] && player->GetItemCount(quest->RequiredItemId[i], true) < quest->RequiredItemCount[i])
                return;
        Reward(player, entry);
    }

    void UpdateActivationByDistance(Player* player)
    {
        CharacterWorldQuests& data = _characters[player->GetGUID().GetCounter()];
        uint32 now = Now();
        std::vector<uint32> nearby;
        std::vector<uint32> departed;

        for (auto const& [questId, entry] : data.Entries)
        {
            if (entry.ExpiresAt <= now)
                continue;

            if (entry.State == WorldQuestState::Available)
            {
                if (RareTarget const* rare = GetRareTarget(questId))
                {
                    if (player->GetZoneId() == rare->Zone && player->GetDistance2d(rare->X, rare->Y) <= Config.ActivationRadius)
                        nearby.push_back(questId);
                }
                else if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
                {
                    if (player->GetZoneId() == uint32(quest->GetZoneOrSort()) && IsInsideQuestArea(player, quest, Config.ActivationRadius))
                        nearby.push_back(questId);
                }
            }
            else if (entry.State == WorldQuestState::Active)
            {
                bool inside = false;
                float leaveRadius = Config.ActivationRadius + 30.0f;
                if (RareTarget const* rare = GetRareTarget(questId))
                    inside = player->GetZoneId() == rare->Zone && player->GetDistance2d(rare->X, rare->Y) <= leaveRadius;
                else if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
                    inside = player->GetZoneId() == uint32(quest->GetZoneOrSort()) && IsInsideQuestArea(player, quest, leaveRadius);
                if (!inside)
                    departed.push_back(questId);
            }
        }

        bool activated = false;
        for (uint32 questId : departed)
        {
            auto itr = data.Entries.find(questId);
            if (itr == data.Entries.end() || itr->second.State != WorldQuestState::Active)
                continue;
            // State changes, but Progress stays intact for the next entry into the area.
            itr->second.State = WorldQuestState::Available;
            SaveState(player, itr->second);
            activated = true;
        }
        for (uint32 questId : nearby)
            if (Activate(player, questId))
            {
                ChatHandler(player->GetSession()).PSendSysMessage("Локальное задание автоматически принято.");
                activated = true;
            }
        if (activated)
        {
            RefreshVisualObjectives(player);
            ChatHandler handler(player->GetSession());
            Sync(&handler, player);
        }
    }

    bool IsInsideQuestArea(Player* player, Quest const* quest, float radius) const
    {
        if (QuestPOIVector const* pois = sObjectMgr->GetQuestPOIVector(quest->GetQuestId()))
            for (QuestPOI const& poi : *pois)
                for (QuestPOIPoint const& point : poi.points)
                    if (player->GetDistance2d(float(point.x), float(point.y)) <= radius)
                        return true;

        float x = 0.0f;
        float y = 0.0f;
        return GetQuestWorldPosition(quest, x, y) && player->GetDistance2d(x, y) <= radius;
    }

    bool ShouldProcess(Player const* player) const
    {
        return Config.Enabled && player && player->GetSession() &&
            (Config.IncludeBots || !player->GetSession()->IsBot());
    }

    void GenerateWave(Player* player, uint32 startsAt)
    {
        CharacterWorldQuests& data = _characters[player->GetGUID().GetCounter()];
        uint32 now = Now();
        uint32 cooldown = Config.CooldownHours * HOUR;
        std::vector<uint32> candidates;

        for (auto const& [questId, quest] : sObjectMgr->GetQuestTemplates())
        {
            if (!IsEligibleForPlayer(player, quest) || !player->IsQuestRewarded(questId))
                continue;

            auto itr = data.Entries.find(questId);
            if (itr != data.Entries.end())
            {
                WorldQuestEntry const& old = itr->second;
                if ((old.State == WorldQuestState::Available || old.State == WorldQuestState::Active) &&
                    old.ExpiresAt > now)
                    continue;
                if (old.CompletedAt && old.CompletedAt + cooldown > now)
                    continue;
            }
            candidates.push_back(questId);
        }

        float progress = GetProgress(player);
        uint32 progressPercent = std::min<uint32>(50, uint32(std::floor(progress * 100.0f)));
        // Three equal progression bands: 3 at 0%, 4 at 17%, 5 at 34%, 6 at 50%.
        uint32 scaledQuestCount = Config.QuestsPerWave +
            (Config.QuestsPerWave * progressPercent) / 50;
        uint32 count = std::min<uint32>(scaledQuestCount, candidates.size());
        for (uint32 i = 0; i < count; ++i)
        {
            uint32 index = urand(0, uint32(candidates.size() - 1));
            uint32 questId = candidates[index];
            candidates[index] = candidates.back();
            candidates.pop_back();

            WorldQuestEntry entry;
            entry.QuestId = questId;
            entry.State = WorldQuestState::Available;
            entry.StartsAt = startsAt;
            entry.ExpiresAt = startsAt + Config.DurationHours * HOUR;
            GenerateReward(entry);
            data.Entries[questId] = entry;
            SaveEntry(player, entry);
        }

        std::vector<RareTarget const*> rareCandidates;
        for (RareTarget const& rare : RareTargets)
        {
            uint32 id = RareQuestOffset + rare.Entry;
            auto itr = data.Entries.find(id);
            if (itr == data.Entries.end() ||
                (!((itr->second.State == WorldQuestState::Available || itr->second.State == WorldQuestState::Active) &&
                    itr->second.ExpiresAt > now) && (!itr->second.CompletedAt || itr->second.CompletedAt + cooldown <= now)))
                rareCandidates.push_back(&rare);
        }

        uint32 rareCount = std::min<uint32>(progressPercent >= 50 ? 2 : 1, rareCandidates.size());
        for (uint32 i = 0; i < rareCount; ++i)
        {
            uint32 index = urand(0, uint32(rareCandidates.size() - 1));
            RareTarget const* rare = rareCandidates[index];
            rareCandidates[index] = rareCandidates.back();
            rareCandidates.pop_back();
            WorldQuestEntry entry;
            entry.QuestId = RareQuestOffset + rare->Entry;
            entry.State = WorldQuestState::Available;
            entry.StartsAt = startsAt;
            entry.ExpiresAt = startsAt + Config.DurationHours * HOUR;
            GenerateReward(entry);
            RewardType first = entry.Reward;
            do
            {
                WorldQuestEntry second;
                GenerateReward(second);
                entry.Reward2 = second.Reward;
                entry.RewardId2 = second.RewardId;
                entry.RewardAmount2 = second.RewardAmount;
            } while (entry.Reward2 == first);
            data.Entries[entry.QuestId] = entry;
            SaveEntry(player, entry);
        }
    }

    void GenerateReward(WorldQuestEntry& entry) const
    {
        uint32 totalWeight = 0;
        for (uint32 weight : Config.RewardWeights)
            totalWeight += weight;

        uint32 roll = totalWeight ? urand(1, totalWeight) : 1;
        uint32 cumulative = 0;
        uint32 category = 3;
        for (uint32 i = 0; i < Config.RewardWeights.size(); ++i)
        {
            cumulative += Config.RewardWeights[i];
            if (roll <= cumulative)
            {
                category = i;
                break;
            }
        }

        entry.Reward = RewardType(category);
        switch (entry.Reward)
        {
            case RewardType::Emblem:
                if (Config.EmblemItems.empty())
                {
                    entry.Reward = RewardType::Gold;
                    entry.RewardAmount = 125 + 25 * urand(0, 17);
                    break;
                }
                entry.RewardId = Config.EmblemItems[urand(0, uint32(Config.EmblemItems.size() - 1))];
                entry.RewardAmount = urand(1, 3);
                break;
            case RewardType::Arena:
                entry.RewardAmount = 125 + 25 * urand(0, 15);
                break;
            case RewardType::Honor:
                entry.RewardAmount = 3000 + 500 * urand(0, 14);
                break;
            case RewardType::Gold:
                entry.RewardAmount = 125 + 25 * urand(0, 17);
                break;
        }
    }

    void Reward(Player* player, WorldQuestEntry& entry)
    {
        if (entry.State != WorldQuestState::Active)
            return;

        uint32 now = Now();
        if (entry.NextRewardRetryAt > now)
            return;

        std::string failure;
        if (!CanPayReward(player, entry.Reward, entry.RewardId, entry.RewardAmount, failure) ||
            (GetRareTarget(entry.QuestId) && !CanPayReward(player, entry.Reward2, entry.RewardId2, entry.RewardAmount2, failure)))
        {
            entry.NextRewardRetryAt = now + 30;
            ChatHandler(player->GetSession()).PSendSysMessage(
                "Локальное задание выполнено, но награда пока не выдана: {}. Освободите лимит и повторите попытку через 30 секунд.",
                failure);
            LOG_WARN("module.worldquests", "World quest reward blocked: guid={} quest={} reason={}",
                player->GetGUID().GetCounter(), entry.QuestId, failure);
            return;
        }

        if (GetRareTarget(entry.QuestId))
        {
            entry.State = WorldQuestState::Completing;
            SaveState(player, entry);
            bool firstPaid = PayReward(player, entry.Reward, entry.RewardId, entry.RewardAmount);
            bool secondPaid = firstPaid && PayReward(player, entry.Reward2, entry.RewardId2, entry.RewardAmount2);
            if (!firstPaid || !secondPaid)
            {
                if (!firstPaid)
                {
                    entry.State = WorldQuestState::Active;
                    SaveState(player, entry);
                }
                ChatHandler(player->GetSession()).SendSysMessage(
                    "Ошибка подтверждения награды локального задания. Повторная выдача заблокирована; обратитесь к администратору.");
                LOG_ERROR("module.worldquests", "World quest reward confirmation failed: guid={} quest={} firstPaid={} secondPaid={}",
                    player->GetGUID().GetCounter(), entry.QuestId, firstPaid, secondPaid);
                return;
            }
            entry.State = WorldQuestState::Completed;
            entry.CompletedAt = now;
            SaveState(player, entry);
            RefreshVisualObjectives(player);
            ChatHandler(player->GetSession()).PSendSysMessage(
                "Редкое локальное задание завершено. Награды получены: {}; {}.",
                DescribeReward(entry.Reward, entry.RewardId, entry.RewardAmount),
                DescribeReward(entry.Reward2, entry.RewardId2, entry.RewardAmount2));
            LOG_INFO("module.worldquests", "Rare world quest reward delivered: guid={} quest={} reward1Type={} reward1Id={} reward1Amount={} reward2Type={} reward2Id={} reward2Amount={}",
                player->GetGUID().GetCounter(), entry.QuestId, uint8(entry.Reward), entry.RewardId, entry.RewardAmount,
                uint8(entry.Reward2), entry.RewardId2, entry.RewardAmount2);
            ChatHandler handler(player->GetSession());
            Sync(&handler, player);
            return;
        }

        Quest const* quest = sObjectMgr->GetQuestTemplate(entry.QuestId);
        if (!quest)
            return;

        entry.State = WorldQuestState::Completing;
        SaveState(player, entry);
        if (!PayReward(player, entry.Reward, entry.RewardId, entry.RewardAmount))
        {
            entry.State = WorldQuestState::Active;
            entry.NextRewardRetryAt = now + 30;
            SaveState(player, entry);
            ChatHandler(player->GetSession()).SendSysMessage(
                "Награда локального задания не была выдана; задание осталось активным для безопасного повтора.");
            LOG_ERROR("module.worldquests", "World quest reward confirmation failed without delivery: guid={} quest={}",
                player->GetGUID().GetCounter(), entry.QuestId);
            return;
        }

        CleanupObjectiveItems(player, quest, entry.QuestId, false, false);
        entry.State = WorldQuestState::Completed;
        entry.CompletedAt = now;
        SaveState(player, entry);
        RefreshVisualObjectives(player);
        ChatHandler(player->GetSession()).PSendSysMessage(
            "Локальное задание завершено: {}. Награда получена: {}.", quest->GetTitle(),
            DescribeReward(entry.Reward, entry.RewardId, entry.RewardAmount));
        LOG_INFO("module.worldquests", "World quest reward delivered: guid={} quest={} rewardType={} rewardId={} rewardAmount={}",
            player->GetGUID().GetCounter(), entry.QuestId, uint8(entry.Reward), entry.RewardId, entry.RewardAmount);
        ChatHandler handler(player->GetSession());
        Sync(&handler, player);
    }

    bool CanPayReward(Player* player, RewardType type, uint32 id, uint32 amount, std::string& failure) const
    {
        if (!amount)
        {
            failure = "некорректный размер награды";
            return false;
        }

        switch (type)
        {
            case RewardType::Emblem:
            {
                if (!id || !sObjectMgr->GetItemTemplate(id))
                {
                    failure = "некорректный предмет награды";
                    return false;
                }
                ItemPosCountVec destination;
                if (player->CanStoreNewItem(NULL_BAG, NULL_SLOT, destination, id, amount) != EQUIP_ERR_OK)
                {
                    failure = "не хватает места в сумках";
                    return false;
                }
                return true;
            }
            case RewardType::Arena:
            {
                uint32 maximum = uint32(sWorld->getIntConfig(CONFIG_MAX_ARENA_POINTS));
                if (player->GetArenaPoints() > maximum || amount > maximum - player->GetArenaPoints())
                {
                    failure = "достигнут лимит очков арены";
                    return false;
                }
                return true;
            }
            case RewardType::Honor:
            {
                uint32 maximum = uint32(sWorld->getIntConfig(CONFIG_MAX_HONOR_POINTS));
                if (player->GetHonorPoints() > maximum || amount > maximum - player->GetHonorPoints())
                {
                    failure = "достигнут лимит очков чести";
                    return false;
                }
                return true;
            }
            case RewardType::Gold:
            {
                uint64 copper = uint64(amount) * GOLD;
                if (copper > uint64(MAX_MONEY_AMOUNT - player->GetMoney()))
                {
                    failure = "достигнут лимит золота";
                    return false;
                }
                return true;
            }
        }

        failure = "неизвестный тип награды";
        return false;
    }

    bool PayReward(Player* player, RewardType type, uint32 id, uint32 amount) const
    {
        switch (type)
        {
            case RewardType::Emblem:
                return id && amount && player->AddItem(id, amount);
            case RewardType::Arena:
            {
                uint32 before = player->GetArenaPoints();
                player->ModifyArenaPoints(amount);
                return player->GetArenaPoints() == before + amount;
            }
            case RewardType::Honor:
            {
                uint32 before = player->GetHonorPoints();
                player->ModifyHonorPoints(amount);
                return player->GetHonorPoints() == before + amount;
            }
            case RewardType::Gold:
                return player->ModifyMoney(int32(amount * GOLD));
        }
        return false;
    }

    std::string DescribeReward(RewardType type, uint32 id, uint32 amount) const
    {
        switch (type)
        {
            case RewardType::Emblem:
                if (ItemTemplate const* item = sObjectMgr->GetItemTemplate(id))
                    return fmt::format("{} x{}", item->Name1, amount);
                return fmt::format("предмет {} x{}", id, amount);
            case RewardType::Arena:
                return fmt::format("{} очков арены", amount);
            case RewardType::Honor:
                return fmt::format("{} очков чести", amount);
            case RewardType::Gold:
                return fmt::format("{} золота", amount);
        }
        return "неизвестная награда";
    }

    void SaveEntry(Player* player, WorldQuestEntry const& entry) const
    {
        CharacterDatabase.Execute(
            "REPLACE INTO character_world_quest "
            "(guid, quest, state, startsAt, expiresAt, rewardType, rewardId, rewardAmount, completedAt, "
            "rewardType2, rewardId2, rewardAmount2, progress0, progress1, progress2, progress3) "
            "VALUES ({}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {})",
            player->GetGUID().GetCounter(), entry.QuestId, uint8(entry.State), entry.StartsAt, entry.ExpiresAt,
            uint8(entry.Reward), entry.RewardId, entry.RewardAmount, entry.CompletedAt, uint8(entry.Reward2),
            entry.RewardId2, entry.RewardAmount2, entry.Progress[0], entry.Progress[1], entry.Progress[2], entry.Progress[3]);
    }

    void SaveState(Player* player, WorldQuestEntry const& entry) const
    {
        CharacterDatabase.Execute(
            "UPDATE character_world_quest SET state = {}, completedAt = {} WHERE guid = {} AND quest = {}",
            uint8(entry.State), entry.CompletedAt, player->GetGUID().GetCounter(), entry.QuestId);
    }

    void SaveSchedule(Player* player, uint32 nextWaveAt) const
    {
        CharacterDatabase.Execute(
            "REPLACE INTO character_world_quest_schedule (guid, nextWaveAt) VALUES ({}, {})",
            player->GetGUID().GetCounter(), nextWaveAt);
    }

    std::unordered_map<uint32, CharacterWorldQuests> _characters;
};

class NorthrendWorldQuestWorldScript : public WorldScript
{
public:
    NorthrendWorldQuestWorldScript() : WorldScript("NorthrendWorldQuestWorldScript", {
        WORLDHOOK_ON_AFTER_CONFIG_LOAD }) { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        Config.Enabled = sConfigMgr->GetOption<bool>("WorldQuests.Enable", true);
        Config.Announce = sConfigMgr->GetOption<bool>("WorldQuests.Announce", true);
        Config.IncludeBots = sConfigMgr->GetOption<bool>("WorldQuests.IncludeBots", false);
        Config.QuestsPerWave = std::max<uint32>(1, sConfigMgr->GetOption<uint32>("WorldQuests.QuestsPerWave", 3));
        Config.DurationHours = std::max<uint32>(1, sConfigMgr->GetOption<uint32>("WorldQuests.DurationHours", 24));
        Config.BaseRefreshHours = std::max(1.0f, sConfigMgr->GetOption<float>("WorldQuests.BaseRefreshHours", 6.0f));
        Config.CooldownHours = sConfigMgr->GetOption<uint32>("WorldQuests.CooldownHours", 72);
        Config.ActivationRadius = std::max(1.0f, sConfigMgr->GetOption<float>("WorldQuests.ActivationRadius", 200.0f));
        Config.RewardWeights[0] = sConfigMgr->GetOption<uint32>("WorldQuests.EmblemWeight", 1);
        Config.RewardWeights[1] = sConfigMgr->GetOption<uint32>("WorldQuests.ArenaWeight", 1);
        Config.RewardWeights[2] = sConfigMgr->GetOption<uint32>("WorldQuests.HonorWeight", 1);
        Config.RewardWeights[3] = sConfigMgr->GetOption<uint32>("WorldQuests.GoldWeight", 1);
        Config.EmblemItems = ParseItemList(
            sConfigMgr->GetOption<std::string>("WorldQuests.EmblemItems", "49426,47241,45624,40753,40752"));
    }
};

class NorthrendWorldQuestPlayerScript : public PlayerScript
{
public:
    NorthrendWorldQuestPlayerScript() : PlayerScript("NorthrendWorldQuestPlayerScript", {
        PLAYERHOOK_ON_LOGIN,
        PLAYERHOOK_ON_LOGOUT,
        PLAYERHOOK_ON_QUEST_ABANDON,
        PLAYERHOOK_ON_CREATURE_KILL,
        PLAYERHOOK_ON_CREATURE_KILLED_BY_PET,
        PLAYERHOOK_ON_HAS_QUEST_FOR_ITEM,
        PLAYERHOOK_ON_LOOT_ITEM,
        PLAYERHOOK_ON_STORE_NEW_ITEM,
        PLAYERHOOK_ON_SPELL_CAST,
        PLAYERHOOK_ON_UPDATE }) { }

    void OnPlayerLogin(Player* player) override
    {
        NorthrendWorldQuestMgr::Instance().Load(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        NorthrendWorldQuestMgr::Instance().Unload(player);
    }

    void OnPlayerQuestAbandon(Player* player, uint32 questId) override
    {
        NorthrendWorldQuestMgr::Instance().Abandon(player, questId);
    }

    void OnPlayerCreatureKill(Player* player, Creature* killed) override
    {
        if (player && killed)
            NorthrendWorldQuestMgr::Instance().CreatureKilled(player, killed->GetEntry());
    }

    void OnPlayerCreatureKilledByPet(Player* player, Creature* killed) override
    {
        if (player && killed)
            NorthrendWorldQuestMgr::Instance().CreatureKilled(player, killed->GetEntry());
    }

    bool OnPlayerHasQuestForItem(Player const* player, uint32 itemId, bool* showInLoot) override
    {
        return NorthrendWorldQuestMgr::Instance().HasQuestForItem(player, itemId, showInLoot);
    }

    void OnPlayerLootItem(Player* player, Item* /*item*/, uint32 /*count*/, ObjectGuid /*lootGuid*/) override
    {
        NorthrendWorldQuestMgr::Instance().ItemCollected(player);
    }

    void OnPlayerStoreNewItem(Player* player, Item* /*item*/, uint32 /*count*/) override
    {
        NorthrendWorldQuestMgr::Instance().ItemCollected(player);
    }

    void OnPlayerSpellCast(Player* player, Spell* spell, bool /*skipCheck*/) override
    {
        NorthrendWorldQuestMgr::Instance().SpellCast(player, spell);
    }

    void OnPlayerUpdate(Player* player, uint32 /*diff*/) override
    {
        NorthrendWorldQuestMgr::Instance().Update(player);
    }
};

class NorthrendWorldQuestGameObjectScript : public AllGameObjectScript
{
public:
    NorthrendWorldQuestGameObjectScript() : AllGameObjectScript("NorthrendWorldQuestGameObjectScript") { }

    void OnGameObjectLootStateChanged(GameObject* go, uint32 /*state*/, Unit* unit) override
    {
        if (go && unit)
            if (Player* player = unit->ToPlayer())
                NorthrendWorldQuestMgr::Instance().GameObjectUsed(player, go->GetEntry());
    }
};

class NorthrendWorldQuestCommands : public CommandScript
{
public:
    NorthrendWorldQuestCommands() : CommandScript("NorthrendWorldQuestCommands") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable worldQuestCommands = {
            { "status", HandleStatus, 0, Console::No },
            { "list", HandleList, 0, Console::No },
            { "sync", HandleSync, 0, Console::No },
            { "activate", HandleActivate, 0, Console::No },
            { "refresh", HandleRefresh, rbac::RBAC_PERM_COMMAND_QUEST_ADD, Console::No }
        };
        static ChatCommandTable commandTable = {
            { "wq", worldQuestCommands }
        };
        return commandTable;
    }

    static bool HandleStatus(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        auto [available, active] = NorthrendWorldQuestMgr::Instance().CountCurrent(player);
        float progress = NorthrendWorldQuestMgr::Instance().GetProgress(player);
        uint32 next = NorthrendWorldQuestMgr::Instance().GetNextWave(player);
        handler->PSendSysMessage(
            "Northrend progress: {:.1f}%, cadence: {:.2f} h, available: {}, active: {}, next: {} min.",
            progress * 100.0f, NorthrendWorldQuestMgr::Instance().GetRefreshHours(player), available, active,
            next > Now() ? (next - Now()) / MINUTE : 0);
        return true;
    }

    static bool HandleList(ChatHandler* handler)
    {
        NorthrendWorldQuestMgr::Instance().List(handler, handler->GetPlayer());
        return true;
    }

    static bool HandleSync(ChatHandler* handler)
    {
        NorthrendWorldQuestMgr::Instance().Sync(handler, handler->GetPlayer());
        return true;
    }

    static bool HandleActivate(ChatHandler* handler, uint32 questId)
    {
        if (!NorthrendWorldQuestMgr::Instance().Activate(handler->GetPlayer(), questId))
            handler->SendSysMessage("Unable to activate that world quest.");
        return true;
    }

    static bool HandleRefresh(ChatHandler* handler)
    {
        NorthrendWorldQuestMgr::Instance().ForceRefresh(handler->GetPlayer());
        handler->SendSysMessage("World-quest wave generated.");
        return true;
    }
};
}

void AddNorthrendWorldQuestScripts()
{
    new NorthrendWorldQuestWorldScript();
    new NorthrendWorldQuestPlayerScript();
    new NorthrendWorldQuestGameObjectScript();
    new NorthrendWorldQuestCommands();
}
