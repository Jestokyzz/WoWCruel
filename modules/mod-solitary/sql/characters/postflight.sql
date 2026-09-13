SELECT DATABASE() AS `target_database`;

SELECT COUNT(*) AS `solitary_table_exists_after`
FROM `information_schema`.`TABLES`
WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'character_solo_arena_rating';

SELECT COUNT(*) AS `invalid_arena_slots`
FROM `character_solo_arena_rating`
WHERE `arena_slot` > 2;

SELECT COUNT(*) AS `orphaned_characters`
FROM `character_solo_arena_rating` AS `solo`
LEFT JOIN `characters` AS `character_row` ON `character_row`.`guid` = `solo`.`guid`
WHERE `character_row`.`guid` IS NULL;

SELECT `virtual_team_id`, COUNT(*) AS `duplicate_count`
FROM `character_solo_arena_rating`
GROUP BY `virtual_team_id`
HAVING COUNT(*) > 1;
