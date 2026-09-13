#include "AllSpellScript.h"
#include "ObjectGuid.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "Timer.h"
#include "Unit.h"
#include "UnitScript.h"

#include <algorithm>
#include <limits>
#include <unordered_map>
#include <unordered_set>

namespace
{
enum ClassMobilitySpells : uint32
{
    SPELL_WARRIOR_INTERCEPT_STUN_RANK_1 = 20253,
    SPELL_WARRIOR_IMPROVED_INTERCEPT_RANK_1 = 29888,
    SPELL_WARRIOR_IMPROVED_INTERCEPT_RANK_2 = 29889,
    SPELL_WARRIOR_INTERCEPT_ROOT_RANK_1 = 80901,
    SPELL_WARRIOR_INTERCEPT_ROOT_RANK_2 = 80902,

    SPELL_DRUID_DASH_RANK_1 = 1850,
    SPELL_DRUID_DASH_RANK_2 = 9821,
    SPELL_DRUID_DASH_RANK_3 = 33357,

    SPELL_MAGE_BLINK = 1953,
    SPELL_MAGE_SCORCH_RANK_1 = 2948,
    SPELL_MAGE_IMPROVED_SCORCH_RANK_1 = 11095,
    SPELL_MAGE_IMPROVED_SCORCH_RANK_2 = 12872,
    SPELL_MAGE_IMPROVED_SCORCH_RANK_3 = 12873,
    SPELL_MAGE_SCORCH_SPEED_RANK_1 = 80903,
    SPELL_MAGE_SCORCH_SPEED_RANK_2 = 80904,
    SPELL_MAGE_SCORCH_SPEED_RANK_3 = 80905,
    SPELL_MAGE_ICY_VEINS = 12472,
    SPELL_MAGE_ICE_FLOES = 80906,

    SPELL_HUNTER_DISENGAGE = 781,
    SPELL_HUNTER_DISENGAGE_SPEED = 80907,

    SPELL_PALADIN_JUDGEMENT_OF_LIGHT = 20271,
    SPELL_PALADIN_JUDGEMENT_OF_JUSTICE = 53407,
    SPELL_PALADIN_JUDGEMENT_OF_WISDOM = 53408,
    SPELL_PALADIN_JUDGEMENTS_OF_THE_PURE_RANK_1 = 53671,
    SPELL_PALADIN_JUDGEMENTS_OF_THE_PURE_RANK_2 = 53673,
    SPELL_PALADIN_JUDGEMENTS_OF_THE_PURE_RANK_3 = 54151,
    SPELL_PALADIN_JUDGEMENTS_OF_THE_PURE_RANK_4 = 54154,
    SPELL_PALADIN_JUDGEMENTS_OF_THE_PURE_RANK_5 = 54155,
    SPELL_PALADIN_JUDGEMENT_SPEED_RANK_1 = 80908,
    SPELL_PALADIN_JUDGEMENT_SPEED_RANK_2 = 80909,
    SPELL_PALADIN_JUDGEMENT_SPEED_RANK_3 = 80910,
    SPELL_PALADIN_JUDGEMENT_SPEED_RANK_4 = 80911,
    SPELL_PALADIN_JUDGEMENT_SPEED_RANK_5 = 80912,

    SPELL_ROGUE_SHADOWSTEP = 36554,
    SPELL_ROGUE_SPRINT_RANK_1 = 2983,
    SPELL_ROGUE_SPRINT_RANK_2 = 8696,
    SPELL_ROGUE_SPRINT_RANK_3 = 11305,

    SPELL_DK_CHAINS_OF_ICE = 45524,
    SPELL_DK_CHILBLAINS_RANK_1 = 50040,
    SPELL_DK_CHILBLAINS_RANK_2 = 50041,
    SPELL_DK_CHILBLAINS_RANK_3 = 50043,
    SPELL_DK_CHAINS_ROOT_RANK_1 = 80913,
    SPELL_DK_CHAINS_ROOT_RANK_2 = 80914,
    SPELL_DK_CHAINS_ROOT_RANK_3 = 80915,

    SPELL_WARLOCK_BURNING_RUSH = 80916,

