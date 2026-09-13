-- Deterministic equipment/talent/glyph templates for disposable Solitary bots.
-- Static source data lives in the world DB; runtime ownership remains in characters.
CREATE TABLE `solitary_bot_gear_tier` (
  `tier_id` SMALLINT UNSIGNED NOT NULL,
  `activity` TINYINT UNSIGNED NOT NULL COMMENT '1=PvP,2=PvE',
  `tier_key` VARCHAR(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `display_name` VARCHAR(64) NOT NULL,
  `sort_order` TINYINT UNSIGNED NOT NULL,
  `reference_item_level` SMALLINT UNSIGNED NOT NULL,
  `maximum_item_level` SMALLINT UNSIGNED NOT NULL,
  `source_url` VARCHAR(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  PRIMARY KEY (`tier_id`),
  UNIQUE KEY `uq_solitary_bot_gear_tier_key` (`tier_key`),
  KEY `idx_solitary_bot_gear_activity_order` (`activity`, `sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `solitary_bot_gear_template` (
  `template_id` INT UNSIGNED NOT NULL,
  `template_key` VARCHAR(80) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `tier_id` SMALLINT UNSIGNED NOT NULL,
  `class_id` TINYINT UNSIGNED NOT NULL,
  `spec_index` TINYINT UNSIGNED NOT NULL,
  `role_mask` TINYINT UNSIGNED NOT NULL,
  `average_item_level` DECIMAL(6,2) UNSIGNED NOT NULL,
  `required_equipment_slots` TINYINT UNSIGNED NOT NULL DEFAULT 14,
  `source_url` VARCHAR(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `source_sha256` CHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `template_version` SMALLINT UNSIGNED NOT NULL,
  `verified` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `uq_solitary_bot_gear_template_key` (`template_key`),
  KEY `idx_solitary_bot_gear_selector` (`tier_id`, `class_id`, `spec_index`, `verified`),
  CONSTRAINT `fk_solitary_bot_template_tier`
    FOREIGN KEY (`tier_id`) REFERENCES `solitary_bot_gear_tier` (`tier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `solitary_bot_gear_template_item` (
  `template_id` INT UNSIGNED NOT NULL,
  `equipment_slot` TINYINT UNSIGNED NOT NULL,
  `item_entry` INT UNSIGNED NOT NULL,
  `permanent_enchant_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `socket_enchant_1` INT UNSIGNED NOT NULL DEFAULT 0,
  `socket_enchant_2` INT UNSIGNED NOT NULL DEFAULT 0,
  `socket_enchant_3` INT UNSIGNED NOT NULL DEFAULT 0,
  `random_property_id` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`template_id`, `equipment_slot`),
  KEY `idx_solitary_bot_template_item_entry` (`item_entry`),
  CONSTRAINT `fk_solitary_bot_template_item_template`
    FOREIGN KEY (`template_id`) REFERENCES `solitary_bot_gear_template` (`template_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `solitary_bot_gear_template_talent` (
  `template_id` INT UNSIGNED NOT NULL,
  `talent_id` INT UNSIGNED NOT NULL,
  `rank_index` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`template_id`, `talent_id`),
  CONSTRAINT `fk_solitary_bot_template_talent_template`
    FOREIGN KEY (`template_id`) REFERENCES `solitary_bot_gear_template` (`template_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `solitary_bot_gear_template_glyph` (
  `template_id` INT UNSIGNED NOT NULL,
  `glyph_slot` TINYINT UNSIGNED NOT NULL,
  `glyph_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`template_id`, `glyph_slot`),
  CONSTRAINT `fk_solitary_bot_template_glyph_template`
    FOREIGN KEY (`template_id`) REFERENCES `solitary_bot_gear_template` (`template_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `solitary_bot_gear_tier`
  (`tier_id`, `activity`, `tier_key`, `display_name`, `sort_order`, `reference_item_level`,
   `maximum_item_level`, `source_url`) VALUES
  (101, 1, 'pvp-a5', 'PvP A5: Deadly Gladiator', 1, 213, 213, 'https://www.wowhead.com/wotlk/item-sets/name:Gladiator'),
  (102, 1, 'pvp-a6', 'PvP A6: Furious Gladiator', 2, 232, 239, 'https://www.wowhead.com/wotlk/item-sets/name:Gladiator'),
  (103, 1, 'pvp-a7', 'PvP A7: Relentless Gladiator', 3, 251, 258, 'https://www.wowhead.com/wotlk/item-sets/name:Gladiator'),
  (104, 1, 'pvp-a8', 'PvP A8: Wrathful Gladiator', 4, 270, 277, 'https://www.wowhead.com/wotlk/item-sets/name:Gladiator'),
  (201, 2, 'pve-preraid', 'PvE: Pre-Raid', 1, 200, 200, 'https://www.warcrafttavern.com/wotlk/guides/'),
  (202, 2, 'pve-naxx', 'PvE: Naxxramas', 2, 213, 226, 'https://www.warcrafttavern.com/wotlk/guides/'),
  (203, 2, 'pve-ulduar', 'PvE: Ulduar', 3, 226, 252, 'https://www.warcrafttavern.com/wotlk/guides/'),
  (204, 2, 'pve-toc', 'PvE: Trial of the Crusader', 4, 258, 272, 'https://www.warcrafttavern.com/wotlk/guides/'),
  (205, 2, 'pve-icc-normal', 'PvE: Icecrown Citadel', 5, 264, 271, 'https://www.warcrafttavern.com/wotlk/guides/'),
  (206, 2, 'pve-icc-heroic', 'PvE: Icecrown Citadel Heroic', 6, 277, 284, 'https://www.warcrafttavern.com/wotlk/guides/'),
  (207, 2, 'pve-rs-heroic', 'PvE: Ruby Sanctum Heroic', 7, 284, 284, 'https://www.wowhead.com/wotlk/guide/raids/ruby-sanctum/overview');
