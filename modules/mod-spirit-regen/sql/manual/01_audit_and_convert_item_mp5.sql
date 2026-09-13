-- Manual installation step. Do not run while worldserver is online.
-- Converts item_template stat type 43 (MP5) to type 6 (Spirit) at a 1:2 budget ratio.

CREATE TABLE IF NOT EXISTS `mod_spirit_regen_item_backup` (
    `item_id` INT UNSIGNED NOT NULL,
    `stat_slot` TINYINT UNSIGNED NOT NULL,
    `old_type` TINYINT UNSIGNED NOT NULL,
    `old_value` INT NOT NULL,
    `new_type` TINYINT UNSIGNED NOT NULL,
    `new_value` INT NOT NULL,
    PRIMARY KEY (`item_id`, `stat_slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO `mod_spirit_regen_item_backup`
    (`item_id`, `stat_slot`, `old_type`, `old_value`, `new_type`, `new_value`)
SELECT `entry`, 1, `stat_type1`, `stat_value1`, 6, `stat_value1` * 2 FROM `item_template` WHERE `stat_type1` = 43
UNION ALL SELECT `entry`, 2, `stat_type2`, `stat_value2`, 6, `stat_value2` * 2 FROM `item_template` WHERE `stat_type2` = 43
UNION ALL SELECT `entry`, 3, `stat_type3`, `stat_value3`, 6, `stat_value3` * 2 FROM `item_template` WHERE `stat_type3` = 43
UNION ALL SELECT `entry`, 4, `stat_type4`, `stat_value4`, 6, `stat_value4` * 2 FROM `item_template` WHERE `stat_type4` = 43
UNION ALL SELECT `entry`, 5, `stat_type5`, `stat_value5`, 6, `stat_value5` * 2 FROM `item_template` WHERE `stat_type5` = 43
UNION ALL SELECT `entry`, 6, `stat_type6`, `stat_value6`, 6, `stat_value6` * 2 FROM `item_template` WHERE `stat_type6` = 43
UNION ALL SELECT `entry`, 7, `stat_type7`, `stat_value7`, 6, `stat_value7` * 2 FROM `item_template` WHERE `stat_type7` = 43
UNION ALL SELECT `entry`, 8, `stat_type8`, `stat_value8`, 6, `stat_value8` * 2 FROM `item_template` WHERE `stat_type8` = 43
UNION ALL SELECT `entry`, 9, `stat_type9`, `stat_value9`, 6, `stat_value9` * 2 FROM `item_template` WHERE `stat_type9` = 43
UNION ALL SELECT `entry`, 10, `stat_type10`, `stat_value10`, 6, `stat_value10` * 2 FROM `item_template` WHERE `stat_type10` = 43;

UPDATE `item_template` SET `stat_type1` = 6, `stat_value1` = `stat_value1` * 2 WHERE `stat_type1` = 43;
UPDATE `item_template` SET `stat_type2` = 6, `stat_value2` = `stat_value2` * 2 WHERE `stat_type2` = 43;
UPDATE `item_template` SET `stat_type3` = 6, `stat_value3` = `stat_value3` * 2 WHERE `stat_type3` = 43;
UPDATE `item_template` SET `stat_type4` = 6, `stat_value4` = `stat_value4` * 2 WHERE `stat_type4` = 43;
UPDATE `item_template` SET `stat_type5` = 6, `stat_value5` = `stat_value5` * 2 WHERE `stat_type5` = 43;
UPDATE `item_template` SET `stat_type6` = 6, `stat_value6` = `stat_value6` * 2 WHERE `stat_type6` = 43;
UPDATE `item_template` SET `stat_type7` = 6, `stat_value7` = `stat_value7` * 2 WHERE `stat_type7` = 43;
UPDATE `item_template` SET `stat_type8` = 6, `stat_value8` = `stat_value8` * 2 WHERE `stat_type8` = 43;
UPDATE `item_template` SET `stat_type9` = 6, `stat_value9` = `stat_value9` * 2 WHERE `stat_type9` = 43;
UPDATE `item_template` SET `stat_type10` = 6, `stat_value10` = `stat_value10` * 2 WHERE `stat_type10` = 43;

SELECT COUNT(*) AS `converted_item_stats` FROM `mod_spirit_regen_item_backup`;
