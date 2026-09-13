-- Rollback jc-2026-08-28-queldanas-dalaran-portal-v1
-- Target DB: world.
DELETE FROM `gameobject`
WHERE `guid`=900500 AND `id`=191164
  AND `Comment`='QuelDanas: Portal to Dalaran at Jestokyzza logout snapshot';
