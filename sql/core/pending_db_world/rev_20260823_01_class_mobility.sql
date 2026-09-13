-- Class mobility preflight:
-- SELECT spell_id, ScriptName FROM spell_script_names WHERE spell_id IN (-1850, 781);
-- SELECT TrainerId, SpellId FROM trainer_spell WHERE TrainerId IN (31, 32) AND SpellId = 80916;

DELETE FROM `spell_script_names`
WHERE `spell_id` = -1850 AND `ScriptName` = 'spell_dru_dash';

DELETE FROM `spell_script_names`
WHERE `spell_id` = 781 AND `ScriptName` = 'spell_hun_disengage';

DELETE FROM `trainer_spell`
WHERE `TrainerId` IN (31, 32) AND `SpellId` = 80916;

INSERT INTO `trainer_spell`
    (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`,
     `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`)
VALUES
    (31, 80916, 10000, 0, 0, 0, 0, 0, 20, 0),
    (32, 80916, 10000, 0, 0, 0, 0, 0, 20, 0);

-- Postflight:
-- SELECT spell_id, ScriptName FROM spell_script_names WHERE spell_id IN (-1850, 781);
-- SELECT TrainerId, SpellId, MoneyCost, ReqLevel FROM trainer_spell
-- WHERE TrainerId IN (31, 32) AND SpellId = 80916;
