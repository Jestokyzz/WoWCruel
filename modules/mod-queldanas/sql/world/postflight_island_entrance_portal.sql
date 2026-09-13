-- Postflight jc-2026-08-28-queldanas-island-entrance-portal-v1
-- Expected: portal_ready=1, template_property_differences=0, addon_differences=0.
SELECT
    (SELECT COUNT(*)
       FROM `gameobject` g
       JOIN `gameobject_template` t ON t.`entry`=g.`id`
       JOIN `gameobject_template_locale` l
         ON l.`entry`=t.`entry` AND l.`locale`='ruRU'
       JOIN `spell_scripts` ss ON ss.`id`=t.`Data0` AND ss.`command`=15
       JOIN `spell_target_position` tp
         ON tp.`ID`=ss.`datalong` AND tp.`EffectIndex`=0
      WHERE g.`guid`=900502 AND g.`id`=900502 AND g.`map`=530
        AND ABS(g.`position_x`-12181.7)<0.01
        AND ABS(g.`position_y`+7286.88)<0.01
        AND ABS(g.`position_z`-0.678391)<0.01
        AND ABS(g.`orientation`-4.8552)<0.0001
        AND ABS(g.`rotation2`-0.654856444)<0.000001
        AND ABS(g.`rotation3`+0.755753292)<0.000001
        AND g.`spawnMask`=1 AND g.`phaseMask`=1 AND g.`state`=1
        AND t.`type`=22 AND t.`displayId`=7628 AND t.`Data0`=44876
        AND l.`name`='Портал в начало острова'
        AND ss.`datalong`=44870 AND tp.`MapID`=530
        AND ABS(tp.`PositionX`-12804)<0.001
        AND ABS(tp.`PositionY`+6908)<0.001
        AND ABS(tp.`PositionZ`-41.1)<0.001
        AND ABS(tp.`Orientation`-2.21)<0.001) AS `portal_ready`,
    (SELECT COUNT(*)
       FROM `gameobject_template` s
       JOIN `gameobject_template` d ON d.`entry`=900502
      WHERE s.`entry`=187056 AND NOT (
        d.`type` <=> s.`type` AND d.`displayId` <=> s.`displayId` AND
        d.`IconName` <=> s.`IconName` AND d.`castBarCaption` <=> s.`castBarCaption` AND
        d.`unk1` <=> s.`unk1` AND d.`size` <=> s.`size` AND
        d.`Data0` <=> s.`Data0` AND d.`Data1` <=> s.`Data1` AND
        d.`Data2` <=> s.`Data2` AND d.`Data3` <=> s.`Data3` AND
        d.`Data4` <=> s.`Data4` AND d.`Data5` <=> s.`Data5` AND
        d.`Data6` <=> s.`Data6` AND d.`Data7` <=> s.`Data7` AND
        d.`Data8` <=> s.`Data8` AND d.`Data9` <=> s.`Data9` AND
        d.`Data10` <=> s.`Data10` AND d.`Data11` <=> s.`Data11` AND
        d.`Data12` <=> s.`Data12` AND d.`Data13` <=> s.`Data13` AND
        d.`Data14` <=> s.`Data14` AND d.`Data15` <=> s.`Data15` AND
        d.`Data16` <=> s.`Data16` AND d.`Data17` <=> s.`Data17` AND
        d.`Data18` <=> s.`Data18` AND d.`Data19` <=> s.`Data19` AND
        d.`Data20` <=> s.`Data20` AND d.`Data21` <=> s.`Data21` AND
        d.`Data22` <=> s.`Data22` AND d.`Data23` <=> s.`Data23` AND
        d.`AIName` <=> s.`AIName` AND d.`ScriptName` <=> s.`ScriptName` AND
        d.`VerifiedBuild` <=> s.`VerifiedBuild`)) AS `template_property_differences`,
    (SELECT COUNT(*)
       FROM `gameobject_template_addon` s
       JOIN `gameobject_template_addon` d ON d.`entry`=900502
      WHERE s.`entry`=187056 AND NOT (
        d.`faction` <=> s.`faction` AND d.`flags` <=> s.`flags` AND
        d.`mingold` <=> s.`mingold` AND d.`maxgold` <=> s.`maxgold` AND
        d.`artkit0` <=> s.`artkit0` AND d.`artkit1` <=> s.`artkit1` AND
        d.`artkit2` <=> s.`artkit2` AND d.`artkit3` <=> s.`artkit3`)) AS `addon_differences`;
