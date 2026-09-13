-- Character database only. Existing attempts receive no pacts; enrollment is immutable.
SET @hardcore_sql = IF(EXISTS(SELECT 1 FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_hardcore_attempt' AND COLUMN_NAME = 'pact_mask'),
  'SELECT 1', 'ALTER TABLE `character_hardcore_attempt` ADD COLUMN `pact_mask` SMALLINT UNSIGNED NOT NULL DEFAULT 0');
PREPARE hardcore_statement FROM @hardcore_sql;
EXECUTE hardcore_statement;
DEALLOCATE PREPARE hardcore_statement;
SET @hardcore_sql = IF(EXISTS(SELECT 1 FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_hardcore_attempt' AND COLUMN_NAME = 'pact_version'),
  'SELECT 1', 'ALTER TABLE `character_hardcore_attempt` ADD COLUMN `pact_version` SMALLINT UNSIGNED NOT NULL DEFAULT 1');
PREPARE hardcore_statement FROM @hardcore_sql;
EXECUTE hardcore_statement;
DEALLOCATE PREPARE hardcore_statement;
