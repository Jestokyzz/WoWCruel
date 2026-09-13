-- jc-2026-08-28-queldanas-return-portal-v1
-- Target DB: world. Apply only after preflight_return_portal.sql passes.
-- Placement snapshot after Jestokyzza logout:
-- map 571, x 5913.81, y 619.233, z 646.425, orientation 1.5444.
-- Custom template 900501 is a full property clone of stock template 187056.
START TRANSACTION;

INSERT INTO `gameobject_template`
(`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,
 `Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,
 `Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,
 `Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,
 `AIName`,`ScriptName`,`VerifiedBuild`)
SELECT
 900501,`type`,`displayId`,'Dalaran Portal to Isle of Quel''Danas',
 `IconName`,`castBarCaption`,`unk1`,`size`,
 `Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,
 `Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,
 `Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,
 `AIName`,`ScriptName`,`VerifiedBuild`
FROM `gameobject_template`
WHERE `entry`=187056;

INSERT INTO `gameobject_template_locale`
(`entry`,`locale`,`name`,`castBarCaption`,`VerifiedBuild`)
SELECT 900501,'ruRU','Портал из Даларана на остров Кель''Данас',
       `castBarCaption`,`VerifiedBuild`
FROM `gameobject_template_locale`
WHERE `entry`=187056 AND `locale`='ruRU';

INSERT INTO `gameobject_template_addon`
(`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`)
SELECT 900501,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`
FROM `gameobject_template_addon`
WHERE `entry`=187056;

INSERT INTO `gameobject`
(`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,
 `position_x`,`position_y`,`position_z`,`orientation`,
 `rotation0`,`rotation1`,`rotation2`,`rotation3`,
 `spawntimesecs`,`animprogress`,`state`,`ScriptName`,`VerifiedBuild`,`Comment`)
VALUES
(900501,900501,571,0,0,1,1,
 5913.81,619.233,646.425,1.5444,
 0,0,0.697712956,0.716377436,
 180,100,1,'',0,'QuelDanas: Dalaran return portal at Jestokyzza logout snapshot');

COMMIT;
