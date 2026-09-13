UPDATE `item_template` SET
    `Flags` = `Flags` | 64,
    `spellid_1` = 69377,
    `spelltrigger_1` = 0,
    `spellcharges_1` = -1,
    `spellcooldown_1` = 0,
    `PageText` = 0,
    `LanguageID` = 0,
    `PageMaterial` = 0
WHERE `entry` IN (49224, 900100, 900101);

UPDATE `item_template` SET
    `displayid` = 1322,
    `Flags` = `Flags` | 64,
    `spellid_1` = 69377,
    `spelltrigger_1` = 0,
    `spellcharges_1` = -1,
    `spellcooldown_1` = 0,
    `PageText` = 0,
    `LanguageID` = 0,
    `PageMaterial` = 0
WHERE `entry` BETWEEN 900110 AND 900113;

UPDATE `version` SET `cache_id` = 21 WHERE `cache_id` < 21;
