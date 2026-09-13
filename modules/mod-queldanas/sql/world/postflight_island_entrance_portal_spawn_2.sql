-- Postflight jc-2026-08-28-queldanas-island-entrance-portal-spawn-2-v1
-- Expected: portal_ready=1.
SELECT COUNT(*) AS `portal_ready`
FROM `gameobject` g
JOIN `gameobject_template` t ON t.`entry`=g.`id`
JOIN `gameobject_template_locale` l
  ON l.`entry`=t.`entry` AND l.`locale`='ruRU'
JOIN `spell_scripts` ss ON ss.`id`=t.`Data0` AND ss.`command`=15
JOIN `spell_target_position` tp
  ON tp.`ID`=ss.`datalong` AND tp.`EffectIndex`=0
WHERE g.`guid`=900503 AND g.`id`=900502 AND g.`map`=530
  AND ABS(g.`position_x`-12604.6)<0.01
  AND ABS(g.`position_y`+6533.69)<0.01
  AND ABS(g.`position_z`-4.11736)<0.01
  AND ABS(g.`orientation`-5.4694)<0.0001
  AND ABS(g.`rotation2`-0.395757596)<0.000001
  AND ABS(g.`rotation3`+0.918355010)<0.000001
  AND g.`spawnMask`=1 AND g.`phaseMask`=1 AND g.`state`=1
  AND t.`type`=22 AND t.`displayId`=7628 AND t.`Data0`=44876
  AND t.`name`='Portal to the Isle Entrance'
  AND l.`name`='Портал в начало острова'
  AND ss.`datalong`=44870 AND tp.`MapID`=530
  AND ABS(tp.`PositionX`-12804)<0.001
  AND ABS(tp.`PositionY`+6908)<0.001
  AND ABS(tp.`PositionZ`-41.1)<0.001
  AND ABS(tp.`Orientation`-2.21)<0.001;
