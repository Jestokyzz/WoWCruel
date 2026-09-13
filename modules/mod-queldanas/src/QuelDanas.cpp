#include "Creature.h"
#include "AllCreatureScript.h"
#include "Player.h"
#include "PlayerScript.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "UnitScript.h"

#include "QuelDanasScaling.generated.h"

#include <algorithm>
#include <limits>

namespace
{
constexpr uint32 MAP_OUTLAND = 530;
constexpr uint32 ZONE_ISLE_OF_QUEL_DANAS = 4080;
constexpr uint32 SPELL_PROTECTION_OF_THE_SUNWELL = 80920;
constexpr uint32 SPELL_NECK_MIGHT_PROC = 80921;
constexpr uint32 SPELL_NECK_ACUMEN_PROC = 80922;
constexpr uint32 SPELL_NECK_RESTORATION_PROC = 80923;
constexpr uint32 SPELL_NECK_RESOLVE_USE = 80924;
constexpr uint32 SPELL_NECK_ALDOR_AP = 80925;
constexpr uint32 SPELL_NECK_SCRYER_AP = 80926;
constexpr uint32 SPELL_NECK_ALDOR_SP = 80927;
constexpr uint32 SPELL_NECK_SCRYER_SP = 80928;
constexpr uint32 SPELL_NECK_ALDOR_ABSORB = 80929;
constexpr uint32 SPELL_NECK_SCRYER_RESISTANCE = 80930;
constexpr uint32 FACTION_ALDOR = 932;
constexpr uint32 FACTION_SCRYERS = 934;

enum class ExaltedNeckFaction : uint8
{
    None,
    Aldor,
    Scryers
};

ExaltedNeckFaction GetExaltedNeckFaction(Player const* player)
{
    if (!player)
        return ExaltedNeckFaction::None;

    // A legitimate character cannot be Exalted with both opposed factions.
    // Aldor precedence makes a corrupted/test reputation state deterministic.
    if (player->GetReputationRank(FACTION_ALDOR) >= REP_EXALTED)
        return ExaltedNeckFaction::Aldor;
    if (player->GetReputationRank(FACTION_SCRYERS) >= REP_EXALTED)
        return ExaltedNeckFaction::Scryers;
    return ExaltedNeckFaction::None;
}

bool IsOnQuelDanas(WorldObject const* object)
{
    return object && object->GetMapId() == MAP_OUTLAND && object->GetZoneId() == ZONE_ISLE_OF_QUEL_DANAS;
}

bool HasActiveSunwellProtection(Player const* player)
{
    return player && IsOnQuelDanas(player) && player->HasAura(SPELL_PROTECTION_OF_THE_SUNWELL);
}

Player* GetControllingPlayer(Unit const* unit)
{
    return unit ? unit->GetCharmerOrOwnerPlayerOrPlayerItself() : nullptr;
}

uint8 GetQuelDanasDamageFactor(Creature const* creature)
{
    if (!creature || !IsOnQuelDanas(creature) || GetControllingPlayer(creature))
        return 1;

    for (auto const& [entry, factor] : QuelDanasScaling::DamageFactors)
        if (entry == creature->GetEntry())
            return factor;

    return 1;
}

uint32 GetQuelDanasExactHealth(Creature const* creature)
{
    if (!creature || !IsOnQuelDanas(creature) || GetControllingPlayer(creature))
        return 0;

    for (auto const& [entry, health] : QuelDanasScaling::ExactHealth)
        if (entry == creature->GetEntry())
            return health;

    return 0;
}

void ApplyQuelDanasDamageRules(Unit* attacker, Unit* target, uint32& damage)
{
    if (!damage || !target)
        return;

    Player* attackingPlayer = GetControllingPlayer(attacker);
    Player* targetPlayer = GetControllingPlayer(target);

    // Defense in depth for already-launched missiles, periodic effects and
    // damage paths that do not repeat Unit::_IsValidAttackTarget.
    if (attackingPlayer && targetPlayer &&
        (HasActiveSunwellProtection(attackingPlayer) || HasActiveSunwellProtection(targetPlayer)))
    {
        damage = 0;
        return;
    }

    Creature* creature = attacker ? attacker->ToCreature() : nullptr;
    uint8 factor = GetQuelDanasDamageFactor(creature);
    if (factor <= 1)
        return;

    uint64 scaled = uint64(damage) * factor;
    damage = uint32(std::min<uint64>(scaled, std::numeric_limits<uint32>::max()));
}

class QuelDanasPlayerScript : public PlayerScript
{
public:
    QuelDanasPlayerScript() : PlayerScript("QuelDanasPlayerScript",
        { PLAYERHOOK_ON_LOGIN, PLAYERHOOK_ON_UPDATE_ZONE, PLAYERHOOK_ON_MAP_CHANGED,
            PLAYERHOOK_ON_DUEL_REQUEST }) { }

    void OnPlayerLogin(Player* player) override
    {
        EnforceAuraScope(player);
    }

    void OnPlayerUpdateZone(Player* player, uint32 newZone, uint32) override
    {
        if (newZone != ZONE_ISLE_OF_QUEL_DANAS)
            player->RemoveAurasDueToSpell(SPELL_PROTECTION_OF_THE_SUNWELL);
    }

    void OnPlayerMapChanged(Player* player) override
    {
        EnforceAuraScope(player);
    }

