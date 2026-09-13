-- jc-2026-08-28-queldanas-v1
-- World DB migration. Apply only after running preflight.sql against the intended world database.
SET @QD_OLD_SQL_MODE=@@SESSION.sql_mode;
SET SESSION sql_mode='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template` WHERE `entry`=5202;
UPDATE `_qd_clone_rows` SET `entry`=900400;
INSERT INTO `creature_template` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_equip_template`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_equip_template` WHERE `CreatureID`=5202;
UPDATE `_qd_clone_rows` SET `CreatureID`=900400;
INSERT INTO `creature_equip_template` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_addon`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_addon` WHERE `entry`=5202;
UPDATE `_qd_clone_rows` SET `entry`=900400;
INSERT INTO `creature_template_addon` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_locale`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_locale` WHERE `entry`=5202;
UPDATE `_qd_clone_rows` SET `entry`=900400;
INSERT INTO `creature_template_locale` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_model`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_model` WHERE `CreatureID`=5202;
UPDATE `_qd_clone_rows` SET `CreatureID`=900400;
INSERT INTO `creature_template_model` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_movement`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_movement` WHERE `CreatureId`=5202;
UPDATE `_qd_clone_rows` SET `CreatureId`=900400;
INSERT INTO `creature_template_movement` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_resistance`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_resistance` WHERE `CreatureID`=5202;
UPDATE `_qd_clone_rows` SET `CreatureID`=900400;
INSERT INTO `creature_template_resistance` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_spell`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_spell` WHERE `CreatureID`=5202;
UPDATE `_qd_clone_rows` SET `CreatureID`=900400;
INSERT INTO `creature_template_spell` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_queststarter`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_queststarter` WHERE `id`=5202;
UPDATE `_qd_clone_rows` SET `id`=900400;
INSERT INTO `creature_queststarter` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_questender`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_questender` WHERE `id`=5202;
UPDATE `_qd_clone_rows` SET `id`=900400;
INSERT INTO `creature_questender` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `npc_spellclick_spells`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `npc_spellclick_spells` WHERE `npc_entry`=5202;
UPDATE `_qd_clone_rows` SET `npc_entry`=900400;
INSERT INTO `npc_spellclick_spells` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `smart_scripts`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `smart_scripts` WHERE `entryorguid`=5202 AND `source_type`=0;
UPDATE `_qd_clone_rows` SET `entryorguid`=900400;
INSERT INTO `smart_scripts` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
UPDATE `creature` SET `id`=900400 WHERE `id`=5202 AND `map`=530 AND `position_x` BETWEEN 11000 AND 13600 AND `position_y` BETWEEN -8500 AND -5500;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template` WHERE `entry`=6491;
UPDATE `_qd_clone_rows` SET `entry`=900401;
INSERT INTO `creature_template` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_equip_template`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_equip_template` WHERE `CreatureID`=6491;
UPDATE `_qd_clone_rows` SET `CreatureID`=900401;
INSERT INTO `creature_equip_template` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_addon`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_addon` WHERE `entry`=6491;
UPDATE `_qd_clone_rows` SET `entry`=900401;
INSERT INTO `creature_template_addon` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_locale`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_locale` WHERE `entry`=6491;
UPDATE `_qd_clone_rows` SET `entry`=900401;
INSERT INTO `creature_template_locale` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_model`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_model` WHERE `CreatureID`=6491;
UPDATE `_qd_clone_rows` SET `CreatureID`=900401;
INSERT INTO `creature_template_model` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_movement`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_movement` WHERE `CreatureId`=6491;
UPDATE `_qd_clone_rows` SET `CreatureId`=900401;
INSERT INTO `creature_template_movement` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_resistance`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_resistance` WHERE `CreatureID`=6491;
UPDATE `_qd_clone_rows` SET `CreatureID`=900401;
INSERT INTO `creature_template_resistance` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_spell`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_spell` WHERE `CreatureID`=6491;
UPDATE `_qd_clone_rows` SET `CreatureID`=900401;
INSERT INTO `creature_template_spell` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_queststarter`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_queststarter` WHERE `id`=6491;
UPDATE `_qd_clone_rows` SET `id`=900401;
INSERT INTO `creature_queststarter` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_questender`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_questender` WHERE `id`=6491;
UPDATE `_qd_clone_rows` SET `id`=900401;
INSERT INTO `creature_questender` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `npc_spellclick_spells`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `npc_spellclick_spells` WHERE `npc_entry`=6491;
UPDATE `_qd_clone_rows` SET `npc_entry`=900401;
INSERT INTO `npc_spellclick_spells` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `smart_scripts`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `smart_scripts` WHERE `entryorguid`=6491 AND `source_type`=0;
UPDATE `_qd_clone_rows` SET `entryorguid`=900401;
INSERT INTO `smart_scripts` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
UPDATE `creature` SET `id`=900401 WHERE `id`=6491 AND `map`=530 AND `position_x` BETWEEN 11000 AND 13600 AND `position_y` BETWEEN -8500 AND -5500;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template` WHERE `entry`=24938;
UPDATE `_qd_clone_rows` SET `entry`=900402;
INSERT INTO `creature_template` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_equip_template`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_equip_template` WHERE `CreatureID`=24938;
UPDATE `_qd_clone_rows` SET `CreatureID`=900402;
INSERT INTO `creature_equip_template` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_addon`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_addon` WHERE `entry`=24938;
UPDATE `_qd_clone_rows` SET `entry`=900402;
INSERT INTO `creature_template_addon` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_locale`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_locale` WHERE `entry`=24938;
UPDATE `_qd_clone_rows` SET `entry`=900402;
INSERT INTO `creature_template_locale` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_model`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_model` WHERE `CreatureID`=24938;
UPDATE `_qd_clone_rows` SET `CreatureID`=900402;
INSERT INTO `creature_template_model` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_movement`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_movement` WHERE `CreatureId`=24938;
UPDATE `_qd_clone_rows` SET `CreatureId`=900402;
INSERT INTO `creature_template_movement` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_resistance`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_resistance` WHERE `CreatureID`=24938;
UPDATE `_qd_clone_rows` SET `CreatureID`=900402;
INSERT INTO `creature_template_resistance` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_spell`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_spell` WHERE `CreatureID`=24938;
UPDATE `_qd_clone_rows` SET `CreatureID`=900402;
INSERT INTO `creature_template_spell` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_queststarter`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_queststarter` WHERE `id`=24938;
UPDATE `_qd_clone_rows` SET `id`=900402;
INSERT INTO `creature_queststarter` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_questender`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_questender` WHERE `id`=24938;
UPDATE `_qd_clone_rows` SET `id`=900402;
INSERT INTO `creature_questender` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `npc_spellclick_spells`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `npc_spellclick_spells` WHERE `npc_entry`=24938;
UPDATE `_qd_clone_rows` SET `npc_entry`=900402;
INSERT INTO `npc_spellclick_spells` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `smart_scripts`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `smart_scripts` WHERE `entryorguid`=24938 AND `source_type`=0;
UPDATE `_qd_clone_rows` SET `entryorguid`=900402;
INSERT INTO `smart_scripts` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
UPDATE `creature` SET `id`=900402 WHERE `id`=24938 AND `map`=530 AND `position_x` BETWEEN 11000 AND 13600 AND `position_y` BETWEEN -8500 AND -5500;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template` WHERE `entry`=25115;
UPDATE `_qd_clone_rows` SET `entry`=900403;
INSERT INTO `creature_template` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_equip_template`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_equip_template` WHERE `CreatureID`=25115;
UPDATE `_qd_clone_rows` SET `CreatureID`=900403;
INSERT INTO `creature_equip_template` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_addon`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_addon` WHERE `entry`=25115;
UPDATE `_qd_clone_rows` SET `entry`=900403;
INSERT INTO `creature_template_addon` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_locale`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_locale` WHERE `entry`=25115;
UPDATE `_qd_clone_rows` SET `entry`=900403;
INSERT INTO `creature_template_locale` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_model`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_model` WHERE `CreatureID`=25115;
UPDATE `_qd_clone_rows` SET `CreatureID`=900403;
INSERT INTO `creature_template_model` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_movement`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_movement` WHERE `CreatureId`=25115;
UPDATE `_qd_clone_rows` SET `CreatureId`=900403;
INSERT INTO `creature_template_movement` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_resistance`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_resistance` WHERE `CreatureID`=25115;
UPDATE `_qd_clone_rows` SET `CreatureID`=900403;
INSERT INTO `creature_template_resistance` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_spell`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_spell` WHERE `CreatureID`=25115;
UPDATE `_qd_clone_rows` SET `CreatureID`=900403;
INSERT INTO `creature_template_spell` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_queststarter`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_queststarter` WHERE `id`=25115;
UPDATE `_qd_clone_rows` SET `id`=900403;
INSERT INTO `creature_queststarter` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_questender`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_questender` WHERE `id`=25115;
UPDATE `_qd_clone_rows` SET `id`=900403;
INSERT INTO `creature_questender` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `npc_spellclick_spells`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `npc_spellclick_spells` WHERE `npc_entry`=25115;
UPDATE `_qd_clone_rows` SET `npc_entry`=900403;
INSERT INTO `npc_spellclick_spells` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `smart_scripts`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `smart_scripts` WHERE `entryorguid`=25115 AND `source_type`=0;
UPDATE `_qd_clone_rows` SET `entryorguid`=900403;
INSERT INTO `smart_scripts` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
UPDATE `creature` SET `id`=900403 WHERE `id`=25115 AND `map`=530 AND `position_x` BETWEEN 11000 AND 13600 AND `position_y` BETWEEN -8500 AND -5500;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template` WHERE `entry`=25953;
UPDATE `_qd_clone_rows` SET `entry`=900404;
INSERT INTO `creature_template` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_equip_template`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_equip_template` WHERE `CreatureID`=25953;
UPDATE `_qd_clone_rows` SET `CreatureID`=900404;
INSERT INTO `creature_equip_template` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_addon`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_addon` WHERE `entry`=25953;
UPDATE `_qd_clone_rows` SET `entry`=900404;
INSERT INTO `creature_template_addon` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_locale`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_locale` WHERE `entry`=25953;
UPDATE `_qd_clone_rows` SET `entry`=900404;
INSERT INTO `creature_template_locale` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_model`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_model` WHERE `CreatureID`=25953;
UPDATE `_qd_clone_rows` SET `CreatureID`=900404;
INSERT INTO `creature_template_model` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_movement`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_movement` WHERE `CreatureId`=25953;
UPDATE `_qd_clone_rows` SET `CreatureId`=900404;
INSERT INTO `creature_template_movement` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_resistance`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_resistance` WHERE `CreatureID`=25953;
UPDATE `_qd_clone_rows` SET `CreatureID`=900404;
INSERT INTO `creature_template_resistance` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_spell`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_spell` WHERE `CreatureID`=25953;
UPDATE `_qd_clone_rows` SET `CreatureID`=900404;
INSERT INTO `creature_template_spell` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_queststarter`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_queststarter` WHERE `id`=25953;
UPDATE `_qd_clone_rows` SET `id`=900404;
INSERT INTO `creature_queststarter` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_questender`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_questender` WHERE `id`=25953;
UPDATE `_qd_clone_rows` SET `id`=900404;
INSERT INTO `creature_questender` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `npc_spellclick_spells`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `npc_spellclick_spells` WHERE `npc_entry`=25953;
UPDATE `_qd_clone_rows` SET `npc_entry`=900404;
INSERT INTO `npc_spellclick_spells` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `smart_scripts`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `smart_scripts` WHERE `entryorguid`=25953 AND `source_type`=0;
UPDATE `_qd_clone_rows` SET `entryorguid`=900404;
INSERT INTO `smart_scripts` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
UPDATE `creature` SET `id`=900404 WHERE `id`=25953 AND `map`=530 AND `position_x` BETWEEN 11000 AND 13600 AND `position_y` BETWEEN -8500 AND -5500;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template` WHERE `entry`=9521;
UPDATE `_qd_clone_rows` SET `entry`=900405;
INSERT INTO `creature_template` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_equip_template`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_equip_template` WHERE `CreatureID`=9521;
UPDATE `_qd_clone_rows` SET `CreatureID`=900405;
INSERT INTO `creature_equip_template` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_addon`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_addon` WHERE `entry`=9521;
UPDATE `_qd_clone_rows` SET `entry`=900405;
INSERT INTO `creature_template_addon` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_locale`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_locale` WHERE `entry`=9521;
UPDATE `_qd_clone_rows` SET `entry`=900405;
INSERT INTO `creature_template_locale` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_model`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_model` WHERE `CreatureID`=9521;
UPDATE `_qd_clone_rows` SET `CreatureID`=900405;
INSERT INTO `creature_template_model` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_movement`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_movement` WHERE `CreatureId`=9521;
UPDATE `_qd_clone_rows` SET `CreatureId`=900405;
INSERT INTO `creature_template_movement` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_resistance`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_resistance` WHERE `CreatureID`=9521;
UPDATE `_qd_clone_rows` SET `CreatureID`=900405;
INSERT INTO `creature_template_resistance` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_template_spell`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_template_spell` WHERE `CreatureID`=9521;
UPDATE `_qd_clone_rows` SET `CreatureID`=900405;
INSERT INTO `creature_template_spell` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_queststarter`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_queststarter` WHERE `id`=9521;
UPDATE `_qd_clone_rows` SET `id`=900405;
INSERT INTO `creature_queststarter` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `creature_questender`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `creature_questender` WHERE `id`=9521;
UPDATE `_qd_clone_rows` SET `id`=900405;
INSERT INTO `creature_questender` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `npc_spellclick_spells`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `npc_spellclick_spells` WHERE `npc_entry`=9521;
UPDATE `_qd_clone_rows` SET `npc_entry`=900405;
INSERT INTO `npc_spellclick_spells` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
DROP TEMPORARY TABLE IF EXISTS `_qd_clone_rows`;
CREATE TEMPORARY TABLE `_qd_clone_rows` LIKE `smart_scripts`;
INSERT INTO `_qd_clone_rows` SELECT * FROM `smart_scripts` WHERE `entryorguid`=9521 AND `source_type`=0;
UPDATE `_qd_clone_rows` SET `entryorguid`=900405;
INSERT INTO `smart_scripts` SELECT * FROM `_qd_clone_rows`;
DROP TEMPORARY TABLE `_qd_clone_rows`;
UPDATE `smart_scripts` SET `action_param1`=900405 WHERE `source_type`=0 AND `entryorguid`=26560 AND `action_type`=12 AND `action_param1`=9521;
DROP TEMPORARY TABLE IF EXISTS `_qd_scaling`;
CREATE TEMPORARY TABLE `_qd_scaling` (`entry` INT UNSIGNED PRIMARY KEY, `factor` TINYINT UNSIGNED NOT NULL);
INSERT INTO `_qd_scaling` (`entry`,`factor`) VALUES
(900400,10),
(900401,10),
(900405,2),
(18562,10),
(23310,10),
(24813,10),
(900402,10),
(24960,2),
(24965,10),
(24966,2),
(24967,10),
(24972,2),
(24975,10),
(24976,2),
(24978,2),
(24979,2),
(24980,10),
(24991,10),
(24994,10),
(24999,2),
(25001,2),
(25002,2),
(25003,2),
(25027,2),
(25028,2),
(25030,2),
(25031,2),
(25032,10),
(25033,2),
(25034,10),
(25035,10),
(25036,10),
(25037,10),
(25039,10),
(25043,10),
(25045,10),
(25046,10),
(25049,2),
(25057,10),
(25059,10),
(25060,2),
(25061,10),
(25063,2),
(25069,10),
(25073,2),
(25084,2),
(25087,2),
(25088,10),
(25090,10),
(25091,10),
(25092,10),
(25108,10),
(25112,10),
(900403,10),
(25132,2),
(25133,10),
(25144,10),
(25154,10),
(25156,10),
(25157,10),
(25158,2),
(25160,10),
(25162,10),
(25163,10),
(25164,10),
(25169,10),
(25170,10),
(25174,10),
(25175,10),
(25192,10),
(25225,10),
(25236,10),
(25950,10),
(900404,2),
(25976,10),
(25977,10),
(26089,10),
(26090,10),
(26091,10),
(26092,10),
(26253,10),
(26560,10),
(37527,10);
DROP TEMPORARY TABLE IF EXISTS `_qd_scaled_values`;
CREATE TEMPORARY TABLE `_qd_scaled_values` AS
SELECT ct.`entry`,
       (CEIL((CASE ct.`exp` WHEN 0 THEN oldstat.`basehp0` WHEN 1 THEN oldstat.`basehp1` ELSE oldstat.`basehp2` END) * ct.`HealthModifier`) * s.`factor`) AS `target_health`,
       ((CEIL((CASE ct.`exp` WHEN 0 THEN oldstat.`basehp0` WHEN 1 THEN oldstat.`basehp1` ELSE oldstat.`basehp2` END) * ct.`HealthModifier`) * s.`factor`) - 0.5) / newstat.`basehp2` AS `target_health_modifier`,
       ct.`DamageModifier` * (CASE ct.`exp` WHEN 0 THEN oldstat.`damage_base` WHEN 1 THEN oldstat.`damage_exp1` ELSE oldstat.`damage_exp2` END) / newstat.`damage_exp2` AS `target_damage_modifier`,
       ct.`BaseVariance` * (oldstat.`attackpower` / (CASE ct.`exp` WHEN 0 THEN oldstat.`damage_base` WHEN 1 THEN oldstat.`damage_exp1` ELSE oldstat.`damage_exp2` END)) * (newstat.`damage_exp2` / newstat.`attackpower`) AS `target_base_variance`,
       ct.`RangeVariance` * (oldstat.`rangedattackpower` / (CASE ct.`exp` WHEN 0 THEN oldstat.`damage_base` WHEN 1 THEN oldstat.`damage_exp1` ELSE oldstat.`damage_exp2` END)) * (newstat.`damage_exp2` / newstat.`rangedattackpower`) AS `target_range_variance`
FROM `creature_template` ct
JOIN `_qd_scaling` s ON s.`entry`=ct.`entry`
JOIN `creature_classlevelstats` oldstat ON oldstat.`level`=ct.`maxlevel` AND oldstat.`class`=ct.`unit_class`
JOIN `creature_classlevelstats` newstat ON newstat.`level`=80 AND newstat.`class`=ct.`unit_class`;
UPDATE `creature_template` ct
JOIN `_qd_scaled_values` v ON v.`entry`=ct.`entry`
SET ct.`minlevel`=80, ct.`maxlevel`=80, ct.`exp`=2,
    ct.`HealthModifier`=v.`target_health_modifier`,
    ct.`DamageModifier`=v.`target_damage_modifier`,
    ct.`BaseVariance`=v.`target_base_variance`,
    ct.`RangeVariance`=v.`target_range_variance`;
DROP TEMPORARY TABLE `_qd_scaled_values`;
DROP TEMPORARY TABLE `_qd_scaling`;

UPDATE `quest_template` SET `QuestLevel`=80, `MinLevel`=80 WHERE `ID` IN (11481,11482,11488,11492,11496,11520,11521,11523,11524,11525,11526,11532,11533,11535,11536,11537,11538,11539,11540,11541,11542,11543,11544,11545,11546,11547,11548,11549,11550,11554,11555,11556,11557,24522,24535,24553,24562,24563,24564,24594,24595,24596,24598);
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11496;
UPDATE `quest_template` SET `RewardItem2`=900300, `RewardAmount2`=1 WHERE `ID`=11520;
UPDATE `quest_template` SET `RewardItem2`=900300, `RewardAmount2`=1 WHERE `ID`=11521;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11523;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11524;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11525;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11532;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11533;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11535;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11536;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11537;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11538;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11539;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11540;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11541;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11542;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11543;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11544;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11545;
UPDATE `quest_template` SET `RewardItem2`=900300, `RewardAmount2`=1 WHERE `ID`=11546;
UPDATE `quest_template` SET `RewardItem2`=900300, `RewardAmount2`=1 WHERE `ID`=11547;
UPDATE `quest_template` SET `RewardItem1`=900300, `RewardAmount1`=1 WHERE `ID`=11548;
UPDATE `quest_template` SET `RewardSpell`=80920 WHERE `ID`=11548;
DROP TEMPORARY TABLE IF EXISTS `_qd_item`;
CREATE TEMPORARY TABLE `_qd_item` LIKE `item_template`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=49426;
UPDATE `_qd_item` SET `entry`=900300, `name`='Mark of Honor', `displayid`=900300,
`description`='These marks can be exchanged for various weapons and armor at equipment vendors.',
`Flags`=(`Flags` & ~134217728), `FlagsExtra`=0, `BagFamily`=8192, `stackable`=200,
`RequiredLevel`=80, `ItemLevel`=80, `VerifiedBuild`=0;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34665;
UPDATE `_qd_item` SET `entry`=900301, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=45448 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`,
    t.`spellid_1`=d.`spellid_1`,
    t.`spelltrigger_1`=d.`spelltrigger_1`,
    t.`spellcharges_1`=d.`spellcharges_1`,
    t.`spellppmRate_1`=d.`spellppmRate_1`,
    t.`spellcooldown_1`=d.`spellcooldown_1`,
    t.`spellcategory_1`=d.`spellcategory_1`,
    t.`spellcategorycooldown_1`=d.`spellcategorycooldown_1`,
    t.`spellid_2`=d.`spellid_2`,
    t.`spelltrigger_2`=d.`spelltrigger_2`,
    t.`spellcharges_2`=d.`spellcharges_2`,
    t.`spellppmRate_2`=d.`spellppmRate_2`,
    t.`spellcooldown_2`=d.`spellcooldown_2`,
    t.`spellcategory_2`=d.`spellcategory_2`,
    t.`spellcategorycooldown_2`=d.`spellcategorycooldown_2`,
    t.`spellid_3`=d.`spellid_3`,
    t.`spelltrigger_3`=d.`spelltrigger_3`,
    t.`spellcharges_3`=d.`spellcharges_3`,
    t.`spellppmRate_3`=d.`spellppmRate_3`,
    t.`spellcooldown_3`=d.`spellcooldown_3`,
    t.`spellcategory_3`=d.`spellcategory_3`,
    t.`spellcategorycooldown_3`=d.`spellcategorycooldown_3`,
    t.`spellid_4`=d.`spellid_4`,
    t.`spelltrigger_4`=d.`spelltrigger_4`,
    t.`spellcharges_4`=d.`spellcharges_4`,
    t.`spellppmRate_4`=d.`spellppmRate_4`,
    t.`spellcooldown_4`=d.`spellcooldown_4`,
    t.`spellcategory_4`=d.`spellcategory_4`,
    t.`spellcategorycooldown_4`=d.`spellcategorycooldown_4`,
    t.`spellid_5`=d.`spellid_5`,
    t.`spelltrigger_5`=d.`spelltrigger_5`,
    t.`spellcharges_5`=d.`spellcharges_5`,
    t.`spellppmRate_5`=d.`spellppmRate_5`,
    t.`spellcooldown_5`=d.`spellcooldown_5`,
    t.`spellcategory_5`=d.`spellcategory_5`,
    t.`spellcategorycooldown_5`=d.`spellcategorycooldown_5`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34666;
