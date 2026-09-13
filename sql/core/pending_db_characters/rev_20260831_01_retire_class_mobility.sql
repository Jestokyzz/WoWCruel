-- Class Mobility removal v1.0.0. Target: acore_characters or matching isolated clone.
-- The retired range belongs exclusively to Class Mobility; keep IDs reserved.
-- Requires stopped worldserver and F: scoped dumps; other spells/cooldowns untouched.
START TRANSACTION;
DELETE FROM `character_spell` WHERE `spell` BETWEEN 80901 AND 80918;
DELETE FROM `character_aura` WHERE `spell` BETWEEN 80901 AND 80918;
DELETE FROM `character_action` WHERE `type` = 0 AND `action` BETWEEN 80901 AND 80918;
DELETE FROM `character_spell_cooldown` WHERE `spell` BETWEEN 80901 AND 80918;
COMMIT;
SELECT COUNT(*) AS `retired_spells` FROM `character_spell` WHERE `spell` BETWEEN 80901 AND 80918;
SELECT COUNT(*) AS `retired_auras` FROM `character_aura` WHERE `spell` BETWEEN 80901 AND 80918;
SELECT COUNT(*) AS `retired_actions` FROM `character_action` WHERE `type` = 0 AND `action` BETWEEN 80901 AND 80918;
SELECT COUNT(*) AS `retired_cooldowns` FROM `character_spell_cooldown` WHERE `spell` BETWEEN 80901 AND 80918;
