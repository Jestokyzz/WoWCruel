DELETE FROM `item_template_locale` WHERE `ID` = 900114;
DELETE FROM `item_template` WHERE `entry` = 900114;

DROP TEMPORARY TABLE IF EXISTS `tmp_complete_northrend_item`;
CREATE TEMPORARY TABLE `tmp_complete_northrend_item` LIKE `item_template`;
INSERT INTO `tmp_complete_northrend_item`
SELECT * FROM `item_template` WHERE `entry` = 49224;

UPDATE `tmp_complete_northrend_item` SET
    `entry` = 900114,
    `name` = 'Ledger of Northrend Deeds',
    `displayid` = 58589,
    `Quality` = 4,
    `stackable` = 20,
    `description` = 'Use: Mark every Northrend quest as completed without granting its normal rewards.',
    `ScriptName` = 'item_complete_northrend_quests';
INSERT INTO `item_template` SELECT * FROM `tmp_complete_northrend_item`;
DROP TEMPORARY TABLE `tmp_complete_northrend_item`;

INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(900114, 'ruRU', 'Летопись подвигов Нордскола',
 'Использование: отмечает все задания Нордскола выполненными без выдачи обычных наград.', NULL);

UPDATE `version` SET `cache_id` = 23 WHERE `cache_id` < 23;
