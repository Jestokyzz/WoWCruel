-- Use a client-known, instant, reagent-free dummy spell solely to make the
-- items clickable. ItemScript intercepts the use and performs the real action.
UPDATE `item_template` SET
    `spellid_1` = 482,
    `spelltrigger_1` = 0,
    `spellcharges_1` = -1,
    `spellcooldown_1` = 0,
    `spellcategory_1` = 0,
    `spellcategorycooldown_1` = 0
WHERE `entry` IN (49224, 900110, 900111, 900112, 900113, 900114);

UPDATE `version` SET `cache_id` = 26 WHERE `cache_id` < 26;
