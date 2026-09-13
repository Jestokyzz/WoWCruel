-- Native green Use text comes from Spell.dbc. The normal item description is
-- deliberately empty because the 3.3.5 client renders it yellow and quoted.
UPDATE `item_template` SET
    `bonding` = 1,
    `description` = '',
    `spellid_1` = CASE `entry`
        WHEN 49224 THEN 900120
        WHEN 900110 THEN 900121
        WHEN 900111 THEN 900122
        WHEN 900112 THEN 900123
        WHEN 900113 THEN 900124
        WHEN 900114 THEN 900125
    END,
    `spelltrigger_1` = 0,
    `spellcharges_1` = -1,
    `spellcooldown_1` = 0,
    `spellcategory_1` = 0,
    `spellcategorycooldown_1` = 0
WHERE `entry` IN (49224, 900110, 900111, 900112, 900113, 900114);

UPDATE `item_template` SET `displayid` = 61964 WHERE `entry` = 49224;
UPDATE `item_template` SET
    `class` = 12,
    `subclass` = 0,
    `SoundOverrideSubclass` = 0,
    `displayid` = `entry`
WHERE `entry` BETWEEN 900110 AND 900114;

UPDATE `item_template_locale` SET `Description` = ''
WHERE `ID` IN (49224, 900110, 900111, 900112, 900113, 900114);

DROP TEMPORARY TABLE IF EXISTS `tmp_custom_item_spell`;
CREATE TEMPORARY TABLE `tmp_custom_item_spell` LIKE `spell_dbc`;
INSERT INTO `tmp_custom_item_spell` SELECT * FROM `spell_dbc` WHERE `ID` = 482;

DELETE FROM `spell_dbc` WHERE `ID` BETWEEN 900120 AND 900125;
UPDATE `tmp_custom_item_spell` SET `ID` = 900120, `Name_Lang_enUS` = 'Custom item use', `Name_Lang_ruRU` = 'Использование предмета', `Description_Lang_enUS` = 'Removes Deserter and Dungeon Deserter penalties.', `Description_Lang_ruRU` = 'Снимает дезертира и штраф за покинутое подземелье.', `Reagent_1`=0, `Reagent_2`=0, `Reagent_3`=0, `Reagent_4`=0, `Reagent_5`=0, `Reagent_6`=0, `Reagent_7`=0, `Reagent_8`=0;
INSERT INTO `spell_dbc` SELECT * FROM `tmp_custom_item_spell`;
UPDATE `tmp_custom_item_spell` SET `ID` = 900121, `Description_Lang_enUS` = 'Learns every flight path available to your faction in Northrend.', `Description_Lang_ruRU` = 'Открывает все доступные вашей фракции маршруты полетов в Нордсколе.';
INSERT INTO `spell_dbc` SELECT * FROM `tmp_custom_item_spell`;
UPDATE `tmp_custom_item_spell` SET `ID` = 900122, `Description_Lang_enUS` = 'Learns every flight path available to your faction in Outland.', `Description_Lang_ruRU` = 'Открывает все доступные вашей фракции маршруты полетов в Запределье.';
INSERT INTO `spell_dbc` SELECT * FROM `tmp_custom_item_spell`;
UPDATE `tmp_custom_item_spell` SET `ID` = 900123, `Description_Lang_enUS` = 'Learns every flight path available to your faction in the Eastern Kingdoms.', `Description_Lang_ruRU` = 'Открывает все доступные вашей фракции маршруты полетов в Восточных королевствах.';
INSERT INTO `spell_dbc` SELECT * FROM `tmp_custom_item_spell`;
UPDATE `tmp_custom_item_spell` SET `ID` = 900124, `Description_Lang_enUS` = 'Learns every flight path available to your faction in Kalimdor.', `Description_Lang_ruRU` = 'Открывает все доступные вашей фракции маршруты полетов в Калимдоре.';
INSERT INTO `spell_dbc` SELECT * FROM `tmp_custom_item_spell`;
UPDATE `tmp_custom_item_spell` SET `ID` = 900125, `Description_Lang_enUS` = 'Marks every Northrend quest as completed without granting its normal rewards.', `Description_Lang_ruRU` = 'Отмечает все задания Нордскола выполненными без выдачи обычных наград.';
INSERT INTO `spell_dbc` SELECT * FROM `tmp_custom_item_spell`;
DROP TEMPORARY TABLE `tmp_custom_item_spell`;

UPDATE `version` SET `cache_id` = 28 WHERE `cache_id` < 28;
