SET @q = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_world_quest' AND COLUMN_NAME = 'progress0') = 0,
    'ALTER TABLE character_world_quest ADD progress0 INT UNSIGNED NOT NULL DEFAULT 0, ADD progress1 INT UNSIGNED NOT NULL DEFAULT 0, ADD progress2 INT UNSIGNED NOT NULL DEFAULT 0, ADD progress3 INT UNSIGNED NOT NULL DEFAULT 0', 'SELECT 1');
PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- Old active rows belonged to the unsafe quest-log implementation. Regenerate them cleanly.
UPDATE `character_world_quest` SET `state` = 3, `completedAt` = UNIX_TIMESTAMP()
WHERE `state` IN (0, 1, 4);
UPDATE `character_world_quest_schedule` SET `nextWaveAt` = UNIX_TIMESTAMP();