UPDATE `_qd_item` SET `entry`=900302, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=45142 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`,
    t.`spellid_1`=d.`spellid_1`,
    t.`spelltrigger_1`=d.`spelltrigger_1`,
    t.`spellcharges_1`=d.`spellcharges_1`,
    t.`spellppmRate_1`=d.`spellppmRate_1`,
    t.`spellcooldown_1`=d.`spellcooldown_1`,
    t.`spellcategory_1`=d.`spellcategory_1`,
    t.`spellcategorycooldown_1`=d.`spellcategorycooldown_1`,
    t.`spellid_2`=d.`spellid_2`,
    t.`spelltrigger_2`=d.`spelltrigger_2`,
    t.`spellcharges_2`=d.`spellcharges_2`,
    t.`spellppmRate_2`=d.`spellppmRate_2`,
    t.`spellcooldown_2`=d.`spellcooldown_2`,
    t.`spellcategory_2`=d.`spellcategory_2`,
    t.`spellcategorycooldown_2`=d.`spellcategorycooldown_2`,
    t.`spellid_3`=d.`spellid_3`,
    t.`spelltrigger_3`=d.`spelltrigger_3`,
    t.`spellcharges_3`=d.`spellcharges_3`,
    t.`spellppmRate_3`=d.`spellppmRate_3`,
    t.`spellcooldown_3`=d.`spellcooldown_3`,
    t.`spellcategory_3`=d.`spellcategory_3`,
    t.`spellcategorycooldown_3`=d.`spellcategorycooldown_3`,
    t.`spellid_4`=d.`spellid_4`,
    t.`spelltrigger_4`=d.`spelltrigger_4`,
    t.`spellcharges_4`=d.`spellcharges_4`,
    t.`spellppmRate_4`=d.`spellppmRate_4`,
    t.`spellcooldown_4`=d.`spellcooldown_4`,
    t.`spellcategory_4`=d.`spellcategory_4`,
    t.`spellcategorycooldown_4`=d.`spellcategorycooldown_4`,
    t.`spellid_5`=d.`spellid_5`,
    t.`spelltrigger_5`=d.`spelltrigger_5`,
    t.`spellcharges_5`=d.`spellcharges_5`,
    t.`spellppmRate_5`=d.`spellppmRate_5`,
    t.`spellcooldown_5`=d.`spellcooldown_5`,
    t.`spellcategory_5`=d.`spellcategory_5`,
    t.`spellcategorycooldown_5`=d.`spellcategorycooldown_5`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34667;
UPDATE `_qd_item` SET `entry`=900303, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=45437 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`,
    t.`spellid_1`=d.`spellid_1`,
    t.`spelltrigger_1`=d.`spelltrigger_1`,
    t.`spellcharges_1`=d.`spellcharges_1`,
    t.`spellppmRate_1`=d.`spellppmRate_1`,
    t.`spellcooldown_1`=d.`spellcooldown_1`,
    t.`spellcategory_1`=d.`spellcategory_1`,
    t.`spellcategorycooldown_1`=d.`spellcategorycooldown_1`,
    t.`spellid_2`=d.`spellid_2`,
    t.`spelltrigger_2`=d.`spelltrigger_2`,
    t.`spellcharges_2`=d.`spellcharges_2`,
    t.`spellppmRate_2`=d.`spellppmRate_2`,
    t.`spellcooldown_2`=d.`spellcooldown_2`,
    t.`spellcategory_2`=d.`spellcategory_2`,
    t.`spellcategorycooldown_2`=d.`spellcategorycooldown_2`,
    t.`spellid_3`=d.`spellid_3`,
    t.`spelltrigger_3`=d.`spelltrigger_3`,
    t.`spellcharges_3`=d.`spellcharges_3`,
    t.`spellppmRate_3`=d.`spellppmRate_3`,
    t.`spellcooldown_3`=d.`spellcooldown_3`,
    t.`spellcategory_3`=d.`spellcategory_3`,
    t.`spellcategorycooldown_3`=d.`spellcategorycooldown_3`,
    t.`spellid_4`=d.`spellid_4`,
    t.`spelltrigger_4`=d.`spelltrigger_4`,
    t.`spellcharges_4`=d.`spellcharges_4`,
    t.`spellppmRate_4`=d.`spellppmRate_4`,
    t.`spellcooldown_4`=d.`spellcooldown_4`,
    t.`spellcategory_4`=d.`spellcategory_4`,
    t.`spellcategorycooldown_4`=d.`spellcategorycooldown_4`,
    t.`spellid_5`=d.`spellid_5`,
    t.`spelltrigger_5`=d.`spelltrigger_5`,
    t.`spellcharges_5`=d.`spellcharges_5`,
    t.`spellppmRate_5`=d.`spellppmRate_5`,
    t.`spellcooldown_5`=d.`spellcooldown_5`,
    t.`spellcategory_5`=d.`spellcategory_5`,
    t.`spellcategorycooldown_5`=d.`spellcategorycooldown_5`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34670;
