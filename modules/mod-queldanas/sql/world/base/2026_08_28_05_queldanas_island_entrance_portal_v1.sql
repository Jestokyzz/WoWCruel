-- jc-2026-08-28-queldanas-island-entrance-portal-v1
-- Target DB: world. Apply only after preflight_island_entrance_portal.sql passes.
-- Captured saved position of online Jestokyzza:
-- map 530, x 12181.7, y -7286.88, z 0.678391, orientation 4.8552.
-- Custom template 900502 is a full property clone of stock template 187056.
START TRANSACTION;

INSERT INTO `gameobject_template`
(`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,
 `Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,
 `Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,
 `Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,
 `AIName`,`ScriptName`,`VerifiedBuild`)
SELECT
 900502,`type`,`displayId`,'Portal to the Isle Entrance',
 `IconName`,`castBarCaption`,`unk1`,`size`,
 `Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,
 `Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,
 `Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,
 `AIName`,`ScriptName`,`VerifiedBuild`
FROM `gameobject_template`
WHERE `entry`=187056;

INSERT INTO `gameobject_template_locale`
(`entry`,`locale`,`name`,`castBarCaption`,`VerifiedBuild`)
SELECT 900502,'ruRU','Портал в начало острова',
       `castBarCaption`,`VerifiedBuild`
FROM `gameobject_template_locale`
WHERE `entry`=187056 AND `locale`='ruRU';

INSERT INTO `gameobject_template_addon`
(`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`)
SELECT 900502,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`
FROM `gameobject_template_addon`
WHERE `entry`=187056;

INSERT INTO `gameobject`
(`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,
 `position_x`,`position_y`,`position_z`,`orientation`,
 `rotation0`,`rotation1`,`rotation2`,`rotation3`,
 `spawntimesecs`,`animprogress`,`state`,`ScriptName`,`VerifiedBuild`,`Comment`)
VALUES
(900502,900502,530,0,0,1,1,
 12181.7,-7286.88,0.678391,4.8552,
 0,0,0.654856444,-0.755753292,
 180,100,1,'',0,'QuelDanas: Portal to isle entrance at Jestokyzza saved position');

COMMIT;
