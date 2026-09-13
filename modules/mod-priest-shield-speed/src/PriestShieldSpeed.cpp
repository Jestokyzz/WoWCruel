#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "Unit.h"
#include "UnitScript.h"

namespace
{
enum PriestShieldSpeedSpells : uint32
{
    SPELL_PRIEST_POWER_WORD_SHIELD_RANK_1 = 17,
    SPELL_PRIEST_BODY_AND_SOUL_RANK_1 = 64127,
    SPELL_PRIEST_BODY_AND_SOUL_RANK_2 = 64129,
    SPELL_PRIEST_BODY_AND_SOUL_BASELINE = 80900
};

class PriestShieldSpeedUnitScript : public UnitScript
{
public:
    PriestShieldSpeedUnitScript() : UnitScript("PriestShieldSpeedUnitScript") { }

    void OnAuraApply(Unit* target, Aura* aura) override
    {
        if (!target || !aura)
            return;

        SpellInfo const* spellInfo = aura->GetSpellInfo();
        if (!spellInfo || spellInfo->GetFirstRankSpell()->Id != SPELL_PRIEST_POWER_WORD_SHIELD_RANK_1)
            return;

        Unit* caster = aura->GetCaster();
        if (!caster || !caster->IsPlayer() || !caster->IsClass(CLASS_PRIEST, CLASS_CONTEXT_ABILITY))
            return;

        // The stock Body and Soul proc owns the talented 1/2 and 2/2 variants.
        // This module supplies only the baseline effect when the active build has neither rank.
        if (caster->HasAura(SPELL_PRIEST_BODY_AND_SOUL_RANK_1) ||
            caster->HasAura(SPELL_PRIEST_BODY_AND_SOUL_RANK_2))
            return;

        caster->CastSpell(target, SPELL_PRIEST_BODY_AND_SOUL_BASELINE, true);
    }
};
}

void AddPriestShieldSpeedScripts()
{
    new PriestShieldSpeedUnitScript();
}