UPDATE `_qd_item` SET `entry`=900304, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=45147 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`,
    t.`spellid_1`=d.`spellid_1`,
    t.`spelltrigger_1`=d.`spelltrigger_1`,
    t.`spellcharges_1`=d.`spellcharges_1`,
    t.`spellppmRate_1`=d.`spellppmRate_1`,
    t.`spellcooldown_1`=d.`spellcooldown_1`,
    t.`spellcategory_1`=d.`spellcategory_1`,
    t.`spellcategorycooldown_1`=d.`spellcategorycooldown_1`,
    t.`spellid_2`=d.`spellid_2`,
    t.`spelltrigger_2`=d.`spelltrigger_2`,
    t.`spellcharges_2`=d.`spellcharges_2`,
    t.`spellppmRate_2`=d.`spellppmRate_2`,
    t.`spellcooldown_2`=d.`spellcooldown_2`,
    t.`spellcategory_2`=d.`spellcategory_2`,
    t.`spellcategorycooldown_2`=d.`spellcategorycooldown_2`,
    t.`spellid_3`=d.`spellid_3`,
    t.`spelltrigger_3`=d.`spelltrigger_3`,
    t.`spellcharges_3`=d.`spellcharges_3`,
    t.`spellppmRate_3`=d.`spellppmRate_3`,
    t.`spellcooldown_3`=d.`spellcooldown_3`,
    t.`spellcategory_3`=d.`spellcategory_3`,
    t.`spellcategorycooldown_3`=d.`spellcategorycooldown_3`,
    t.`spellid_4`=d.`spellid_4`,
    t.`spelltrigger_4`=d.`spelltrigger_4`,
    t.`spellcharges_4`=d.`spellcharges_4`,
    t.`spellppmRate_4`=d.`spellppmRate_4`,
    t.`spellcooldown_4`=d.`spellcooldown_4`,
    t.`spellcategory_4`=d.`spellcategory_4`,
    t.`spellcategorycooldown_4`=d.`spellcategorycooldown_4`,
    t.`spellid_5`=d.`spellid_5`,
    t.`spelltrigger_5`=d.`spelltrigger_5`,
    t.`spellcharges_5`=d.`spellcharges_5`,
    t.`spellppmRate_5`=d.`spellppmRate_5`,
    t.`spellcooldown_5`=d.`spellcooldown_5`,
    t.`spellcategory_5`=d.`spellcategory_5`,
    t.`spellcategorycooldown_5`=d.`spellcategorycooldown_5`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34671;
UPDATE `_qd_item` SET `entry`=900305, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=46035 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`,
    t.`spellid_1`=d.`spellid_1`,
    t.`spelltrigger_1`=d.`spelltrigger_1`,
    t.`spellcharges_1`=d.`spellcharges_1`,
    t.`spellppmRate_1`=d.`spellppmRate_1`,
    t.`spellcooldown_1`=d.`spellcooldown_1`,
    t.`spellcategory_1`=d.`spellcategory_1`,
    t.`spellcategorycooldown_1`=d.`spellcategorycooldown_1`,
    t.`spellid_2`=d.`spellid_2`,
    t.`spelltrigger_2`=d.`spelltrigger_2`,
    t.`spellcharges_2`=d.`spellcharges_2`,
    t.`spellppmRate_2`=d.`spellppmRate_2`,
    t.`spellcooldown_2`=d.`spellcooldown_2`,
    t.`spellcategory_2`=d.`spellcategory_2`,
    t.`spellcategorycooldown_2`=d.`spellcategorycooldown_2`,
    t.`spellid_3`=d.`spellid_3`,
    t.`spelltrigger_3`=d.`spelltrigger_3`,
    t.`spellcharges_3`=d.`spellcharges_3`,
    t.`spellppmRate_3`=d.`spellppmRate_3`,
    t.`spellcooldown_3`=d.`spellcooldown_3`,
    t.`spellcategory_3`=d.`spellcategory_3`,
    t.`spellcategorycooldown_3`=d.`spellcategorycooldown_3`,
    t.`spellid_4`=d.`spellid_4`,
    t.`spelltrigger_4`=d.`spelltrigger_4`,
    t.`spellcharges_4`=d.`spellcharges_4`,
    t.`spellppmRate_4`=d.`spellppmRate_4`,
    t.`spellcooldown_4`=d.`spellcooldown_4`,
    t.`spellcategory_4`=d.`spellcategory_4`,
    t.`spellcategorycooldown_4`=d.`spellcategorycooldown_4`,
    t.`spellid_5`=d.`spellid_5`,
    t.`spelltrigger_5`=d.`spelltrigger_5`,
    t.`spellcharges_5`=d.`spellcharges_5`,
    t.`spellppmRate_5`=d.`spellppmRate_5`,
    t.`spellcooldown_5`=d.`spellcooldown_5`,
    t.`spellcategory_5`=d.`spellcategory_5`,
    t.`spellcategorycooldown_5`=d.`spellcategorycooldown_5`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34672;
