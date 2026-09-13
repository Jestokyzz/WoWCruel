-- Rollback jc-2026-08-28-queldanas-island-entrance-portal-spawn-2-v1
-- Target DB: world. Removes only the second spawn; shared template 900502 remains.
DELETE FROM `gameobject`
WHERE `guid`=900503 AND `id`=900502
  AND `Comment`='QuelDanas: second portal to isle entrance at Jestokyzza live-saved position';
