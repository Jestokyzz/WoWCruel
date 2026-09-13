CREATE TABLE IF NOT EXISTS `account_transmog_appearance` (
  `account_id` INT UNSIGNED NOT NULL,
  `appearance_id` INT UNSIGNED NOT NULL,
  `source_item_id` INT UNSIGNED NOT NULL,
  `learned_by_guid` INT UNSIGNED NOT NULL,
  `learned_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`, `appearance_id`),
  KEY `idx_appearance_id` (`appearance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Account-wide permanent transmog appearances';

CREATE TABLE IF NOT EXISTS `item_instance_transmog` (
  `item_guid` INT UNSIGNED NOT NULL,
  `owner_guid` INT UNSIGNED NOT NULL,
  `fake_entry` INT UNSIGNED NOT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`item_guid`),
  KEY `idx_owner_guid` (`owner_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='WCollections transmogrification applied to item instances';
