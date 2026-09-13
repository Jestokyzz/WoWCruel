-- Spell 43779 is Delicious Chocolate Cake and incorrectly makes the client
-- require Simple Flour before ItemScript can handle the custom item.
-- Spell 483 is the native, reagent-free learning visual used by the client.
UPDATE `item_template` SET
    `spellid_1` = 483,
    `spelltrigger_1` = 0,
    `spellcharges_1` = -1,
    `spellcooldown_1` = 0,
    `spellcategory_1` = 0,
    `spellcategorycooldown_1` = 0
WHERE `entry` IN (49224, 900110, 900111, 900112, 900113, 900114);

UPDATE `version` SET `cache_id` = 24 WHERE `cache_id` < 24;
