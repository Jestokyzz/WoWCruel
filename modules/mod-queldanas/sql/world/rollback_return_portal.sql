-- Rollback jc-2026-08-28-queldanas-return-portal-v1
-- Target DB: world. Removes only the custom template/spawn owned by this migration.
START TRANSACTION;

DELETE FROM `gameobject`
WHERE `guid`=900501 AND `id`=900501
  AND `Comment`='QuelDanas: Dalaran return portal at Jestokyzza logout snapshot';

DELETE FROM `gameobject_template_locale`
WHERE `entry`=900501 AND `locale`='ruRU'
  AND `name`='Портал из Даларана на остров Кель''Данас';

DELETE FROM `gameobject_template_addon`
WHERE `entry`=900501;

DELETE FROM `gameobject_template`
WHERE `entry`=900501
  AND `name`='Dalaran Portal to Isle of Quel''Danas'
  AND `type`=22 AND `displayId`=7628 AND `Data0`=44876;

COMMIT;