    void OnPlayerDuelRequest(Player* target, Player* challenger) override
    {
        if (!target || !challenger ||
            (!HasActiveSunwellProtection(target) && !HasActiveSunwellProtection(challenger)))
            return;

        if (challenger->duel)
            challenger->DuelComplete(DUEL_INTERRUPTED);
        else if (target->duel)
            target->DuelComplete(DUEL_INTERRUPTED);
    }

private:
    static void EnforceAuraScope(Player* player)
    {
        if (player && player->HasAura(SPELL_PROTECTION_OF_THE_SUNWELL) && !IsOnQuelDanas(player))
            player->RemoveAurasDueToSpell(SPELL_PROTECTION_OF_THE_SUNWELL);
    }
};

class QuelDanasDamageScript : public UnitScript
{
public:
    QuelDanasDamageScript() : UnitScript("QuelDanasDamageScript", true,
        { UNITHOOK_MODIFY_PERIODIC_DAMAGE_AURAS_TICK,
            UNITHOOK_MODIFY_MELEE_DAMAGE, UNITHOOK_MODIFY_SPELL_DAMAGE_TAKEN }) { }

    void ModifyPeriodicDamageAurasTick(Unit* target, Unit* attacker, uint32& damage, SpellInfo const*) override
    {
        ApplyQuelDanasDamageRules(attacker, target, damage);
    }

    void ModifyMeleeDamage(Unit* target, Unit* attacker, uint32& damage) override
    {
        ApplyQuelDanasDamageRules(attacker, target, damage);
    }

    void ModifySpellDamageTaken(Unit* target, Unit* attacker, int32& damage, SpellInfo const*) override
    {
        if (damage <= 0)
            return;

        uint32 unsignedDamage = uint32(damage);
        ApplyQuelDanasDamageRules(attacker, target, unsignedDamage);
        damage = int32(std::min<uint32>(unsignedDamage, std::numeric_limits<int32>::max()));
    }
};

class QuelDanasCreatureScript : public AllCreatureScript
{
public:
    QuelDanasCreatureScript() : AllCreatureScript("QuelDanasCreatureScript") { }

    void OnCreatureAddWorld(Creature* creature) override
    {
        uint32 exactHealth = GetQuelDanasExactHealth(creature);
        if (!exactHealth)
            return;

        // creature_template.HealthModifier is FLOAT. Large values can skip an
        // integer at level 80, so enforce the generator's exact current*xN
        // target after the normal template initialization has completed.
        creature->SetMaxHealth(exactHealth);
        creature->SetHealth(exactHealth);
    }
};

class spell_queldanas_neck_proc : public AuraScript
{
    PrepareAuraScript(spell_queldanas_neck_proc);

    bool Validate(SpellInfo const*) override
    {
        return ValidateSpellInfo({ SPELL_NECK_ALDOR_AP, SPELL_NECK_SCRYER_AP,
            SPELL_NECK_ALDOR_SP, SPELL_NECK_SCRYER_SP });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        Player* player = GetTarget() ? GetTarget()->ToPlayer() : nullptr;
        if (GetExaltedNeckFaction(player) == ExaltedNeckFaction::None)
            return false;

        switch (GetSpellInfo()->Id)
        {
            case SPELL_NECK_MIGHT_PROC:
                return eventInfo.GetDamageInfo() && eventInfo.GetDamageInfo()->GetDamage();
            case SPELL_NECK_ACUMEN_PROC:
                return eventInfo.GetSpellInfo() && eventInfo.GetDamageInfo() && eventInfo.GetDamageInfo()->GetDamage();
            case SPELL_NECK_RESTORATION_PROC:
                return eventInfo.GetHealInfo() && eventInfo.GetHealInfo()->GetHeal();
            default:
                return false;
        }
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo&)
    {
        PreventDefaultAction();
        Player* player = GetTarget() ? GetTarget()->ToPlayer() : nullptr;
        ExaltedNeckFaction faction = GetExaltedNeckFaction(player);
        if (!player || faction == ExaltedNeckFaction::None)
            return;

        bool attackPower = GetSpellInfo()->Id == SPELL_NECK_MIGHT_PROC;
        uint32 spellId = 0;
        if (faction == ExaltedNeckFaction::Aldor)
            spellId = attackPower ? SPELL_NECK_ALDOR_AP : SPELL_NECK_ALDOR_SP;
        else
            spellId = attackPower ? SPELL_NECK_SCRYER_AP : SPELL_NECK_SCRYER_SP;
        player->CastSpell(player, spellId, true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_queldanas_neck_proc::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_queldanas_neck_proc::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

class spell_queldanas_neck_resolve : public SpellScript
{
    PrepareSpellScript(spell_queldanas_neck_resolve);

    bool Validate(SpellInfo const*) override
    {
        return ValidateSpellInfo({ SPELL_NECK_ALDOR_ABSORB, SPELL_NECK_SCRYER_RESISTANCE });
    }

    SpellCastResult CheckCast()
    {
        Player* player = GetCaster() ? GetCaster()->ToPlayer() : nullptr;
        return GetExaltedNeckFaction(player) == ExaltedNeckFaction::None ? SPELL_FAILED_REPUTATION : SPELL_CAST_OK;
    }

    void HandleDummy(SpellEffIndex)
    {
        Player* player = GetCaster() ? GetCaster()->ToPlayer() : nullptr;
        ExaltedNeckFaction faction = GetExaltedNeckFaction(player);
        if (!player || faction == ExaltedNeckFaction::None)
            return;

        player->CastSpell(player,
            faction == ExaltedNeckFaction::Aldor ? SPELL_NECK_ALDOR_ABSORB : SPELL_NECK_SCRYER_RESISTANCE,
            true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_queldanas_neck_resolve::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_queldanas_neck_resolve::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};
}

void AddQuelDanasScripts()
{
    new QuelDanasPlayerScript();
    new QuelDanasDamageScript();
    new QuelDanasCreatureScript();
    RegisterSpellScript(spell_queldanas_neck_proc);
    RegisterSpellScript(spell_queldanas_neck_resolve);
}
