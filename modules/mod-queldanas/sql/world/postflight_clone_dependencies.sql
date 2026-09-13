-- Postflight jc-2026-08-28-queldanas-clone-dependencies-v1
SELECT 'custom_equipment_rows_expected_2' AS `check_name`, COUNT(*) AS `actual`
FROM `creature_equip_template` custom
JOIN `creature_equip_template` source
  ON source.`CreatureID`=CASE custom.`CreatureID` WHEN 900402 THEN 24938 WHEN 900403 THEN 25115 END
 AND source.`ID`=custom.`ID`
 AND source.`ItemID1`=custom.`ItemID1`
 AND source.`ItemID2`=custom.`ItemID2`
 AND source.`ItemID3`=custom.`ItemID3`
WHERE custom.`CreatureID` IN (900402,900403) AND custom.`ID`=1;
SELECT 'spawn_equipment_references_missing_expected_0' AS `check_name`, COUNT(*) AS `actual`
FROM `creature` spawn
LEFT JOIN `creature_equip_template` equipment
  ON equipment.`CreatureID`=spawn.`id` AND equipment.`ID`=spawn.`equipment_id`
WHERE spawn.`id` IN (900402,900403) AND spawn.`equipment_id`<>0 AND equipment.`CreatureID` IS NULL;
SELECT 'difficulty_expansion_mismatches_expected_0' AS `check_name`, COUNT(*) AS `actual`
FROM `creature_template` base
JOIN `creature_template` difficulty ON difficulty.`entry`=base.`difficulty_entry_1`
WHERE base.`entry`=24978 AND base.`exp`<>difficulty.`exp`;
