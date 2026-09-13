-- Preflight jc-2026-08-28-queldanas-eldara-order-prices-v1
-- Expected: vendor_rows=35, all_slots_zero=35, equipment_rows=15,
-- weapon_mark_rows=8, shield_neck_without_marks=6, source_prices_exact=14.
SELECT
    (SELECT COUNT(*) FROM `npc_vendor` WHERE `entry`=25032) AS `vendor_rows`,
    (SELECT COUNT(*) FROM `npc_vendor` WHERE `entry`=25032 AND `slot`=0) AS `all_slots_zero`,
    (SELECT COUNT(*) FROM `npc_vendor`
      WHERE `entry`=25032 AND `item` BETWEEN 900301 AND 900315) AS `equipment_rows`,
    (SELECT COUNT(*) FROM `npc_vendor`
      WHERE `entry`=25032 AND `item` BETWEEN 900301 AND 900308
        AND `ExtendedCost` BETWEEN 5000 AND 5007) AS `weapon_mark_rows`,
    (SELECT COUNT(*) FROM `npc_vendor`
      WHERE `entry`=25032 AND `item` BETWEEN 900309 AND 900314
        AND `ExtendedCost`=0) AS `shield_neck_without_marks`,
    (SELECT COUNT(*) FROM `item_template`
      WHERE (`entry`=900301 AND `BuyPrice`=459015)
         OR (`entry`=900302 AND `BuyPrice`=460643)
         OR (`entry`=900303 AND `BuyPrice`=418194)
         OR (`entry`=900304 AND `BuyPrice`=434690)
         OR (`entry`=900305 AND `BuyPrice`=436317)
         OR (`entry`=900306 AND `BuyPrice`=437945)
         OR (`entry`=900307 AND `BuyPrice`=549466)
         OR (`entry`=900308 AND `BuyPrice`=330867)
         OR (`entry`=900309 AND `BuyPrice`=377842)
         OR (`entry`=900310 AND `BuyPrice`=379231)
         OR (`entry` IN (900311,900312,900313,900314) AND `BuyPrice`=232752)) AS `source_prices_exact`;
