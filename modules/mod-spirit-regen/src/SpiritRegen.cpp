#include "SpiritRegen.h"

#include "Config.h"
#include "Log.h"
#include "Player.h"
#include "SharedDefines.h"
#include "SpellAuraDefines.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"

#include <algorithm>
#include <cmath>
#include <unordered_set>

namespace SpiritRegen
{
namespace
{
Settings Config;

bool IsActiveManaRestore(uint32 spellId)
{
    static std::unordered_set<uint32> const ActiveManaRestoreSpells =
    {
        430, 431, 432, 833, 1133, 1135, 1137, 2639, 8384, 10250, 12732, 18140,
        22734, 23698, 25696, 25697,
        25701, 25703, 25887, 25889, 26261, 26402, 26473, 26475, 27089, 29007, 29039,
        33774, 34291, 42308, 42312, 43154, 43182, 43183, 44107, 44109, 44110, 44111, 44112,
        44113, 44114, 44115, 44116, 45019, 45020, 46755, 49472, 52911, 53373, 57073,
        61268, 61830, 64356, 65363, 66041, 69560, 69561, 72623
    };
    return ActiveManaRestoreSpells.contains(spellId);
}

float GetClassMultiplier(Player const* player)
{
    switch (player->getClass())
    {
        case CLASS_PALADIN: return Config.PaladinMultiplier;
        case CLASS_HUNTER:  return Config.HunterMultiplier;
        case CLASS_PRIEST:  return Config.PriestMultiplier;
        case CLASS_SHAMAN:  return Config.ShamanMultiplier;
        case CLASS_MAGE:    return Config.MageMultiplier;
        case CLASS_WARLOCK: return Config.WarlockMultiplier;
        case CLASS_DRUID:   return Config.DruidMultiplier;
        default:            return 0.0f;
    }
}

void ClassifyFlatManaRegen(Player const* player, Snapshot& result)
{
    for (AuraEffect const* effect : player->GetAuraEffectsByType(SPELL_AURA_MOD_POWER_REGEN))
    {
        if (effect->GetMiscValue() != POWER_MANA)
            continue;

        float amountPerSecond = effect->GetAmount() / 5.0f;
        if (IsActiveManaRestore(effect->GetSpellInfo()->Id))
            result.AllowedActiveManaPerSecond += amountPerSecond;
        else
        {
            result.BlockedPassiveManaPerSecond += amountPerSecond;
            ++result.BlockedAuraCount;
        }
    }
}
}

Settings const& GetSettings()
{
    return Config;
}

void LoadConfig()
{
    Config.Enabled = sConfigMgr->GetOption<bool>("SpiritRegen.Enable", false);
    Config.PreserveVanillaOutOfCast = sConfigMgr->GetOption<bool>("SpiritRegen.PreserveVanillaOutOfCast", true);
    Config.StrictMode = sConfigMgr->GetOption<bool>("SpiritRegen.StrictMode", true);
    Config.AuditUnknownFlatRegen = sConfigMgr->GetOption<bool>("SpiritRegen.AuditUnknownFlatRegen", true);
    Config.Debug = sConfigMgr->GetOption<bool>("SpiritRegen.Debug", false);
    Config.UpdateIntervalMs = std::max<uint32>(100,
        sConfigMgr->GetOption<uint32>("SpiritRegen.UpdateIntervalMs", 500));
    Config.CombatMp5PerSpirit = std::max(0.0f,
        sConfigMgr->GetOption<float>("SpiritRegen.CombatMp5PerSpirit", 0.5f));
    Config.PaladinMultiplier = std::max(0.0f,
        sConfigMgr->GetOption<float>("SpiritRegen.PaladinMultiplier", 1.0f));
    Config.HunterMultiplier = std::max(0.0f,
        sConfigMgr->GetOption<float>("SpiritRegen.HunterMultiplier", 1.0f));
    Config.PriestMultiplier = std::max(0.0f,
        sConfigMgr->GetOption<float>("SpiritRegen.PriestMultiplier", 1.0f));
    Config.ShamanMultiplier = std::max(0.0f,
        sConfigMgr->GetOption<float>("SpiritRegen.ShamanMultiplier", 1.0f));
    Config.MageMultiplier = std::max(0.0f,
        sConfigMgr->GetOption<float>("SpiritRegen.MageMultiplier", 1.0f));
    Config.WarlockMultiplier = std::max(0.0f,
        sConfigMgr->GetOption<float>("SpiritRegen.WarlockMultiplier", 1.0f));
    Config.DruidMultiplier = std::max(0.0f,
        sConfigMgr->GetOption<float>("SpiritRegen.DruidMultiplier", 1.0f));

    LOG_INFO("module.spirit-regen", "Spirit-only regeneration module is {} ({} ms update interval, strict {})",
        Config.Enabled ? "enabled" : "disabled", Config.UpdateIntervalMs, Config.StrictMode ? "on" : "off");
}

bool SupportsPlayer(Player const* player)
{
    if (!player)
        return false;

    switch (player->getClass())
    {
        case CLASS_PALADIN:
        case CLASS_HUNTER:
        case CLASS_PRIEST:
        case CLASS_SHAMAN:
        case CLASS_MAGE:
        case CLASS_WARLOCK:
        case CLASS_DRUID:
            return true;
        default:
            return false;
    }
}

Snapshot CalculateAndApply(Player* player, bool apply)
{
    Snapshot result;
    if (!SupportsPlayer(player))
        return result;

    player->UpdateManaRegen();

    if (player->HasAuraTypeWithMiscvalue(SPELL_AURA_PREVENT_REGENERATE_POWER, POWER_MANA + 1))
        return result;

    result.Spirit = std::max(0.0f, player->GetStat(STAT_SPIRIT));
    result.Intellect = std::max(0.0f, player->GetStat(STAT_INTELLECT));

    float vanillaNormal = player->GetFloatValue(
        UNIT_FIELD_POWER_REGEN_FLAT_MODIFIER + AsUnderlyingType(POWER_MANA));
    result.VanillaSpiritPerSecond = std::sqrt(result.Intellect) * player->OCTRegenMPPerSpirit();
    result.SpiritRegenMultiplier = player->GetTotalAuraMultiplierByMiscValue(
        SPELL_AURA_MOD_POWER_REGEN_PERCENT, POWER_MANA);
    result.VanillaSpiritPerSecond *= result.SpiritRegenMultiplier;

    ClassifyFlatManaRegen(player, result);
    result.FlatManaPerSecond = vanillaNormal - result.VanillaSpiritPerSecond;
    float retainedFlatManaPerSecond = Config.StrictMode
        ? result.AllowedActiveManaPerSecond
        : result.FlatManaPerSecond;

    result.NormalizedSpiritPerSecond = result.Spirit * Config.CombatMp5PerSpirit / 5.0f;
    result.NormalizedSpiritPerSecond *= GetClassMultiplier(player);
    result.NormalizedSpiritPerSecond *= result.SpiritRegenMultiplier;

    int32 castingBonusPercent = std::clamp(
        player->GetTotalAuraModifier(SPELL_AURA_MOD_MANA_REGEN_INTERRUPT), 0, 100);
    result.CastingSpiritMultiplier = 1.0f + castingBonusPercent / 100.0f;

    float outOfCastSpirit = result.NormalizedSpiritPerSecond;
    if (Config.PreserveVanillaOutOfCast)
        outOfCastSpirit = std::max(outOfCastSpirit, result.VanillaSpiritPerSecond);

    result.NormalRegenPerSecond = retainedFlatManaPerSecond + outOfCastSpirit;
    result.InterruptedRegenPerSecond = retainedFlatManaPerSecond
        + result.NormalizedSpiritPerSecond * result.CastingSpiritMultiplier;

    if (apply && Config.Enabled)
    {
        player->SetStatFloatValue(UNIT_FIELD_POWER_REGEN_FLAT_MODIFIER + AsUnderlyingType(POWER_MANA),
            result.NormalRegenPerSecond);
        player->SetStatFloatValue(UNIT_FIELD_POWER_REGEN_INTERRUPTED_FLAT_MODIFIER + AsUnderlyingType(POWER_MANA),
            result.InterruptedRegenPerSecond);

        if (Config.Debug || (Config.AuditUnknownFlatRegen && result.BlockedAuraCount))
        {
            LOG_DEBUG("module.spirit-regen", "{}: spirit {:.1f}, intellect {:.1f}, active {:.2f}/s, "
                "blocked {} ({:.2f}/s), vanilla spirit {:.2f}/s, normalized {:.2f}/s, cast x{:.2f}",
                player->GetName(), result.Spirit, result.Intellect, result.AllowedActiveManaPerSecond,
                result.BlockedAuraCount, result.BlockedPassiveManaPerSecond, result.VanillaSpiritPerSecond,
                result.NormalizedSpiritPerSecond, result.CastingSpiritMultiplier);
        }
    }

    return result;
}
}
