/* JestokyCraft Hardcore. GPL-2.0-or-later. */
#include "Chat.h"
#include "CommandScript.h"
#include "ObjectAccessor.h"
#include "Group.h"
#include "Pet.h"
#include "Player.h"
#include "PlayerScript.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "WorldScript.h"
#include "WorldSession.h"

#include <stdexcept>

using namespace Acore::ChatCommands;

namespace
{
constexpr uint32 HardcorePermission = 1010;
constexpr uint32 HardcoreStatusSpell = 85005;

// The aura displays durable state; it never grants enrollment or another life.
void SyncHardcoreStatus(Player* player)
{
    if (player->GetSession()->IsBot())
        return;
    if (player->IsHardcore())
    {
        if (!player->HasAura(HardcoreStatusSpell))
            player->AddAura(HardcoreStatusSpell, player);
    }
    else
        player->RemoveAurasDueToSpell(HardcoreStatusSpell);

    uint8 reserved = 0;
    for (uint8 pact = 1; pact <= 12; ++pact)
    {
        uint32 spell = 85009 + pact;
        if (player->HasHardcorePact(pact))
        {
            if (pact <= 6)
                ++reserved;
            if (!player->HasAura(spell))
                player->AddAura(spell, player);
        }
        else
            player->RemoveAurasDueToSpell(spell);
    }
    for (uint8 count = 1; count <= 4; ++count)
    {
        uint32 spell = 85021 + count;
        if (reserved != count)
            player->RemoveAurasDueToSpell(spell);
        else if (!player->HasAura(spell))
            player->AddAura(spell, player);
    }
    if (Pet* pet = player->GetPet())
        for (uint8 index = 0; index < 2; ++index)
        {
            uint32 spell = 85026 + index;
            if (player->HasHardcorePact(index ? 12 : 3))
            {
                if (!pet->HasAura(spell))
                    player->AddAura(spell, pet);
            }
            else
                pet->RemoveAurasDueToSpell(spell);
        }
}

char const* StateText(uint8 state)
{
    switch (state)
    {
        case 1: return "Активен. У вас одна жизнь.";
        case 2: return "Персонаж погиб. Попытка завершена навсегда.";
        case 3: return "Хардкор завершён после смерти. Теперь обычный персонаж.";
        case 4: return "Вы добровольно отказались от Хардкора.";
        default: return "Обычный персонаж.";
    }
}

class HardcoreWorldScript : public WorldScript
{
public:
    HardcoreWorldScript() : WorldScript("HardcoreWorldScript", {WORLDHOOK_ON_STARTUP}) { }

    void OnStartup() override
    {
        Player::InitializeHardcoreJournal();
        SpellInfo const* spell = sSpellMgr->GetSpellInfo(HardcoreStatusSpell);
        if (!spell || spell->IsPositive() || !spell->IsDeathPersistent() || spell->GetDuration() != -1 ||
            !spell->HasAttribute(SPELL_ATTR2_ALLOW_DEAD_TARGET) ||
            spell->Dispel != DISPEL_NONE || !(spell->Attributes & SPELL_ATTR0_NO_AURA_CANCEL) ||
            spell->Effects[EFFECT_0].Effect != SPELL_EFFECT_APPLY_AURA ||
            spell->Effects[EFFECT_0].ApplyAuraName != SPELL_AURA_DUMMY)
            throw std::runtime_error("Hardcore requires the matching persistent harmful status Spell.dbc (85005)");
        for (uint32 id = 85010; id <= 85027; ++id)
        {
            SpellInfo const* pact = sSpellMgr->GetSpellInfo(id);
            if (!pact || pact->IsPositive() || !pact->IsDeathPersistent() || pact->GetDuration() != -1 ||
                !pact->HasAttribute(SPELL_ATTR2_ALLOW_DEAD_TARGET) || pact->Dispel != DISPEL_NONE ||
                !(pact->Attributes & SPELL_ATTR0_NO_AURA_CANCEL))
                throw std::runtime_error("Hardcore requires the matching pact Spell.dbc (85010..85027)");
        }
    }
};

class HardcorePlayerScript : public PlayerScript
{
public:
    HardcorePlayerScript() : PlayerScript("HardcorePlayerScript",
        {PLAYERHOOK_ON_LOGIN, PLAYERHOOK_ON_UPDATE, PLAYERHOOK_ON_PLAYER_JUST_DIED, PLAYERHOOK_CAN_GROUP_INVITE,
         PLAYERHOOK_CAN_GROUP_ACCEPT, PLAYERHOOK_CAN_JOIN_LFG, PLAYERHOOK_CAN_INIT_TRADE,
         PLAYERHOOK_CAN_SEND_MAIL, PLAYERHOOK_CAN_JOIN_IN_BATTLEGROUND_QUEUE,
         PLAYERHOOK_CAN_JOIN_IN_ARENA_QUEUE, PLAYERHOOK_ON_DUEL_REQUEST, PLAYERHOOK_ON_DUEL_START}) { }

