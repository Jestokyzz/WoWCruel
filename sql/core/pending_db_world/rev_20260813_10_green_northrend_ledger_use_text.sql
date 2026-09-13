UPDATE `item_template`
SET `description` = '|cff00ff00Use: Mark every Northrend quest as completed without granting its normal rewards.|r'
WHERE `entry` = 900114;

UPDATE `item_template_locale`
SET `Description` = '|cff00ff00Использование: отмечает все задания Нордскола выполненными без выдачи обычных наград.|r'
WHERE `ID` = 900114 AND `locale` = 'ruRU';

UPDATE `version` SET `cache_id` = 25 WHERE `cache_id` < 25;
