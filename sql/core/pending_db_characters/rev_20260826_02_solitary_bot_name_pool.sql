-- Immutable source-name ledger and lifecycle metadata for disposable Solitary bots.
-- A consumed name remains here after its character/account is deleted and can never be reused.
CREATE TABLE `solitary_bot_name_pool` (
  `name_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(12) NOT NULL,
  `normalized_name` VARCHAR(12) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `source_report_code` VARCHAR(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `source_actor_id` INT UNSIGNED NOT NULL,
  `source_class` VARCHAR(24) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  `source_server` VARCHAR(64) NOT NULL DEFAULT '',
  `state` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0=available,1=reserved,2=consumed,3=rejected',
  `reservation_token` BIGINT UNSIGNED DEFAULT NULL,
  `reserved_at` INT UNSIGNED DEFAULT NULL,
  `consumed_at` INT UNSIGNED DEFAULT NULL,
  `imported_at` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`name_id`),
  UNIQUE KEY `uq_solitary_bot_name_normalized` (`normalized_name`),
  KEY `idx_solitary_bot_name_state` (`state`, `name_id`),
  KEY `idx_solitary_bot_name_source` (`source_report_code`, `source_actor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `solitary_bot_name_import` (
  `import_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `source_kind` VARCHAR(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `source_version` VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `source_sha256` CHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `accepted_names` INT UNSIGNED NOT NULL,
  `rejected_names` INT UNSIGNED NOT NULL,
  `imported_at` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`import_id`),
  UNIQUE KEY `uq_solitary_bot_name_import_sha` (`source_sha256`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `character_solitary_activity_bot`
  ADD COLUMN `name_pool_id` BIGINT UNSIGNED DEFAULT NULL AFTER `account_id`,
  ADD COLUMN `gear_template_id` INT UNSIGNED DEFAULT NULL AFTER `name_pool_id`,
  ADD COLUMN `team_id` TINYINT UNSIGNED NOT NULL DEFAULT 2 AFTER `gear_template_id`,
  ADD COLUMN `class_id` TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER `team_id`,
  ADD COLUMN `lifecycle_state` TINYINT UNSIGNED NOT NULL DEFAULT 0
    COMMENT '0=creating,1=ready,2=reserved,3=engaged,4=cleanup' AFTER `rated`,
  ADD COLUMN `reservation_token` BIGINT UNSIGNED DEFAULT NULL AFTER `lifecycle_state`,
  ADD COLUMN `ready_at` INT UNSIGNED DEFAULT NULL AFTER `created_at`,
  ADD COLUMN `consumed_at` INT UNSIGNED DEFAULT NULL AFTER `ready_at`,
  ADD UNIQUE KEY `uq_solitary_activity_name` (`name_pool_id`),
  ADD KEY `idx_solitary_activity_reserve`
    (`lifecycle_state`, `owner_guid`, `team_id`, `class_id`),
  ADD CONSTRAINT `fk_solitary_activity_name_pool`
    FOREIGN KEY (`name_pool_id`) REFERENCES `solitary_bot_name_pool` (`name_id`);