    void OnPlayerLogin(Player* player) override
    {
        if (player->GetSession()->IsBot())
            return;
        if (player->IsHardcoreFallen() && player->IsAlive())
        {
            player->SetHealth(0);
            player->setDeathState(DeathState::JustDied);
            player->KillPlayer();
            player->BuildPlayerRepop();
        }
        ChatHandler handler(player->GetSession());
        SyncHardcoreStatus(player);
        handler.PSendSysMessage("Хардкор: {}", StateText(player->GetHardcoreState()));
        if (player->IsHardcore())
            handler.SendSysMessage("Одна жизнь. Выбранные пакты действуют до завершения Хардкора.");
    }

    void OnPlayerUpdate(Player* player, uint32) override
    {
        if (player->IsInWorld())
            SyncHardcoreStatus(player);
    }

    void OnPlayerJustDied(Player* player) override
    {
        if (player->IsHardcoreFallen())
            ChatHandler(player->GetSession()).SendSysMessage("Хардкор: ваша попытка окончена. Воскрешение запрещено.");
    }

    bool OnPlayerCanGroupInvite(Player* player, std::string& name) override
    {
        Player* target = ObjectAccessor::FindPlayerByName(name, false);
        if (!player->IsHardcore() && (!target || !target->IsHardcore()))
            return true;
        return target && CanGroup(player, target);
    }

    static bool CanGroup(Player* player, Player* target)
    {
        if (!player->IsHardcore() && !target->IsHardcore())
            return true;
        return player->IsHardcore() && target->IsHardcore() && player->IsAlive() && target->IsAlive() &&
            !player->IsHardcoreFallen() && !target->IsHardcoreFallen() && !player->IsSolitary() && !target->IsSolitary();
    }

    bool OnPlayerCanGroupAccept(Player* player, Group* group) override
    {
        for (auto const& member : group->GetMemberSlots())
        {
            Player* target = ObjectAccessor::FindConnectedPlayer(member.guid);
            if (target ? !CanGroup(player, target) : (player->IsHardcore() || Player::IsHardcoreCharacter(member.guid)))
                return false;
        }
        return true;
    }

    void OnPlayerDuelRequest(Player* target, Player* challenger) override
    {
        if (target->IsHardcore() || challenger->IsHardcore())
            target->DuelComplete(DUEL_INTERRUPTED);
    }

    void OnPlayerDuelStart(Player* first, Player* second) override
    {
        if (first->IsHardcore() || second->IsHardcore())
            first->DuelComplete(DUEL_INTERRUPTED);
    }
    bool OnPlayerCanJoinLfg(Player* player, uint8, std::set<uint32>&, std::string const&) override
    {
        return !player->IsHardcore();
    }

    bool OnPlayerCanInitTrade(Player* player, Player* target) override
    {
        if (!player->IsHardcore() && !target->IsHardcore())
            return true;
        return player->IsHardcore() && target->IsHardcore() && player->IsAlive() && target->IsAlive() &&
            !player->IsHardcoreFallen() && !target->IsHardcoreFallen();
    }

    bool OnPlayerCanSendMail(Player* player, ObjectGuid, ObjectGuid, std::string&, std::string&,
        uint32, uint32, Item*) override { return !player->IsHardcore(); }

    bool OnPlayerCanJoinInBattlegroundQueue(Player* player, ObjectGuid, BattlegroundTypeId, uint8,
        GroupJoinBattlegroundResult& error) override
    {
        if (!player->IsHardcore())
            return true;
        error = ERR_GROUP_JOIN_BATTLEGROUND_FAIL;
        return false;
    }

    bool OnPlayerCanJoinInArenaQueue(Player* player, ObjectGuid, uint8, BattlegroundTypeId, uint8, uint8,
        GroupJoinBattlegroundResult& error) override
    {
        if (!player->IsHardcore())
            return true;
        error = ERR_GROUP_JOIN_BATTLEGROUND_FAIL;
        return false;
    }
};

class HardcoreCommands : public CommandScript
{
public:
    HardcoreCommands() : CommandScript("HardcoreCommands") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable leave = {{"confirm", ConfirmLeave, HardcorePermission, Console::No}};
        static ChatCommandTable actions =
        {
            {"status", Status, HardcorePermission, Console::No},
            {"leave", leave}
        };
        static ChatCommandTable commands = {{"hardcore", actions}};
        return commands;
    }

    static bool Status(ChatHandler* handler)
    {
        handler->PSendSysMessage("Хардкор: {}", StateText(handler->GetPlayer()->GetHardcoreState()));
        handler->SendSysMessage("Одна жизнь. Пакты неизменны до выхода из режима. Почта, аукцион и банк гильдии недоступны.");
        handler->SendSysMessage("Необратимый выход: .hardcore leave confirm. Живым — только в зоне отдыха вне боя.");
        return true;
    }

    static bool ConfirmLeave(ChatHandler* handler)
    {
        if (!handler->GetPlayer()->LeaveHardcore())
        {
            handler->SendErrorMessage("Выход не выполнен. Живым требуется зона отдыха и отсутствие боя.");
            return false;
        }
        SyncHardcoreStatus(handler->GetPlayer());
        handler->SendSysMessage("Хардкор завершён без возможности возврата. Доступна обычная игра и воскрешение.");
        return true;
    }
};
}

void AddHardcoreScripts()
{
    new HardcoreWorldScript();
    new HardcorePlayerScript();
    new HardcoreCommands();
}