UPDATE `_qd_item` SET `entry`=900306, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=45110 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`,
    t.`spellid_1`=d.`spellid_1`,
    t.`spelltrigger_1`=d.`spelltrigger_1`,
    t.`spellcharges_1`=d.`spellcharges_1`,
    t.`spellppmRate_1`=d.`spellppmRate_1`,
    t.`spellcooldown_1`=d.`spellcooldown_1`,
    t.`spellcategory_1`=d.`spellcategory_1`,
    t.`spellcategorycooldown_1`=d.`spellcategorycooldown_1`,
    t.`spellid_2`=d.`spellid_2`,
    t.`spelltrigger_2`=d.`spelltrigger_2`,
    t.`spellcharges_2`=d.`spellcharges_2`,
    t.`spellppmRate_2`=d.`spellppmRate_2`,
    t.`spellcooldown_2`=d.`spellcooldown_2`,
    t.`spellcategory_2`=d.`spellcategory_2`,
    t.`spellcategorycooldown_2`=d.`spellcategorycooldown_2`,
    t.`spellid_3`=d.`spellid_3`,
    t.`spelltrigger_3`=d.`spelltrigger_3`,
    t.`spellcharges_3`=d.`spellcharges_3`,
    t.`spellppmRate_3`=d.`spellppmRate_3`,
    t.`spellcooldown_3`=d.`spellcooldown_3`,
    t.`spellcategory_3`=d.`spellcategory_3`,
    t.`spellcategorycooldown_3`=d.`spellcategorycooldown_3`,
    t.`spellid_4`=d.`spellid_4`,
    t.`spelltrigger_4`=d.`spelltrigger_4`,
    t.`spellcharges_4`=d.`spellcharges_4`,
    t.`spellppmRate_4`=d.`spellppmRate_4`,
    t.`spellcooldown_4`=d.`spellcooldown_4`,
    t.`spellcategory_4`=d.`spellcategory_4`,
    t.`spellcategorycooldown_4`=d.`spellcategorycooldown_4`,
    t.`spellid_5`=d.`spellid_5`,
    t.`spelltrigger_5`=d.`spelltrigger_5`,
    t.`spellcharges_5`=d.`spellcharges_5`,
    t.`spellppmRate_5`=d.`spellppmRate_5`,
    t.`spellcooldown_5`=d.`spellcooldown_5`,
    t.`spellcategory_5`=d.`spellcategory_5`,
    t.`spellcategorycooldown_5`=d.`spellcategorycooldown_5`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34673;
UPDATE `_qd_item` SET `entry`=900307, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=45165 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`,
    t.`spellid_1`=d.`spellid_1`,
    t.`spelltrigger_1`=d.`spelltrigger_1`,
    t.`spellcharges_1`=d.`spellcharges_1`,
    t.`spellppmRate_1`=d.`spellppmRate_1`,
    t.`spellcooldown_1`=d.`spellcooldown_1`,
    t.`spellcategory_1`=d.`spellcategory_1`,
    t.`spellcategorycooldown_1`=d.`spellcategorycooldown_1`,
    t.`spellid_2`=d.`spellid_2`,
    t.`spelltrigger_2`=d.`spelltrigger_2`,
    t.`spellcharges_2`=d.`spellcharges_2`,
    t.`spellppmRate_2`=d.`spellppmRate_2`,
    t.`spellcooldown_2`=d.`spellcooldown_2`,
    t.`spellcategory_2`=d.`spellcategory_2`,
    t.`spellcategorycooldown_2`=d.`spellcategorycooldown_2`,
    t.`spellid_3`=d.`spellid_3`,
    t.`spelltrigger_3`=d.`spelltrigger_3`,
    t.`spellcharges_3`=d.`spellcharges_3`,
    t.`spellppmRate_3`=d.`spellppmRate_3`,
    t.`spellcooldown_3`=d.`spellcooldown_3`,
    t.`spellcategory_3`=d.`spellcategory_3`,
    t.`spellcategorycooldown_3`=d.`spellcategorycooldown_3`,
    t.`spellid_4`=d.`spellid_4`,
    t.`spelltrigger_4`=d.`spelltrigger_4`,
    t.`spellcharges_4`=d.`spellcharges_4`,
    t.`spellppmRate_4`=d.`spellppmRate_4`,
    t.`spellcooldown_4`=d.`spellcooldown_4`,
    t.`spellcategory_4`=d.`spellcategory_4`,
    t.`spellcategorycooldown_4`=d.`spellcategorycooldown_4`,
    t.`spellid_5`=d.`spellid_5`,
    t.`spelltrigger_5`=d.`spelltrigger_5`,
    t.`spellcharges_5`=d.`spellcharges_5`,
    t.`spellppmRate_5`=d.`spellppmRate_5`,
    t.`spellcooldown_5`=d.`spellcooldown_5`,
    t.`spellcategory_5`=d.`spellcategory_5`,
    t.`spellcategorycooldown_5`=d.`spellcategorycooldown_5`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34674;
