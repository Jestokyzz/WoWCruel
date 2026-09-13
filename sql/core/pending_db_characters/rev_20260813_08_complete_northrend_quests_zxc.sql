INSERT IGNORE INTO `character_queststatus_rewarded` (`guid`, `quest`, `active`)
SELECT 2507, `ID`, 1
FROM `acore_world`.`quest_template`
WHERE `QuestSortID` IN (65,66,67,210,394,495,2817,3537,3711,4197,4395);

INSERT INTO `character_world_quest_schedule` (`guid`, `nextWaveAt`) VALUES
(2507, UNIX_TIMESTAMP() - 21 * 60 * 60)
ON DUPLICATE KEY UPDATE `nextWaveAt` = VALUES(`nextWaveAt`);
