-- Test character requested by the realm owner. Reward flags only: no normal
-- quest rewards are paid and nothing is inserted into the active quest log.
INSERT IGNORE INTO `character_queststatus_rewarded` (`guid`, `quest`, `active`)
SELECT 2501, q.`ID`, 1
FROM `acore_world`.`quest_template` q
WHERE q.`QuestSortID` IN (65,66,67,210,394,495,3537,3711,4197,4395,2817);