UPDATE `_qd_item` SET `entry`=900308, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=47741 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`,
    t.`spellid_1`=d.`spellid_1`,
    t.`spelltrigger_1`=d.`spelltrigger_1`,
    t.`spellcharges_1`=d.`spellcharges_1`,
    t.`spellppmRate_1`=d.`spellppmRate_1`,
    t.`spellcooldown_1`=d.`spellcooldown_1`,
    t.`spellcategory_1`=d.`spellcategory_1`,
    t.`spellcategorycooldown_1`=d.`spellcategorycooldown_1`,
    t.`spellid_2`=d.`spellid_2`,
    t.`spelltrigger_2`=d.`spelltrigger_2`,
    t.`spellcharges_2`=d.`spellcharges_2`,
    t.`spellppmRate_2`=d.`spellppmRate_2`,
    t.`spellcooldown_2`=d.`spellcooldown_2`,
    t.`spellcategory_2`=d.`spellcategory_2`,
    t.`spellcategorycooldown_2`=d.`spellcategorycooldown_2`,
    t.`spellid_3`=d.`spellid_3`,
    t.`spelltrigger_3`=d.`spelltrigger_3`,
    t.`spellcharges_3`=d.`spellcharges_3`,
    t.`spellppmRate_3`=d.`spellppmRate_3`,
    t.`spellcooldown_3`=d.`spellcooldown_3`,
    t.`spellcategory_3`=d.`spellcategory_3`,
    t.`spellcategorycooldown_3`=d.`spellcategorycooldown_3`,
    t.`spellid_4`=d.`spellid_4`,
    t.`spelltrigger_4`=d.`spelltrigger_4`,
    t.`spellcharges_4`=d.`spellcharges_4`,
    t.`spellppmRate_4`=d.`spellppmRate_4`,
    t.`spellcooldown_4`=d.`spellcooldown_4`,
    t.`spellcategory_4`=d.`spellcategory_4`,
    t.`spellcategorycooldown_4`=d.`spellcategorycooldown_4`,
    t.`spellid_5`=d.`spellid_5`,
    t.`spelltrigger_5`=d.`spelltrigger_5`,
    t.`spellcharges_5`=d.`spellcharges_5`,
    t.`spellppmRate_5`=d.`spellppmRate_5`,
    t.`spellcooldown_5`=d.`spellcooldown_5`,
    t.`spellcategory_5`=d.`spellcategory_5`,
    t.`spellcategorycooldown_5`=d.`spellcategorycooldown_5`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34675;
UPDATE `_qd_item` SET `entry`=900309, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=45887 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`,
    t.`spellid_1`=d.`spellid_1`,
    t.`spelltrigger_1`=d.`spelltrigger_1`,
    t.`spellcharges_1`=d.`spellcharges_1`,
    t.`spellppmRate_1`=d.`spellppmRate_1`,
    t.`spellcooldown_1`=d.`spellcooldown_1`,
    t.`spellcategory_1`=d.`spellcategory_1`,
    t.`spellcategorycooldown_1`=d.`spellcategorycooldown_1`,
    t.`spellid_2`=d.`spellid_2`,
    t.`spelltrigger_2`=d.`spelltrigger_2`,
    t.`spellcharges_2`=d.`spellcharges_2`,
    t.`spellppmRate_2`=d.`spellppmRate_2`,
    t.`spellcooldown_2`=d.`spellcooldown_2`,
    t.`spellcategory_2`=d.`spellcategory_2`,
    t.`spellcategorycooldown_2`=d.`spellcategorycooldown_2`,
    t.`spellid_3`=d.`spellid_3`,
    t.`spelltrigger_3`=d.`spelltrigger_3`,
    t.`spellcharges_3`=d.`spellcharges_3`,
    t.`spellppmRate_3`=d.`spellppmRate_3`,
    t.`spellcooldown_3`=d.`spellcooldown_3`,
    t.`spellcategory_3`=d.`spellcategory_3`,
    t.`spellcategorycooldown_3`=d.`spellcategorycooldown_3`,
    t.`spellid_4`=d.`spellid_4`,
    t.`spelltrigger_4`=d.`spelltrigger_4`,
    t.`spellcharges_4`=d.`spellcharges_4`,
    t.`spellppmRate_4`=d.`spellppmRate_4`,
    t.`spellcooldown_4`=d.`spellcooldown_4`,
    t.`spellcategory_4`=d.`spellcategory_4`,
    t.`spellcategorycooldown_4`=d.`spellcategorycooldown_4`,
    t.`spellid_5`=d.`spellid_5`,
    t.`spelltrigger_5`=d.`spelltrigger_5`,
    t.`spellcharges_5`=d.`spellcharges_5`,
    t.`spellppmRate_5`=d.`spellppmRate_5`,
    t.`spellcooldown_5`=d.`spellcooldown_5`,
    t.`spellcategory_5`=d.`spellcategory_5`,
    t.`spellcategorycooldown_5`=d.`spellcategorycooldown_5`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34676;
