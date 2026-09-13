CREATE TABLE IF NOT EXISTS `character_solitary_activity_bot` (
  `guid` INT UNSIGNED NOT NULL,
  `account_id` INT UNSIGNED NOT NULL,
  `owner_guid` INT UNSIGNED NOT NULL,
  `queue_type` TINYINT UNSIGNED NOT NULL,
  `rated` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `target_level` TINYINT UNSIGNED NOT NULL,
  `target_item_level` SMALLINT UNSIGNED NOT NULL,
  `created_at` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`guid`),
  KEY `idx_solitary_activity_account` (`account_id`),
  KEY `idx_solitary_activity_owner` (`owner_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
