-- Postflight jc-2026-08-28-queldanas-eldara-order-prices-v1
-- Expected: vendor_rows=35, distinct_slots=35, equipment_first=14,
-- recipes_next=18, miscellaneous_last=3, gold_prices_exact=14, mark_cost_rows=14.
SELECT
    (SELECT COUNT(*) FROM `npc_vendor` WHERE `entry`=25032) AS `vendor_rows`,
    (SELECT COUNT(DISTINCT `slot`) FROM `npc_vendor`
      WHERE `entry`=25032 AND `slot` BETWEEN 1 AND 35) AS `distinct_slots`,
    (SELECT COUNT(*) FROM `npc_vendor`
      WHERE `entry`=25032 AND `item` BETWEEN 900301 AND 900314
        AND `slot` BETWEEN 1 AND 14) AS `equipment_first`,
    (SELECT COUNT(*) FROM `npc_vendor`
      WHERE `entry`=25032 AND `item` IN
       (34872,35500,35502,35505,35695,35696,35697,35698,35699,
        35708,35752,35753,35754,35755,35766,35767,35768,35769)
        AND `slot` BETWEEN 15 AND 32) AS `recipes_next`,
    (SELECT COUNT(*) FROM `npc_vendor`
      WHERE `entry`=25032 AND `item` IN (29193,34780,900315)
        AND `slot` BETWEEN 33 AND 35) AS `miscellaneous_last`,
    (SELECT COUNT(*) FROM `item_template`
      WHERE (`entry` IN (900301,900302,900303,900304,900305,900306,900309,900310) AND `BuyPrice`=2500000)
         OR (`entry` IN (900307,900308) AND `BuyPrice`=5000000)
         OR (`entry` IN (900311,900312,900313,900314) AND `BuyPrice`=10000000)) AS `gold_prices_exact`,
    (SELECT COUNT(*) FROM `npc_vendor`
      WHERE `entry`=25032 AND `item` BETWEEN 900301 AND 900314
        AND ((`item` BETWEEN 900301 AND 900308 AND `ExtendedCost`=`item`-895301)
          OR (`item` BETWEEN 900309 AND 900314 AND `ExtendedCost`=5000))) AS `mark_cost_rows`;
