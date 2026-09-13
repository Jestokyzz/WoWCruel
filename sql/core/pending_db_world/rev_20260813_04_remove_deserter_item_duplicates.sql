DELETE FROM `item_template_locale` WHERE `ID` IN (900100, 900101);
DELETE FROM `item_template` WHERE `entry` IN (900100, 900101);

UPDATE `version` SET `cache_id` = 20 WHERE `cache_id` < 20;
