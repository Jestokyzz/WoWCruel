-- Rollback jc-2026-08-28-queldanas-eldara-gold-flag-hotfix-v1
-- Restores the exact pre-hotfix state without changing any other FlagsExtra bits.
START TRANSACTION;

UPDATE `item_template`
SET `FlagsExtra`=`FlagsExtra` & ~4
WHERE `entry` BETWEEN 900301 AND 900314;

COMMIT;
