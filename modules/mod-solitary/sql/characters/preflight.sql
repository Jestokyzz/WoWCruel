SELECT DATABASE() AS `target_database`;

SELECT COUNT(*) AS `characters_table_exists`
FROM `information_schema`.`TABLES`
WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'characters';

SELECT COUNT(*) AS `solitary_table_exists_before`
FROM `information_schema`.`TABLES`
WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'character_solo_arena_rating';
