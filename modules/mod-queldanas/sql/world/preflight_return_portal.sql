-- Preflight jc-2026-08-28-queldanas-return-portal-v1
-- Expected: source_exact=1, teleport_chain_exact=1, template_collision=0,
-- locale_collision=0, addon_collision=0, guid_collision=0, nearby_duplicate=0.
SELECT
    (SELECT COUNT(*)
       FROM `gameobject_template` t
       JOIN `gameobject_template_locale` l
         ON l.`entry`=t.`entry` AND l.`locale`='ruRU'
       JOIN `gameobject_template_addon` a ON a.`entry`=t.`entry`
      WHERE t.`entry`=187056 AND t.`type`=22 AND t.`displayId`=7628
        AND t.`Data0`=44876 AND t.`Data1`=0 AND t.`Data2`=0 AND t.`Data3`=1
        AND l.`name`='Портал из Шаттрата на остров Кель''Данас') AS `source_exact`,
    (SELECT COUNT(*)
       FROM `spell_scripts` ss
       JOIN `spell_target_position` tp
         ON tp.`ID`=ss.`datalong` AND tp.`EffectIndex`=0
      WHERE ss.`id`=44876 AND ss.`command`=15 AND ss.`datalong`=44870
        AND tp.`MapID`=530
        AND ABS(tp.`PositionX`-12804)<0.001
        AND ABS(tp.`PositionY`+6908)<0.001
        AND ABS(tp.`PositionZ`-41.1)<0.001
        AND ABS(tp.`Orientation`-2.21)<0.001) AS `teleport_chain_exact`,
    (SELECT COUNT(*) FROM `gameobject_template` WHERE `entry`=900501) AS `template_collision`,
    (SELECT COUNT(*) FROM `gameobject_template_locale` WHERE `entry`=900501) AS `locale_collision`,
    (SELECT COUNT(*) FROM `gameobject_template_addon` WHERE `entry`=900501) AS `addon_collision`,
    (SELECT COUNT(*) FROM `gameobject` WHERE `guid`=900501) AS `guid_collision`,
    (SELECT COUNT(*) FROM `gameobject`
      WHERE `map`=571
        AND POW(`position_x`-5913.81,2)+POW(`position_y`-619.233,2)+POW(`position_z`-646.425,2)<4) AS `nearby_duplicate`;
