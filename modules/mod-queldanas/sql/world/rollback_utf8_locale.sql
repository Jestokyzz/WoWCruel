-- Roll back the custom ruRU rows to server-side English fallback without restoring corrupted bytes.
START TRANSACTION;
DELETE FROM `item_template_locale` WHERE `ID`=900300 AND `locale`='ruRU';
DELETE FROM `gameobject_template_locale` WHERE `entry` IN (900501,900502) AND `locale`='ruRU';
UPDATE `version` SET `cache_id`=`cache_id`+1;
COMMIT;
