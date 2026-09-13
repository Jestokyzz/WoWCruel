-- Solitary bot gear v2: never give an off-hand weapon to a class without dual wield.
-- Target database: world. The full generated rev_20260827_01 dataset already contains
-- these corrected bindings; this migration upgrades databases that applied its older form.

-- Preflight (expected before upgrade: 8 rows):
SELECT `template_id`, `equipment_slot`, `item_entry`
FROM `solitary_bot_gear_template_item`
WHERE (`template_id` = 102015 AND `equipment_slot` = 16 AND `item_entry` = 45957)
   OR (`template_id` = 103015 AND `equipment_slot` = 16 AND `item_entry` = 48426)
   OR (`template_id` = 104015 AND `equipment_slot` = 16 AND `item_entry` = 51440)
   OR (`template_id` = 201016 AND `equipment_slot` = 16 AND `item_entry` = 39344)
   OR (`template_id` = 204016 AND `equipment_slot` = 16 AND `item_entry` = 47506)
   OR (`template_id` = 205016 AND `equipment_slot` = 16 AND `item_entry` = 49997)
   OR (`template_id` = 206016 AND `equipment_slot` = 16 AND `item_entry` = 50737)
   OR (`template_id` = 207016 AND `equipment_slot` = 16 AND `item_entry` = 50737);

START TRANSACTION;

UPDATE `solitary_bot_gear_template_item`
SET `item_entry` = CASE `template_id`
    WHEN 102015 THEN 42526 -- Furious Gladiator's Endgame
    WHEN 103015 THEN 49187 -- Relentless Gladiator's Compendium
    WHEN 104015 THEN 51407 -- Wrathful Gladiator's Compendium
    WHEN 201016 THEN 42508 -- Titansteel Shield Wall
    WHEN 204016 THEN 46964 -- Crystal Plated Vanguard
    WHEN 205016 THEN 51909 -- Neverending Winter
    WHEN 206016 THEN 50729 -- Icecrown Glacial Wall
    WHEN 207016 THEN 50729 -- Icecrown Glacial Wall
END
WHERE `equipment_slot` = 16
  AND `template_id` IN (102015,103015,104015,201016,204016,205016,206016,207016);

UPDATE `solitary_bot_gear_template`
SET `template_version` = 2, `verified` = 1
WHERE `template_id` IN (102015,103015,104015,201016,204016,205016,206016,207016);

COMMIT;

-- Postflight (expected: exactly the eight template/item pairs above with their new entries):
SELECT `template_id`, `equipment_slot`, `item_entry`
FROM `solitary_bot_gear_template_item`
WHERE `template_id` IN (102015,103015,104015,201016,204016,205016,206016,207016)
  AND `equipment_slot` = 16
ORDER BY `template_id`;

-- Rollback (execute manually only after restoring the pre-change row backup):
-- UPDATE `solitary_bot_gear_template_item` SET `item_entry` = CASE `template_id`
--   WHEN 102015 THEN 45957 WHEN 103015 THEN 48426 WHEN 104015 THEN 51440
--   WHEN 201016 THEN 39344 WHEN 204016 THEN 47506 WHEN 205016 THEN 49997
--   WHEN 206016 THEN 50737 WHEN 207016 THEN 50737 END
-- WHERE `equipment_slot` = 16
--   AND `template_id` IN (102015,103015,104015,201016,204016,205016,206016,207016);
-- UPDATE `solitary_bot_gear_template` SET `template_version` = 1
-- WHERE `template_id` IN (102015,103015,104015,201016,204016,205016,206016,207016);