    SPELL_SHAMAN_GHOST_WOLF = 2645,
    SPELL_SHAMAN_IMPROVED_GHOST_WOLF_RANK_1 = 16262,
    SPELL_SHAMAN_IMPROVED_GHOST_WOLF_RANK_2 = 16287
};

struct SprintBonuses
{
    bool damageReady = false;
    bool threatReady = false;
    uint32 threatSpell = 0;
    uint32 threatWindow = 0;
};

std::unordered_map<ObjectGuid, SprintBonuses> SprintStates;

bool IsFirstRank(SpellInfo const* spellInfo, uint32 firstRank)
{
    return spellInfo && spellInfo->GetFirstRankSpell()->Id == firstRank;
}

bool IsIceFloesEligible(SpellInfo const* spellInfo)
{
    if (!spellInfo || spellInfo->Id == SPELL_MAGE_ICE_FLOES || spellInfo->Id == SPELL_MAGE_ICY_VEINS)
        return false;

    if (spellInfo->SpellFamilyName != SPELLFAMILY_MAGE)
        return false;

    int32 baseTime = spellInfo->IsChanneled() ? spellInfo->GetDuration() :
        (spellInfo->CastTimeEntry ? spellInfo->CastTimeEntry->CastTime : 0);
    return baseTime > 0 && baseTime < 4000;
}

bool HasSprint(Unit const* unit)
{
    return unit->HasAura(SPELL_ROGUE_SPRINT_RANK_1) || unit->HasAura(SPELL_ROGUE_SPRINT_RANK_2) ||
        unit->HasAura(SPELL_ROGUE_SPRINT_RANK_3);
}

uint32 GetPaladinSpeedSpell(Unit const* caster)
{
    if (caster->HasAura(SPELL_PALADIN_JUDGEMENTS_OF_THE_PURE_RANK_5))
        return SPELL_PALADIN_JUDGEMENT_SPEED_RANK_5;
    if (caster->HasAura(SPELL_PALADIN_JUDGEMENTS_OF_THE_PURE_RANK_4))
        return SPELL_PALADIN_JUDGEMENT_SPEED_RANK_4;
    if (caster->HasAura(SPELL_PALADIN_JUDGEMENTS_OF_THE_PURE_RANK_3))
        return SPELL_PALADIN_JUDGEMENT_SPEED_RANK_3;
    if (caster->HasAura(SPELL_PALADIN_JUDGEMENTS_OF_THE_PURE_RANK_2))
        return SPELL_PALADIN_JUDGEMENT_SPEED_RANK_2;
    if (caster->HasAura(SPELL_PALADIN_JUDGEMENTS_OF_THE_PURE_RANK_1))
        return SPELL_PALADIN_JUDGEMENT_SPEED_RANK_1;
    return 0;
}

class ClassMobilityAllSpellScript : public AllSpellScript
{
public:
    ClassMobilityAllSpellScript() : AllSpellScript("ClassMobilityAllSpellScript") { }

    void OnSpellCheckCast(Spell* spell, bool /*strict*/, SpellCastResult& result) override
    {
        if (!spell || result != SPELL_CAST_OK)
            return;

        Unit* caster = spell->GetCaster();
        SpellInfo const* spellInfo = spell->GetSpellInfo();
        if (!caster || !spellInfo)
            return;

        if (IsFirstRank(spellInfo, SPELL_DRUID_DASH_RANK_1) && caster->GetShapeshiftForm() == FORM_NONE)
        {
            result = SPELL_FAILED_ONLY_SHAPESHIFT;
            return;
        }

        if (spellInfo->Id == SPELL_ROGUE_SHADOWSTEP && spell->m_targets.GetUnitTarget() == caster)
        {
            result = SPELL_FAILED_BAD_TARGETS;
            return;
        }

        if (spellInfo->Id == SPELL_WARLOCK_BURNING_RUSH && caster->HasAura(SPELL_WARLOCK_BURNING_RUSH))
        {
            caster->RemoveAurasDueToSpell(SPELL_WARLOCK_BURNING_RUSH);
            result = SPELL_FAILED_DONT_REPORT;
        }
    }

    bool CanCastWhileMoving(Spell* spell) override
    {
        Unit* caster = spell ? spell->GetCaster() : nullptr;
        bool allowed = caster && caster->IsPlayer() && caster->IsClass(CLASS_MAGE, CLASS_CONTEXT_ABILITY) &&
            caster->HasAura(SPELL_MAGE_ICE_FLOES) && IsIceFloesEligible(spell->GetSpellInfo());
        if (allowed)
            _iceFloesCasts.insert(spell);
        return allowed;
    }

