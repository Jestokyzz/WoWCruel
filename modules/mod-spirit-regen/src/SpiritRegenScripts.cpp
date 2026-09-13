#include "SpiritRegen.h"

#include "Chat.h"
#include "CommandScript.h"
#include "Player.h"
#include "PlayerScript.h"
#include "RBAC.h"
#include "ScriptMgr.h"
#include "StringFormat.h"
#include "WorldScript.h"

#include <unordered_map>

using namespace Acore::ChatCommands;

namespace
{
class SpiritRegenWorldScript : public WorldScript
{
public:
    SpiritRegenWorldScript() : WorldScript("SpiritRegenWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        SpiritRegen::LoadConfig();
    }
};

class SpiritRegenPlayerScript : public PlayerScript
{
public:
    SpiritRegenPlayerScript() : PlayerScript("SpiritRegenPlayerScript") { }

    void OnPlayerAfterUpdate(Player* player, uint32 diff) override
    {
        if (!SpiritRegen::GetSettings().Enabled || !SpiritRegen::SupportsPlayer(player))
            return;

        uint64 guid = player->GetGUID().GetRawValue();
        uint32& elapsed = _elapsedByPlayer[guid];
        elapsed += diff;
        if (elapsed < SpiritRegen::GetSettings().UpdateIntervalMs)
            return;

        elapsed = 0;
        SpiritRegen::CalculateAndApply(player, true);
    }

    void OnPlayerLogout(Player* player) override
    {
        _elapsedByPlayer.erase(player->GetGUID().GetRawValue());
    }

    void OnPlayerLogin(Player* player) override
    {
        if (SpiritRegen::GetSettings().Enabled)
            SpiritRegen::CalculateAndApply(player, true);
    }

    void OnPlayerAfterSpecSlotChanged(Player* player, uint8 /*newSlot*/) override
    {
        if (SpiritRegen::GetSettings().Enabled)
            SpiritRegen::CalculateAndApply(player, true);
    }

private:
    std::unordered_map<uint64, uint32> _elapsedByPlayer;
};

class SpiritRegenCommandScript : public CommandScript
{
public:
    SpiritRegenCommandScript() : CommandScript("SpiritRegenCommandScript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable subcommands =
        {
            { "status", HandleStatus, rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "audit", HandleAudit, rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "recalc", HandleRecalculate, rbac::RBAC_PERM_COMMAND_DEBUG, Console::No }
        };
        static ChatCommandTable commands =
        {
            { "spiritregen", subcommands }
        };
        return commands;
    }

private:
    static bool HandleStatus(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
            return false;

        SpiritRegen::Snapshot const result = SpiritRegen::CalculateAndApply(player, true);
        handler->SendSysMessage(Acore::StringFormat(
            "SpiritRegen {} strict {} | Spirit {:.1f} | Intellect {:.1f} | active {:.2f} MP5 | "
            "blocked {:.2f} MP5 ({}) | vanilla Spirit {:.2f} MP5 | normalized {:.2f} MP5 | "
            "Spirit aura x{:.2f} | cast x{:.2f} | final cast {:.2f} MP5 | final idle {:.2f} MP5",
            SpiritRegen::GetSettings().Enabled ? "ON" : "OFF",
            SpiritRegen::GetSettings().StrictMode ? "ON" : "OFF", result.Spirit, result.Intellect,
            result.AllowedActiveManaPerSecond * 5.0f, result.BlockedPassiveManaPerSecond * 5.0f,
            result.BlockedAuraCount, result.VanillaSpiritPerSecond * 5.0f,
            result.NormalizedSpiritPerSecond * 5.0f, result.SpiritRegenMultiplier,
            result.CastingSpiritMultiplier,
            result.InterruptedRegenPerSecond * 5.0f, result.NormalRegenPerSecond * 5.0f));
        return true;
    }

    static bool HandleAudit(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
            return false;

        SpiritRegen::Snapshot const result = SpiritRegen::CalculateAndApply(player, true);
        handler->SendSysMessage(Acore::StringFormat(
            "SpiritRegen audit | allowed active {:.2f} MP5 | blocked passive {:.2f} MP5 | blocked auras {}",
            result.AllowedActiveManaPerSecond * 5.0f, result.BlockedPassiveManaPerSecond * 5.0f,
            result.BlockedAuraCount));
        return true;
    }

    static bool HandleRecalculate(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
            return false;

        SpiritRegen::CalculateAndApply(player, true);
        handler->SendSysMessage("Spirit regeneration recalculated.");
        return true;
    }
};
}

void AddSpiritRegenScripts()
{
    new SpiritRegenWorldScript();
    new SpiritRegenPlayerScript();
    new SpiritRegenCommandScript();
}
