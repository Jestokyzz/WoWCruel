-- Postflight jc-2026-08-28-queldanas-neck-effects-v1
SELECT 'merged_stats_expected_3' AS `check_name`, COUNT(*) AS `actual`
FROM `item_template`
WHERE (`entry` IN (900311,900312) AND `stat_type1`=45 AND `stat_value1`=115)
   OR (`entry`=900313 AND `stat_type2`=38 AND `stat_value2`=161);
SELECT 'real_sockets_expected_4' AS `check_name`, COUNT(*) AS `actual`
FROM `item_template`
WHERE (`entry`=900311 AND `socketColor_1`=4 AND `socketBonus`=3752)
   OR (`entry`=900312 AND `socketColor_1`=4 AND `socketBonus`=3752)
   OR (`entry`=900313 AND `socketColor_1`=2 AND `socketBonus`=2877)
   OR (`entry`=900314 AND `socketColor_1`=2 AND `socketBonus`=2882);
SELECT 'custom_item_spells_expected_4' AS `check_name`, COUNT(*) AS `actual`
FROM `item_template`
WHERE (`entry`=900311 AND `spellid_1`=80923 AND `spelltrigger_1`=1)
   OR (`entry`=900312 AND `spellid_1`=80922 AND `spelltrigger_1`=1)
   OR (`entry`=900313 AND `spellid_1`=80921 AND `spelltrigger_1`=1)
   OR (`entry`=900314 AND `spellid_1`=80924 AND `spelltrigger_1`=0 AND `spellcooldown_1`=120000);
SELECT 'removed_legacy_permanent_spells_expected_0' AS `check_name`, COUNT(*) AS `actual`
FROM `item_template` WHERE `entry` BETWEEN 900311 AND 900314
AND (15817 IN (`spellid_1`,`spellid_2`,`spellid_3`,`spellid_4`,`spellid_5`)
  OR 18043 IN (`spellid_1`,`spellid_2`,`spellid_3`,`spellid_4`,`spellid_5`)
  OR 18054 IN (`spellid_1`,`spellid_2`,`spellid_3`,`spellid_4`,`spellid_5`)
  OR 21628 IN (`spellid_1`,`spellid_2`,`spellid_3`,`spellid_4`,`spellid_5`)
  OR 45481 IN (`spellid_1`,`spellid_2`,`spellid_3`,`spellid_4`,`spellid_5`)
  OR 45482 IN (`spellid_1`,`spellid_2`,`spellid_3`,`spellid_4`,`spellid_5`)
  OR 45483 IN (`spellid_1`,`spellid_2`,`spellid_3`,`spellid_4`,`spellid_5`)
  OR 45484 IN (`spellid_1`,`spellid_2`,`spellid_3`,`spellid_4`,`spellid_5`));
SELECT 'proc_rows_expected_3' AS `check_name`, COUNT(*) AS `actual`
FROM `spell_proc` WHERE `SpellId` BETWEEN 80921 AND 80923 AND `Cooldown`=45000;
SELECT 'script_bindings_expected_4' AS `check_name`, COUNT(*) AS `actual`
FROM `spell_script_names` WHERE `spell_id` BETWEEN 80921 AND 80924;
