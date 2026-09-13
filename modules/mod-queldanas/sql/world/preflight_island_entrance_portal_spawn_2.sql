-- Preflight jc-2026-08-28-queldanas-island-entrance-portal-spawn-2-v1
-- Expected: template_exact=1, teleport_chain_exact=1, guid_collision=0, nearby_duplicate=0.
SELECT
    (SELECT COUNT(*)
       FROM `gameobject_template` t
       JOIN `gameobject_template_locale` l
         ON l.`entry`=t.`entry` AND l.`locale`='ruRU'
       JOIN `gameobject_template_addon` a ON a.`entry`=t.`entry`
      WHERE t.`entry`=900502 AND t.`type`=22 AND t.`displayId`=7628
        AND t.`Data0`=44876 AND t.`Data1`=0 AND t.`Data2`=0 AND t.`Data3`=1
        AND t.`name`='Portal to the Isle Entrance'
        AND l.`name`='Портал в начало острова') AS `template_exact`,
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
    (SELECT COUNT(*) FROM `gameobject` WHERE `guid`=900503) AS `guid_collision`,
    (SELECT COUNT(*) FROM `gameobject`
      WHERE `map`=530
        AND POW(`position_x`-12604.6,2)+POW(`position_y`+6533.69,2)+
            POW(`position_z`-4.11736,2)<4) AS `nearby_duplicate`;
