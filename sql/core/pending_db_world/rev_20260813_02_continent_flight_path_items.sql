DELETE FROM `item_template` WHERE `entry` BETWEEN 900110 AND 900113;
DELETE FROM `item_template_locale` WHERE `ID` BETWEEN 900110 AND 900113;

DROP TEMPORARY TABLE IF EXISTS `tmp_continent_flight_path_item`;
CREATE TEMPORARY TABLE `tmp_continent_flight_path_item` LIKE `item_template`;
INSERT INTO `tmp_continent_flight_path_item`
SELECT * FROM `item_template` WHERE `entry` = 45863;

UPDATE `tmp_continent_flight_path_item` SET
    `entry` = 900110,
    `class` = 0,
    `subclass` = 0,
    `name` = 'Flight Master\'s Map: Northrend',
    `displayid` = 1322,
    `Quality` = 3,
    `Flags` = 64,
    `FlagsExtra` = 0,
    `BuyCount` = 1,
    `BuyPrice` = 0,
    `SellPrice` = 0,
    `AllowableClass` = -1,
    `AllowableRace` = -1,
    `RequiredLevel` = 1,
    `maxcount` = 0,
    `stackable` = 20,
    `bonding` = 0,
    `description` = 'Use: Learn every flight path available to your faction in Northrend.',
    `spellid_1` = 69377,
    `spelltrigger_1` = 0,
    `spellcharges_1` = -1,
    `spellcooldown_1` = 0,
    `PageText` = 0,
    `LanguageID` = 0,
    `PageMaterial` = 0,
    `startquest` = 0,
    `duration` = 0,
    `ScriptName` = 'item_unlock_continent_flight_paths',
    `VerifiedBuild` = NULL;
INSERT INTO `item_template` SELECT * FROM `tmp_continent_flight_path_item`;

UPDATE `tmp_continent_flight_path_item` SET
    `entry` = 900111,
    `name` = 'Flight Master\'s Map: Outland',
    `displayid` = 1322,
    `description` = 'Use: Learn every flight path available to your faction in Outland.';
INSERT INTO `item_template` SELECT * FROM `tmp_continent_flight_path_item`;

UPDATE `tmp_continent_flight_path_item` SET
    `entry` = 900112,
    `name` = 'Flight Master\'s Map: Eastern Kingdoms',
    `displayid` = 1322,
    `description` = 'Use: Learn every flight path available to your faction in the Eastern Kingdoms.';
INSERT INTO `item_template` SELECT * FROM `tmp_continent_flight_path_item`;

UPDATE `tmp_continent_flight_path_item` SET
    `entry` = 900113,
    `name` = 'Flight Master\'s Map: Kalimdor',
    `displayid` = 1322,
    `description` = 'Use: Learn every flight path available to your faction in Kalimdor.';
INSERT INTO `item_template` SELECT * FROM `tmp_continent_flight_path_item`;
DROP TEMPORARY TABLE `tmp_continent_flight_path_item`;

INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(900110, 'ruRU', 'Карта распорядителя полетов: Нордскол',
 'Использование: открывает все доступные вашей фракции маршруты полетов в Нордсколе.', NULL),
(900111, 'ruRU', 'Карта распорядителя полетов: Запределье',
 'Использование: открывает все доступные вашей фракции маршруты полетов в Запределье.', NULL),
(900112, 'ruRU', 'Карта распорядителя полетов: Восточные королевства',
 'Использование: открывает все доступные вашей фракции маршруты полетов в Восточных королевствах.', NULL),
(900113, 'ruRU', 'Карта распорядителя полетов: Калимдор',
 'Использование: открывает все доступные вашей фракции маршруты полетов в Калимдоре.', NULL);

UPDATE `version` SET `cache_id` = 21 WHERE `cache_id` < 21;
