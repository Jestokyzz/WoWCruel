-- Preflight jc-2026-08-28-queldanas-eldara-gold-flag-hotfix-v1
-- Expected: combined_cost_rows=14, missing_gold_flag=14, exact_gold_prices=14.
SELECT
    (SELECT COUNT(*)
       FROM `npc_vendor` nv
       JOIN `item_template` it ON it.`entry`=nv.`item`
      WHERE nv.`entry`=25032 AND nv.`item` BETWEEN 900301 AND 900314
        AND nv.`ExtendedCost` BETWEEN 5000 AND 5007
        AND it.`BuyPrice`>0) AS `combined_cost_rows`,
    (SELECT COUNT(*) FROM `item_template`
      WHERE `entry` BETWEEN 900301 AND 900314
        AND (`FlagsExtra` & 4)=0) AS `missing_gold_flag`,
    (SELECT COUNT(*) FROM `item_template`
      WHERE (`entry` IN (900301,900302,900303,900304,900305,900306,900309,900310) AND `BuyPrice`=2500000)
         OR (`entry` IN (900307,900308) AND `BuyPrice`=5000000)
         OR (`entry` IN (900311,900312,900313,900314) AND `BuyPrice`=10000000)) AS `exact_gold_prices`;