UPDATE `_qd_item` SET `entry`=900310, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=45877 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`,
    t.`spellid_1`=d.`spellid_1`,
    t.`spelltrigger_1`=d.`spelltrigger_1`,
    t.`spellcharges_1`=d.`spellcharges_1`,
    t.`spellppmRate_1`=d.`spellppmRate_1`,
    t.`spellcooldown_1`=d.`spellcooldown_1`,
    t.`spellcategory_1`=d.`spellcategory_1`,
    t.`spellcategorycooldown_1`=d.`spellcategorycooldown_1`,
    t.`spellid_2`=d.`spellid_2`,
    t.`spelltrigger_2`=d.`spelltrigger_2`,
    t.`spellcharges_2`=d.`spellcharges_2`,
    t.`spellppmRate_2`=d.`spellppmRate_2`,
    t.`spellcooldown_2`=d.`spellcooldown_2`,
    t.`spellcategory_2`=d.`spellcategory_2`,
    t.`spellcategorycooldown_2`=d.`spellcategorycooldown_2`,
    t.`spellid_3`=d.`spellid_3`,
    t.`spelltrigger_3`=d.`spelltrigger_3`,
    t.`spellcharges_3`=d.`spellcharges_3`,
    t.`spellppmRate_3`=d.`spellppmRate_3`,
    t.`spellcooldown_3`=d.`spellcooldown_3`,
    t.`spellcategory_3`=d.`spellcategory_3`,
    t.`spellcategorycooldown_3`=d.`spellcategorycooldown_3`,
    t.`spellid_4`=d.`spellid_4`,
    t.`spelltrigger_4`=d.`spelltrigger_4`,
    t.`spellcharges_4`=d.`spellcharges_4`,
    t.`spellppmRate_4`=d.`spellppmRate_4`,
    t.`spellcooldown_4`=d.`spellcooldown_4`,
    t.`spellcategory_4`=d.`spellcategory_4`,
    t.`spellcategorycooldown_4`=d.`spellcategorycooldown_4`,
    t.`spellid_5`=d.`spellid_5`,
    t.`spelltrigger_5`=d.`spelltrigger_5`,
    t.`spellcharges_5`=d.`spellcharges_5`,
    t.`spellppmRate_5`=d.`spellppmRate_5`,
    t.`spellcooldown_5`=d.`spellcooldown_5`,
    t.`spellcategory_5`=d.`spellcategory_5`,
    t.`spellcategorycooldown_5`=d.`spellcategorycooldown_5`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34677;
UPDATE `_qd_item` SET `entry`=900311, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=47619 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34678;
UPDATE `_qd_item` SET `entry`=900312, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=50211 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34679;
UPDATE `_qd_item` SET `entry`=900313, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=47607 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=34680;
UPDATE `_qd_item` SET `entry`=900314, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
UPDATE `_qd_item` t JOIN `item_template` d ON d.`entry`=47679 SET
    t.`stat_type1`=d.`stat_type1`,
    t.`stat_value1`=d.`stat_value1`,
    t.`stat_type2`=d.`stat_type2`,
    t.`stat_value2`=d.`stat_value2`,
    t.`stat_type3`=d.`stat_type3`,
    t.`stat_value3`=d.`stat_value3`,
    t.`stat_type4`=d.`stat_type4`,
    t.`stat_value4`=d.`stat_value4`,
    t.`stat_type5`=d.`stat_type5`,
    t.`stat_value5`=d.`stat_value5`,
    t.`stat_type6`=d.`stat_type6`,
    t.`stat_value6`=d.`stat_value6`,
    t.`stat_type7`=d.`stat_type7`,
    t.`stat_value7`=d.`stat_value7`,
    t.`stat_type8`=d.`stat_type8`,
    t.`stat_value8`=d.`stat_value8`,
    t.`stat_type9`=d.`stat_type9`,
    t.`stat_value9`=d.`stat_value9`,
    t.`stat_type10`=d.`stat_type10`,
    t.`stat_value10`=d.`stat_value10`,
    t.`dmg_min1`=d.`dmg_min1`,
    t.`dmg_max1`=d.`dmg_max1`,
    t.`dmg_type1`=d.`dmg_type1`,
    t.`dmg_min2`=d.`dmg_min2`,
    t.`dmg_max2`=d.`dmg_max2`,
    t.`dmg_type2`=d.`dmg_type2`,
    t.`armor`=d.`armor`,
    t.`holy_res`=d.`holy_res`,
    t.`fire_res`=d.`fire_res`,
    t.`nature_res`=d.`nature_res`,
    t.`frost_res`=d.`frost_res`,
    t.`shadow_res`=d.`shadow_res`,
    t.`arcane_res`=d.`arcane_res`,
    t.`delay`=d.`delay`,
    t.`ammo_type`=d.`ammo_type`,
    t.`RangedModRange`=d.`RangedModRange`,
    t.`block`=d.`block`,
    t.`MaxDurability`=d.`MaxDurability`,
    t.`socketColor_1`=d.`socketColor_1`,
    t.`socketContent_1`=d.`socketContent_1`,
    t.`socketColor_2`=d.`socketColor_2`,
    t.`socketContent_2`=d.`socketContent_2`,
    t.`socketColor_3`=d.`socketColor_3`,
    t.`socketContent_3`=d.`socketContent_3`,
    t.`socketBonus`=d.`socketBonus`,
    t.`GemProperties`=d.`GemProperties`,
    t.`RequiredDisenchantSkill`=d.`RequiredDisenchantSkill`,
    t.`ArmorDamageModifier`=d.`ArmorDamageModifier`,
    t.`DisenchantID`=d.`DisenchantID`;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
INSERT INTO `_qd_item` SELECT * FROM `item_template` WHERE `entry`=35221;
UPDATE `_qd_item` SET `entry`=900315, `Quality`=4, `ItemLevel`=232, `RequiredLevel`=80, `VerifiedBuild`=0;
INSERT INTO `item_template` SELECT * FROM `_qd_item`;
TRUNCATE TABLE `_qd_item`;
DROP TEMPORARY TABLE `_qd_item`;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) VALUES
(900300,'ruRU',CONVERT(0xD09FD0BED187D0B5D182D0BDD18BD0B920D0B7D0BDD0B0D0BA USING utf8mb4),CONVERT(0xD0ADD182D0B820D0B7D0BDD0B0D0BAD0B820D0BCD0BED0B6D0BDD0BE20D0BED0B1D0BCD0B5D0BDD18FD182D18C20D0BDD0B020D180D0B0D0B7D0BBD0B8D187D0BDD0BED0B520D0BED180D183D0B6D0B8D0B520D0B820D0B4D0BED181D0BFD0B5D185D0B820D18320D182D0BED180D0B3D0BED0B2D186D0B5D0B220D181D0BDD0B0D180D18FD0B6D0B5D0BDD0B8D0B5D0BC2E USING utf8mb4),0);
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900301,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34665;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900302,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34666;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900303,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34667;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900304,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34670;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900305,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34671;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900306,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34672;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900307,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34673;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900308,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34674;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900309,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34675;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900310,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34676;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900311,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34677;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900312,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34678;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900313,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34679;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900314,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=34680;
INSERT INTO `item_template_locale` (`ID`,`locale`,`Name`,`Description`,`VerifiedBuild`) SELECT 900315,`locale`,`Name`,`Description`,0 FROM `item_template_locale` WHERE `ID`=35221;
DELETE FROM `npc_vendor` WHERE `entry`=25032 AND `item` IN (34665,34666,34667,34670,34671,34672,34673,34674,34675,34676,34677,34678,34679,34680,35221);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`VerifiedBuild`) VALUES
(25032,0,900301,0,0,5000,0),
(25032,0,900302,0,0,5001,0),
(25032,0,900303,0,0,5002,0),
(25032,0,900304,0,0,5003,0),
(25032,0,900305,0,0,5004,0),
(25032,0,900306,0,0,5005,0),
(25032,0,900307,0,0,5006,0),
(25032,0,900308,0,0,5007,0),
(25032,0,900309,0,0,0,0),
(25032,0,900310,0,0,0,0),
(25032,0,900311,0,0,0,0),
(25032,0,900312,0,0,0,0),
(25032,0,900313,0,0,0,0),
(25032,0,900314,0,0,0,0),
(25032,0,900315,0,0,0,0);
SET SESSION sql_mode=@QD_OLD_SQL_MODE;
