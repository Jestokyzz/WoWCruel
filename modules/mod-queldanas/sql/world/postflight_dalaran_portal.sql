-- Postflight jc-2026-08-28-queldanas-dalaran-portal-v1
-- Expected: portal_ready=1.
SELECT COUNT(*) AS `portal_ready`
FROM `gameobject` g
JOIN `gameobject_template` t ON t.`entry`=g.`id`
JOIN `spell_target_position` portal
  ON portal.`ID`=t.`Data0` AND portal.`EffectIndex`=0
JOIN `spell_target_position` mage
  ON mage.`ID`=53140 AND mage.`EffectIndex`=0
 AND mage.`MapID`=portal.`MapID`
 AND ABS(mage.`PositionX`-portal.`PositionX`)<0.001
 AND ABS(mage.`PositionY`-portal.`PositionY`)<0.001
 AND ABS(mage.`PositionZ`-portal.`PositionZ`)<0.001
 AND ABS(mage.`Orientation`-portal.`Orientation`)<0.001
WHERE g.`guid`=900500 AND g.`id`=191164 AND g.`map`=530
  AND ABS(g.`position_x`-12909.4)<0.01
  AND ABS(g.`position_y`+6878.77)<0.01
  AND ABS(g.`position_z`-7.64907)<0.01
  AND ABS(g.`orientation`-0.503327)<0.0001
  AND g.`spawnMask`=1 AND g.`phaseMask`=1 AND g.`state`=1
  AND t.`type`=22 AND t.`displayId`=8111 AND t.`Data0`=53141;
