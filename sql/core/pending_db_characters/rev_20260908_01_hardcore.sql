-- Target: isolated hardcore_test_characters_v1. Candidate rules v1; no production application.
CREATE TABLE IF NOT EXISTS `character_hardcore_attempt` (
  `guid` INT UNSIGNED NOT NULL,
  `account` INT UNSIGNED NOT NULL,
  `rules_version` INT UNSIGNED NOT NULL,
  `profile` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `state` TINYINT UNSIGNED NOT NULL,
  `started_at` INT UNSIGNED NOT NULL,
  `start_level` INT UNSIGNED NOT NULL,
  `ended_at` INT UNSIGNED DEFAULT NULL,
  `released_at` INT UNSIGNED DEFAULT NULL,
  `death_level` INT UNSIGNED DEFAULT NULL,
  `death_map` INT UNSIGNED DEFAULT NULL,
  `death_zone` INT UNSIGNED DEFAULT NULL,
  `played_seconds` INT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`guid`),
  KEY `idx_account` (`account`),
  CONSTRAINT `hardcore_valid_state` CHECK (`state` BETWEEN 1 AND 4),
  CONSTRAINT `hardcore_death_complete` CHECK (`state` NOT IN (2,3) OR `ended_at` IS NOT NULL)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
