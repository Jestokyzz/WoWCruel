-- Rollback jc-2026-08-28-queldanas-clone-dependencies-v1
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (900402,900403);
UPDATE `creature_template` SET `exp`=1 WHERE `entry`=25548;