    void OnSpellCastCancel(Spell* spell, Unit* /*caster*/, SpellInfo const* /*spellInfo*/, bool /*bySelf*/) override
    {
        _iceFloesCasts.erase(spell);
    }

    void OnSpellCast(Spell* spell, Unit* caster, SpellInfo const* spellInfo, bool /*skipCheck*/) override
    {
        if (!spell || !caster || !spellInfo || !caster->IsPlayer())
            return;

        if (IsFirstRank(spellInfo, SPELL_MAGE_SCORCH_RANK_1))
        {
            if (caster->HasAura(SPELL_MAGE_IMPROVED_SCORCH_RANK_3))
                caster->CastSpell(caster, SPELL_MAGE_SCORCH_SPEED_RANK_3, true);
            else if (caster->HasAura(SPELL_MAGE_IMPROVED_SCORCH_RANK_2))
                caster->CastSpell(caster, SPELL_MAGE_SCORCH_SPEED_RANK_2, true);
            else if (caster->HasAura(SPELL_MAGE_IMPROVED_SCORCH_RANK_1))
                caster->CastSpell(caster, SPELL_MAGE_SCORCH_SPEED_RANK_1, true);
        }

        if (spellInfo->Id == SPELL_MAGE_ICY_VEINS)
        {
            caster->CastSpell(caster, SPELL_MAGE_ICE_FLOES, true);
            if (Aura* aura = caster->GetAura(SPELL_MAGE_ICE_FLOES))
                aura->SetStackAmount(3);
        }
        else if (_iceFloesCasts.erase(spell) && caster->HasAura(SPELL_MAGE_ICE_FLOES))
            caster->GetAura(SPELL_MAGE_ICE_FLOES)->ModStackAmount(-1);

        if (spellInfo->Id == SPELL_HUNTER_DISENGAGE)
            caster->CastSpell(caster, SPELL_HUNTER_DISENGAGE_SPEED, true);

        if (spellInfo->Id == SPELL_PALADIN_JUDGEMENT_OF_LIGHT ||
            spellInfo->Id == SPELL_PALADIN_JUDGEMENT_OF_JUSTICE ||
            spellInfo->Id == SPELL_PALADIN_JUDGEMENT_OF_WISDOM)
            if (uint32 speedSpell = GetPaladinSpeedSpell(caster))
                caster->CastSpell(caster, speedSpell, true);
    }

    void ModifyDamage(Unit* attacker, Unit* victim, SpellInfo const* /*spellInfo*/, DamageEffectType damageType, uint32& damage) override
    {
        if (!attacker || !victim || attacker == victim || !attacker->IsPlayer() || damage == 0 || damageType == DOT ||
            !attacker->IsClass(CLASS_ROGUE, CLASS_CONTEXT_ABILITY) || !HasSprint(attacker))
            return;

        auto itr = SprintStates.find(attacker->GetGUID());
        if (itr == SprintStates.end() || !itr->second.damageReady)
            return;

        damage = uint32(std::min<uint64>(uint64(damage) * 120 / 100, std::numeric_limits<uint32>::max()));
        itr->second.damageReady = false;
    }

    void ModifyThreat(Unit* source, Unit* /*threatened*/, SpellInfo const* spellInfo, float& threat) override
    {
        if (!source || !source->IsPlayer() || !spellInfo || threat <= 0.0f ||
            !source->IsClass(CLASS_ROGUE, CLASS_CONTEXT_ABILITY) || !HasSprint(source))
            return;

        auto itr = SprintStates.find(source->GetGUID());
        if (itr == SprintStates.end())
            return;

        SprintBonuses& state = itr->second;
        uint32 now = getMSTime();
        if (state.threatReady)
        {
            state.threatReady = false;
            state.threatSpell = spellInfo->Id;
            state.threatWindow = now;
            threat *= 0.5f;
        }
        else if (state.threatSpell == spellInfo->Id && getMSTimeDiff(state.threatWindow, now) <= 100)
            threat *= 0.5f;
    }

private:
    std::unordered_set<Spell*> _iceFloesCasts;
};

class ClassMobilityUnitScript : public UnitScript
{
public:
    ClassMobilityUnitScript() : UnitScript("ClassMobilityUnitScript") { }

