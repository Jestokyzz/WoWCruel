-- Frostbitten / Northern Exposure rares (Wowhead achievement 2257/2256).
SET @rare_ids = '32357,32358,32361,32377,32386,32398,32400,32409,32417,32422,32429,32438,32447,32471,32475,32481,32485,32487,32495,32500,32501,32517,32630';

UPDATE `creature`
SET `spawntimesecs` = 60
WHERE FIND_IN_SET(`id`, @rare_ids);

-- Remove the shared gear satchel and all direct weapons/armor. Preserve quest
-- items such as Northern Ivory and Vrykul Amulet.
DELETE clt
FROM `creature_loot_template` clt
JOIN `item_template` it ON it.`entry` = clt.`Item`
WHERE FIND_IN_SET(clt.`Entry`, @rare_ids)
  AND (it.`class` IN (2, 4) OR clt.`Item` = 44663);
