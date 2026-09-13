-- jc-2026-08-28-queldanas-clone-dependencies-v1
-- Complete creature clones with their equipment rows and keep the only linked
-- difficulty template on the same expansion as its scaled base template.
START TRANSACTION;

DELETE FROM `creature_equip_template` WHERE `CreatureID` BETWEEN 900400 AND 900405;

DROP TEMPORARY TABLE IF EXISTS `_qd_clone_equipment`;
CREATE TEMPORARY TABLE `_qd_clone_equipment` LIKE `creature_equip_template`;
INSERT INTO `_qd_clone_equipment` SELECT * FROM `creature_equip_template` WHERE `CreatureID`=24938;
UPDATE `_qd_clone_equipment` SET `CreatureID`=900402;
INSERT INTO `creature_equip_template` SELECT * FROM `_qd_clone_equipment`;
DELETE FROM `_qd_clone_equipment`;
INSERT INTO `_qd_clone_equipment` SELECT * FROM `creature_equip_template` WHERE `CreatureID`=25115;
UPDATE `_qd_clone_equipment` SET `CreatureID`=900403;
INSERT INTO `creature_equip_template` SELECT * FROM `_qd_clone_equipment`;
DROP TEMPORARY TABLE `_qd_clone_equipment`;

UPDATE `creature_template` SET `exp`=2 WHERE `entry`=25548 AND `difficulty_entry_1`=0;

COMMIT;
