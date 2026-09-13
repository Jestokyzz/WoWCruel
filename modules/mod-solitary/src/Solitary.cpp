#include "AllBattlegroundScript.h"
#include "Battleground.h"
#include "BattlegroundQueue.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Group.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "PlayerScript.h"
#include "RandomPlayerbotMgr.h"
#include "RBAC.h"
#include "UnitScript.h"
#include "WorldSession.h"

#include <algorithm>
#include <limits>

using namespace Acore::ChatCommands;

namespace
{
bool IsStrictPveInstance(Unit const* unit)
{
    return unit && unit->GetMap() && unit->GetMap()->IsDungeon() && !unit->GetMap()->IsBattlegroundOrArena();
}

bool GroupContainsSolitary(Group* group)
{
    if (!group)
        return false;

    bool result = false;
    group->DoForAllMembers([&result](Player* member)
    {
        result = result || member->IsSolitary();
    });
    return result;
}

bool PoolContainsSolitary(BattlegroundQueue const* queue)
{
    for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
        for (GroupQueueInfo const* selected : queue->m_SelectionPools[team].SelectedGroups)
            if (selected->IsSolitary)
                return true;

    return false;
}

bool PoolContainsRealPlayer(BattlegroundQueue const* queue)
{
    for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
        for (GroupQueueInfo const* selected : queue->m_SelectionPools[team].SelectedGroups)
            if (selected->HasRealPlayer)
                return true;

    return false;
}

class SolitaryPlayerScript : public PlayerScript
{
public:
    SolitaryPlayerScript() : PlayerScript("SolitaryPlayerScript",
        { PLAYERHOOK_CAN_JOIN_IN_BATTLEGROUND_QUEUE, PLAYERHOOK_CAN_JOIN_IN_ARENA_QUEUE,
            PLAYERHOOK_CAN_GROUP_INVITE, PLAYERHOOK_CAN_GROUP_ACCEPT,
            PLAYERHOOK_CAN_JOIN_LFG }) { }

    void OnPlayerRequestSolitaryArenaAssistants(Player* player, ObjectGuid battlemasterGuid,
        uint8 arenaSlot, uint8 teamSize, bool rated) override
    {
        if (player && player->IsSolitary())
            sRandomPlayerbotMgr.RequestSolitaryArenaAssistants(player, battlemasterGuid, arenaSlot, teamSize, rated);
    }

    bool OnPlayerCanJoinInBattlegroundQueue(Player* player, ObjectGuid, BattlegroundTypeId, uint8 joinAsGroup,
        GroupJoinBattlegroundResult& error) override
    {
        if (player->IsSolitary())
            sRandomPlayerbotMgr.RequestImmediateBgQueueCheck();

        if (!player->IsSolitary() || !joinAsGroup)
            return true;

        error = ERR_GROUP_JOIN_BATTLEGROUND_FAIL;
        return false;
    }

    bool OnPlayerCanGroupInvite(Player* player, std::string& memberName) override
    {
        Player* invited = ObjectAccessor::FindPlayerByName(memberName, false);
        if (!player->IsSolitary() && (!invited || !invited->IsSolitary()))
            return true;

        ChatHandler(player->GetSession()).SendNotification("Вы находитесь в режиме \"Одиночка\" и не можете вступать в группы или приглашать других игроков.");
        if (invited && invited->IsSolitary() && invited != player)
            ChatHandler(invited->GetSession()).SendNotification("Игрок находится в режиме \"Одиночка\" и не может вступать в группы.");
        return false;
    }

    bool OnPlayerCanGroupAccept(Player* player, Group* group) override
    {
        if (!player->IsSolitary() && !GroupContainsSolitary(group))
            return true;

        ChatHandler(player->GetSession()).SendNotification("Вы находитесь в режиме \"Одиночка\" и не можете вступать в группы.");
        return false;
    }

    bool OnPlayerCanJoinLfg(Player* player, uint8, std::set<uint32>&, std::string const&) override
    {
        if (player->IsSolitary())
            sRandomPlayerbotMgr.RequestImmediateLfgQueueCheck();
        return true;
    }
};

class SolitaryDamageScript : public UnitScript
{
public:
    SolitaryDamageScript() : UnitScript("SolitaryDamageScript", true,
        { UNITHOOK_MODIFY_PERIODIC_DAMAGE_AURAS_TICK,
            UNITHOOK_MODIFY_MELEE_DAMAGE, UNITHOOK_MODIFY_SPELL_DAMAGE_TAKEN }) { }

    void ModifyPeriodicDamageAurasTick(Unit* target, Unit* attacker, uint32& damage, SpellInfo const*) override
    {
        ApplySolitaryDamage(attacker, target, damage);
    }

    void ModifyMeleeDamage(Unit* target, Unit* attacker, uint32& damage) override
    {
        ApplySolitaryDamage(attacker, target, damage);
    }

