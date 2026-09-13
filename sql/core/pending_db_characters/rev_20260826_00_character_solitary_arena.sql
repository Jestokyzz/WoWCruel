CREATE TABLE IF NOT EXISTS `character_solo_arena_rating` (
  `guid` INT UNSIGNED NOT NULL,
  `arena_slot` TINYINT UNSIGNED NOT NULL,
  `rating` INT UNSIGNED NOT NULL DEFAULT 1500,
  `matchmaker_rating` INT UNSIGNED NOT NULL DEFAULT 1500,
  `virtual_team_id` INT UNSIGNED NOT NULL,
  `week_games` INT UNSIGNED NOT NULL DEFAULT 0,
  `week_wins` INT UNSIGNED NOT NULL DEFAULT 0,
  `season_games` INT UNSIGNED NOT NULL DEFAULT 0,
  `season_wins` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`, `arena_slot`),
  UNIQUE KEY `uq_character_solo_arena_virtual_team` (`virtual_team_id`),
  CONSTRAINT `fk_character_solo_arena_character`
    FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
