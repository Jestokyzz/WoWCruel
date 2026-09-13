-- Preflight jc-2026-08-28-queldanas-clone-dependencies-v1
SELECT 'source_equipment_rows_expected_2' AS `check_name`, COUNT(*) AS `actual`
FROM `creature_equip_template` WHERE `CreatureID` IN (24938,25115) AND `ID`=1;
SELECT 'custom_equipment_rows_before_expected_0_or_2' AS `check_name`, COUNT(*) AS `actual`
FROM `creature_equip_template` WHERE `CreatureID` IN (900402,900403) AND `ID`=1;
SELECT 'difficulty_source_expected_1' AS `check_name`, COUNT(*) AS `actual`
FROM `creature_template` WHERE `entry`=24978 AND `difficulty_entry_1`=25548;
