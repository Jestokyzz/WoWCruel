UPDATE `item_template` SET `description` = CASE `entry`
    WHEN 49224 THEN '|cff00ff00Use: Removes Deserter and Dungeon Deserter penalties.|r'
    WHEN 900110 THEN '|cff00ff00Use: Learn every flight path available to your faction in Northrend.|r'
    WHEN 900111 THEN '|cff00ff00Use: Learn every flight path available to your faction in Outland.|r'
    WHEN 900112 THEN '|cff00ff00Use: Learn every flight path available to your faction in the Eastern Kingdoms.|r'
    WHEN 900113 THEN '|cff00ff00Use: Learn every flight path available to your faction in Kalimdor.|r'
    WHEN 900114 THEN '|cff00ff00Use: Mark every Northrend quest as completed without granting its normal rewards.|r'
END WHERE `entry` IN (49224, 900110, 900111, 900112, 900113, 900114);

UPDATE `item_template_locale` SET `Description` = CASE `ID`
    WHEN 49224 THEN '|cff00ff00Использование: снимает дезертира и штраф за покинутое подземелье.|r'
    WHEN 900110 THEN '|cff00ff00Использование: открывает все доступные вашей фракции маршруты полетов в Нордсколе.|r'
    WHEN 900111 THEN '|cff00ff00Использование: открывает все доступные вашей фракции маршруты полетов в Запределье.|r'
    WHEN 900112 THEN '|cff00ff00Использование: открывает все доступные вашей фракции маршруты полетов в Восточных королевствах.|r'
    WHEN 900113 THEN '|cff00ff00Использование: открывает все доступные вашей фракции маршруты полетов в Калимдоре.|r'
    WHEN 900114 THEN '|cff00ff00Использование: отмечает все задания Нордскола выполненными без выдачи обычных наград.|r'
END WHERE `locale` = 'ruRU' AND `ID` IN (49224, 900110, 900111, 900112, 900113, 900114);

UPDATE `version` SET `cache_id` = 27 WHERE `cache_id` < 27;
