-- jc-2026-08-28-queldanas-eldara-gold-flag-hotfix-v1
-- Target DB: world. Apply only after preflight_eldara_gold_and_marks_flag.sql passes.
-- ITEM_FLAG2_DONT_IGNORE_BUY_PRICE = 0x00000004.
START TRANSACTION;

UPDATE `item_template`
SET `FlagsExtra`=`FlagsExtra` | 4
WHERE `entry` BETWEEN 900301 AND 900314;

COMMIT;