    void ModifySpellDamageTaken(Unit* target, Unit* attacker, int32& damage, SpellInfo const*) override
    {
        if (damage <= 0)
            return;

        uint32 unsignedDamage = static_cast<uint32>(damage);
        ApplySolitaryDamage(attacker, target, unsignedDamage);
        damage = static_cast<int32>(std::min<uint32>(unsignedDamage, std::numeric_limits<int32>::max()));
    }

private:
    static void ApplySolitaryDamage(Unit* attacker, Unit* victim, uint32& damage)
    {
        if (!damage || !IsStrictPveInstance(victim))
            return;

        Player* sourcePlayer = attacker ? attacker->GetCharmerOrOwnerPlayerOrPlayerItself() : nullptr;
        Player* targetPlayer = victim->GetCharmerOrOwnerPlayerOrPlayerItself();

        // The multipliers are PvE-only even inside an instance. This prevents
        // duels and player-controlled pets from inheriting raid scaling.
        if (sourcePlayer && sourcePlayer->IsSolitary() && !targetPlayer)
        {
            uint64 scaled = uint64(damage) * 10;
            damage = uint32(std::min<uint64>(scaled, std::numeric_limits<uint32>::max()));
        }

        if (targetPlayer && targetPlayer->IsSolitary() && !sourcePlayer)
            damage = std::max<uint32>(1, (damage + 9) / 10);
    }
};

class SolitaryBattlegroundScript : public AllBattlegroundScript
{
public:
    SolitaryBattlegroundScript() : AllBattlegroundScript("SolitaryBattlegroundScript",
        { ALLBATTLEGROUNDHOOK_CAN_ADD_GROUP_TO_MATCHING_POOL,
            ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_END, ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_DESTROY }) { }

    void OnBattlegroundEnd(Battleground* battleground, TeamId) override
    {
        ReleaseActivityBots(battleground);
    }

    void OnBattlegroundDestroy(Battleground* battleground) override
    {
        ReleaseActivityBots(battleground);
    }

    bool CanAddGroupToMatchingPool(BattlegroundQueue* queue, GroupQueueInfo* group, uint32,
        Battleground* battleground, BattlegroundBracketId) override
    {
        if (!group->HasRealPlayer)
            return true;

        if (group->IsSolitary)
        {
            if (battleground && (battleground->IsSolitaryCohort() || battleground->HasStandardPlayerCohort()))
                return false;
            return !PoolContainsRealPlayer(queue);
        }

        if ((battleground && battleground->IsSolitaryCohort()) || PoolContainsSolitary(queue))
            return false;

        return true;
    }

private:
    static void ReleaseActivityBots(Battleground* battleground)
    {
        if (!battleground)
            return;

        for (auto const& [guid, playerData] : battleground->GetPlayers())
        {
            (void)playerData;
            if (Player* player = ObjectAccessor::FindConnectedPlayer(guid); player && player->IsSolitaryActivityBot())
                sRandomPlayerbotMgr.ScheduleSolitaryActivityBotCleanup(player);
        }
    }
};

class SolitaryCommandScript : public CommandScript
{
public:
    SolitaryCommandScript() : CommandScript("SolitaryCommandScript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable solitaryCommands =
        {
            { "on", HandleOn, rbac::RBAC_PERM_COMMAND_SOLITARY, Console::No },
            { "off", HandleOff, rbac::RBAC_PERM_COMMAND_SOLITARY, Console::No },
            { "status", HandleStatus, rbac::RBAC_PERM_COMMAND_SOLITARY, Console::No }
        };
        static ChatCommandTable commands =
        {
            { "solitary", solitaryCommands }
        };
        return commands;
    }

    static bool HandleOn(ChatHandler* handler)
    {
        Player* target = handler->GetPlayer();
        if (!target)
            return false;
        if (target->GetGroup() || target->InBattlegroundQueue() || target->InBattleground())
        {
            handler->SendErrorMessage("Перед включением Одиночки персонаж должен покинуть группу и PvP-очереди.");
            return false;
        }

        target->CastSpell(target, Player::SPELL_ID_SOLITARY, true);
        if (!target->IsSolitary())
        {
            handler->SendErrorMessage("Не удалось включить Одиночку: аура режима не была применена.");
            return false;
        }

        target->SaveToDB(false, false);
        handler->PSendSysMessage("Одиночка включена для {}.", target->GetName());
        return true;
    }

    static bool HandleOff(ChatHandler* handler)
    {
        Player* target = handler->GetPlayer();
        if (!target)
            return false;
        if (target->InBattlegroundQueue() || target->InBattleground())
        {
            handler->SendErrorMessage("Нельзя отключить Одиночку во время PvP-очереди или матча.");
            return false;
        }

        target->RemoveAurasDueToSpell(Player::SPELL_ID_SOLITARY);
        target->SaveToDB(false, false);
        handler->PSendSysMessage("Одиночка отключена для {}.", target->GetName());
        return true;
    }

    static bool HandleStatus(ChatHandler* handler)
    {
        Player* target = handler->GetPlayer();
        if (!target)
            return false;
        handler->PSendSysMessage("Одиночка для {}: {}.", target->GetName(), target->IsSolitary() ? "включена" : "выключена");
        return true;
    }
};
}

void AddSolitaryScripts()
{
    new SolitaryPlayerScript();
    new SolitaryDamageScript();
    new SolitaryBattlegroundScript();
    new SolitaryCommandScript();
}
