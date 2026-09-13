SET @q = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_world_quest' AND COLUMN_NAME = 'rewardType2') = 0,
    'ALTER TABLE character_world_quest ADD rewardType2 TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER completedAt', 'SELECT 1');
PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @q = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_world_quest' AND COLUMN_NAME = 'rewardId2') = 0,
    'ALTER TABLE character_world_quest ADD rewardId2 INT UNSIGNED NOT NULL DEFAULT 0 AFTER rewardType2', 'SELECT 1');
PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @q = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_world_quest' AND COLUMN_NAME = 'rewardAmount2') = 0,
    'ALTER TABLE character_world_quest ADD rewardAmount2 INT UNSIGNED NOT NULL DEFAULT 0 AFTER rewardId2', 'SELECT 1');
PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;
