-- Rollback jc-2026-08-28-queldanas-island-entrance-portal-v1
-- Target DB: world. Removes only the custom template/spawn owned by this migration.
START TRANSACTION;

DELETE FROM `gameobject`
WHERE `guid`=900502 AND `id`=900502
  AND `Comment`='QuelDanas: Portal to isle entrance at Jestokyzza saved position';

DELETE FROM `gameobject_template_locale`
WHERE `entry`=900502 AND `locale`='ruRU'
  AND `name`='Портал в начало острова';

DELETE FROM `gameobject_template_addon`
WHERE `entry`=900502;

DELETE FROM `gameobject_template`
WHERE `entry`=900502
  AND `name`='Portal to the Isle Entrance'
  AND `type`=22 AND `displayId`=7628 AND `Data0`=44876;

COMMIT;