    void OnAuraApply(Unit* target, Aura* aura) override
    {
        if (!target || !aura)
            return;

        SpellInfo const* spellInfo = aura->GetSpellInfo();
        Unit* caster = aura->GetCaster();
        if (!spellInfo)
            return;

        if (IsFirstRank(spellInfo, SPELL_ROGUE_SPRINT_RANK_1) && target->IsPlayer())
            SprintStates[target->GetGUID()] = { true, true, 0, 0 };

        if (caster && IsFirstRank(spellInfo, SPELL_WARRIOR_INTERCEPT_STUN_RANK_1))
        {
            if (caster->HasAura(SPELL_WARRIOR_IMPROVED_INTERCEPT_RANK_2))
                caster->CastSpell(target, SPELL_WARRIOR_INTERCEPT_ROOT_RANK_2, true);
            else if (caster->HasAura(SPELL_WARRIOR_IMPROVED_INTERCEPT_RANK_1))
                caster->CastSpell(target, SPELL_WARRIOR_INTERCEPT_ROOT_RANK_1, true);
        }

        if (caster && spellInfo->Id == SPELL_DK_CHAINS_OF_ICE)
        {
            if (caster->HasAura(SPELL_DK_CHILBLAINS_RANK_3))
                caster->CastSpell(target, SPELL_DK_CHAINS_ROOT_RANK_3, true);
            else if (caster->HasAura(SPELL_DK_CHILBLAINS_RANK_2))
                caster->CastSpell(target, SPELL_DK_CHAINS_ROOT_RANK_2, true);
            else if (caster->HasAura(SPELL_DK_CHILBLAINS_RANK_1))
                caster->CastSpell(target, SPELL_DK_CHAINS_ROOT_RANK_1, true);
        }

        if (spellInfo->Id == SPELL_SHAMAN_GHOST_WOLF)
        {
            int32 speed = 40;
            if (target->HasAura(SPELL_SHAMAN_IMPROVED_GHOST_WOLF_RANK_2))
                speed = 60;
            else if (target->HasAura(SPELL_SHAMAN_IMPROVED_GHOST_WOLF_RANK_1))
                speed = 50;

            if (AuraEffect* movement = aura->GetEffect(EFFECT_1))
                movement->ChangeAmount(speed, false);
        }
    }

    void OnAuraRemove(Unit* target, AuraApplication* aurApp, AuraRemoveMode /*mode*/) override
    {
        if (!target || !aurApp)
            return;

        if (IsFirstRank(aurApp->GetBase()->GetSpellInfo(), SPELL_ROGUE_SPRINT_RANK_1))
            SprintStates.erase(target->GetGUID());
    }

    void OnUnitSetShapeshiftForm(Unit* unit, uint8 form) override
    {
        if (!unit || form != FORM_NONE)
            return;

        unit->RemoveAurasDueToSpell(SPELL_DRUID_DASH_RANK_1);
        unit->RemoveAurasDueToSpell(SPELL_DRUID_DASH_RANK_2);
        unit->RemoveAurasDueToSpell(SPELL_DRUID_DASH_RANK_3);
    }

    void OnUnitUpdate(Unit* unit, uint32 diff) override
    {
        if (!unit || !unit->IsPlayer())
            return;

        if (!HasSprint(unit))
            SprintStates.erase(unit->GetGUID());

        ObjectGuid guid = unit->GetGUID();
        if (!unit->HasAura(SPELL_WARLOCK_BURNING_RUSH))
        {
            _burningRushTimers.erase(guid);
            return;
        }

        uint32& timer = _burningRushTimers[guid];
        timer += diff;
        while (timer >= 1000)
        {
            timer -= 1000;
            uint32 healthCost = std::max<uint32>(1, unit->GetMaxHealth() * 3 / 100);
            if (unit->GetHealth() <= healthCost + 1)
            {
                unit->SetHealth(1);
                unit->RemoveAurasDueToSpell(SPELL_WARLOCK_BURNING_RUSH);
                _burningRushTimers.erase(guid);
                return;
            }

            unit->SetHealth(unit->GetHealth() - healthCost);
        }
    }

    void OnUnitDeath(Unit* unit, Unit* /*killer*/) override
    {
        if (unit)
            SprintStates.erase(unit->GetGUID());
    }

private:
    std::unordered_map<ObjectGuid, uint32> _burningRushTimers;
};
}

void AddClassMobilityScripts()
{
    new ClassMobilityAllSpellScript();
    new ClassMobilityUnitScript();
}
