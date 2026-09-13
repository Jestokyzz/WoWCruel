-- Manual rollback. Restores only rows captured by 01_audit_and_convert_item_mp5.sql.
-- Do not run while worldserver is online.

UPDATE `item_template` AS `item`
JOIN `mod_spirit_regen_item_backup` AS `backup` ON `backup`.`item_id` = `item`.`entry` AND `backup`.`stat_slot` = 1
SET `item`.`stat_type1` = `backup`.`old_type`, `item`.`stat_value1` = `backup`.`old_value`;
UPDATE `item_template` AS `item`
JOIN `mod_spirit_regen_item_backup` AS `backup` ON `backup`.`item_id` = `item`.`entry` AND `backup`.`stat_slot` = 2
SET `item`.`stat_type2` = `backup`.`old_type`, `item`.`stat_value2` = `backup`.`old_value`;
UPDATE `item_template` AS `item`
JOIN `mod_spirit_regen_item_backup` AS `backup` ON `backup`.`item_id` = `item`.`entry` AND `backup`.`stat_slot` = 3
SET `item`.`stat_type3` = `backup`.`old_type`, `item`.`stat_value3` = `backup`.`old_value`;
UPDATE `item_template` AS `item`
JOIN `mod_spirit_regen_item_backup` AS `backup` ON `backup`.`item_id` = `item`.`entry` AND `backup`.`stat_slot` = 4
SET `item`.`stat_type4` = `backup`.`old_type`, `item`.`stat_value4` = `backup`.`old_value`;
UPDATE `item_template` AS `item`
JOIN `mod_spirit_regen_item_backup` AS `backup` ON `backup`.`item_id` = `item`.`entry` AND `backup`.`stat_slot` = 5
SET `item`.`stat_type5` = `backup`.`old_type`, `item`.`stat_value5` = `backup`.`old_value`;
UPDATE `item_template` AS `item`
JOIN `mod_spirit_regen_item_backup` AS `backup` ON `backup`.`item_id` = `item`.`entry` AND `backup`.`stat_slot` = 6
SET `item`.`stat_type6` = `backup`.`old_type`, `item`.`stat_value6` = `backup`.`old_value`;
UPDATE `item_template` AS `item`
JOIN `mod_spirit_regen_item_backup` AS `backup` ON `backup`.`item_id` = `item`.`entry` AND `backup`.`stat_slot` = 7
SET `item`.`stat_type7` = `backup`.`old_type`, `item`.`stat_value7` = `backup`.`old_value`;
UPDATE `item_template` AS `item`
JOIN `mod_spirit_regen_item_backup` AS `backup` ON `backup`.`item_id` = `item`.`entry` AND `backup`.`stat_slot` = 8
SET `item`.`stat_type8` = `backup`.`old_type`, `item`.`stat_value8` = `backup`.`old_value`;
UPDATE `item_template` AS `item`
JOIN `mod_spirit_regen_item_backup` AS `backup` ON `backup`.`item_id` = `item`.`entry` AND `backup`.`stat_slot` = 9
SET `item`.`stat_type9` = `backup`.`old_type`, `item`.`stat_value9` = `backup`.`old_value`;
UPDATE `item_template` AS `item`
JOIN `mod_spirit_regen_item_backup` AS `backup` ON `backup`.`item_id` = `item`.`entry` AND `backup`.`stat_slot` = 10
SET `item`.`stat_type10` = `backup`.`old_type`, `item`.`stat_value10` = `backup`.`old_value`;

SELECT COUNT(*) AS `restored_item_stats` FROM `mod_spirit_regen_item_backup`;
