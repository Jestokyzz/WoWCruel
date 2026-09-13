-- Rollback jc-2026-08-28-queldanas-neck-effects-v1
START TRANSACTION;
DELETE FROM `spell_script_names` WHERE `spell_id` BETWEEN 80921 AND 80924;
DELETE FROM `spell_proc` WHERE `SpellId` BETWEEN 80921 AND 80923;

UPDATE `item_template` SET `stat_value1`=78,`socketColor_1`=0,`socketContent_1`=0,`socketBonus`=0,
    `spellid_1`=18043,`spelltrigger_1`=1,`spellcooldown_1`=0,
    `spellid_2`=21628,`spelltrigger_2`=1,`spellcooldown_2`=-1,
    `spellid_3`=45484,`spelltrigger_3`=1,`spellcooldown_3`=-1 WHERE `entry`=900311;
UPDATE `item_template` SET `stat_value1`=78,`socketColor_1`=0,`socketContent_1`=0,`socketBonus`=0,
    `spellid_1`=18054,`spelltrigger_1`=1,`spellcooldown_1`=0,
    `spellid_2`=45481,`spelltrigger_2`=1,`spellcooldown_2`=-1 WHERE `entry`=900312;
UPDATE `item_template` SET `stat_value2`=97,`socketColor_1`=0,`socketContent_1`=0,`socketBonus`=0,
    `spellid_1`=15817,`spelltrigger_1`=1,`spellcooldown_1`=0,
    `spellid_2`=45482,`spelltrigger_2`=1,`spellcooldown_2`=-1 WHERE `entry`=900313;
UPDATE `item_template` SET `socketColor_1`=0,`socketContent_1`=0,`socketBonus`=0,
    `spellid_1`=45483,`spelltrigger_1`=1,`spellcooldown_1`=0,
    `spellid_2`=0,`spelltrigger_2`=1,`spellcooldown_2`=-1 WHERE `entry`=900314;
COMMIT;
