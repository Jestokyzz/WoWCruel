UPDATE `item_template` SET
    `displayid` = 62832,
    `spellid_1` = 43779,
    `spelltrigger_1` = 0,
    `spellcharges_1` = -1,
    `spellcooldown_1` = 0
WHERE `entry` = 49224;

UPDATE `item_template` SET
    `displayid` = 58589,
    `spellid_1` = 43779,
    `spelltrigger_1` = 0,
    `spellcharges_1` = -1,
    `spellcooldown_1` = 0
WHERE `entry` BETWEEN 900110 AND 900113;

UPDATE `version` SET `cache_id` = 22 WHERE `cache_id` < 22;
