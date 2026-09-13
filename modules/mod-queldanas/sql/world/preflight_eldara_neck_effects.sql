-- Preflight jc-2026-08-28-queldanas-neck-effects-v1
SELECT DATABASE() AS `target_database`;
SELECT 'neck_templates_expected_4' AS `check_name`, COUNT(*) AS `actual`
FROM `item_template` WHERE `entry` BETWEEN 900311 AND 900314;
SELECT 'old_neck_state_expected_4' AS `check_name`, COUNT(*) AS `actual`
FROM `item_template`
WHERE (`entry`=900311 AND `stat_type1`=45 AND `stat_value1`=78 AND `spellid_1`=18043 AND `spellid_2`=21628 AND `spellid_3`=45484 AND `socketColor_1`=0)
   OR (`entry`=900312 AND `stat_type1`=45 AND `stat_value1`=78 AND `spellid_1`=18054 AND `spellid_2`=45481 AND `socketColor_1`=0)
   OR (`entry`=900313 AND `stat_type2`=38 AND `stat_value2`=97 AND `spellid_1`=15817 AND `spellid_2`=45482 AND `socketColor_1`=0)
   OR (`entry`=900314 AND `spellid_1`=45483 AND `spelltrigger_1`=1 AND `socketColor_1`=0);
SELECT 'stock_proc_donors_expected_3' AS `check_name`, COUNT(*) AS `actual`
FROM `spell_proc` WHERE `SpellId` IN (45481,45482,45484) AND `Cooldown`=45000;
SELECT 'custom_spell_bindings_expected_0' AS `check_name`,
       (SELECT COUNT(*) FROM `spell_proc` WHERE `SpellId` BETWEEN 80921 AND 80923) +
       (SELECT COUNT(*) FROM `spell_script_names` WHERE `spell_id` BETWEEN 80921 AND 80924) AS `actual`;
