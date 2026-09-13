-- jc-2026-08-28-queldanas-island-entrance-portal-spawn-2-v1
-- Target DB: world. Apply only after preflight_island_entrance_portal_spawn_2.sql passes.
-- Live position forced to DB with clone-worldserver console command saveall:
-- map 530, x 12604.6, y -6533.69, z 4.11736, orientation 5.4694.
-- Reuses the already verified custom portal template 900502.
START TRANSACTION;

INSERT INTO `gameobject`
(`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,
 `position_x`,`position_y`,`position_z`,`orientation`,
 `rotation0`,`rotation1`,`rotation2`,`rotation3`,
 `spawntimesecs`,`animprogress`,`state`,`ScriptName`,`VerifiedBuild`,`Comment`)
VALUES
(900503,900502,530,0,0,1,1,
 12604.6,-6533.69,4.11736,5.4694,
 0,0,0.395757596,-0.918355010,
 180,100,1,'',0,'QuelDanas: second portal to isle entrance at Jestokyzza live-saved position');

COMMIT;
