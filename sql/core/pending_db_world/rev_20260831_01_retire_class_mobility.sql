-- Class Mobility removal v1.0.0. Target: acore_world or isolated matching world clone.
-- Run only with its worldserver stopped and verified scoped dumps on F:.
-- Preflight: no additional trainers/script owners may be removed implicitly.
START TRANSACTION;
DELETE FROM `trainer_spell` WHERE `TrainerId` IN (31, 32) AND `SpellId` = 80916;
DELETE FROM `spell_script_names` WHERE `spell_id` = -1850 AND `ScriptName` = 'spell_dru_dash';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-1850, 'spell_dru_dash');
DELETE FROM `spell_script_names` WHERE `spell_id` = 781 AND `ScriptName` = 'spell_hun_disengage';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (781, 'spell_hun_disengage');
COMMIT;
-- Postflight: two stock bindings, zero retired trainer entries.
SELECT `spell_id`, `ScriptName` FROM `spell_script_names`
WHERE (`spell_id` = -1850 AND `ScriptName` = 'spell_dru_dash')
   OR (`spell_id` = 781 AND `ScriptName` = 'spell_hun_disengage');
SELECT COUNT(*) AS `retired_trainers` FROM `trainer_spell` WHERE `SpellId` BETWEEN 80901 AND 80918;
