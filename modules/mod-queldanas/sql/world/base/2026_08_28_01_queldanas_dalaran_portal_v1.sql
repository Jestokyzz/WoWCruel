-- jc-2026-08-28-queldanas-dalaran-portal-v1
-- Target DB: world. Apply only after preflight_dalaran_portal.sql passes.
-- Placement snapshot after Jestokyzza logout:
-- map 530, x 12909.4, y -6878.77, z 7.64907, orientation 0.503327.
START TRANSACTION;

INSERT INTO `gameobject`
(`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,
 `position_x`,`position_y`,`position_z`,`orientation`,
 `rotation0`,`rotation1`,`rotation2`,`rotation3`,
 `spawntimesecs`,`animprogress`,`state`,`ScriptName`,`VerifiedBuild`,`Comment`)
VALUES
(900500,191164,530,0,0,1,1,
 12909.4,-6878.77,7.64907,0.503327,
 0,0,0.249015402,0.968499525,
 300,100,1,'',0,'QuelDanas: Portal to Dalaran at Jestokyzza logout snapshot');

COMMIT;
