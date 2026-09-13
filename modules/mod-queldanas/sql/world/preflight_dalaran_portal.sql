-- Preflight jc-2026-08-28-queldanas-dalaran-portal-v1
-- Expected: template_exact=1, destination_exact=1, guid_collision=0, nearby_duplicate=0.
SELECT
    (SELECT COUNT(*) FROM `gameobject_template`
      WHERE `entry`=191164 AND `type`=22 AND `displayId`=8111
        AND `Data0`=53141 AND `Data1`=0 AND `Data2`=1) AS `template_exact`,
    (SELECT COUNT(*)
       FROM `spell_target_position` portal
       JOIN `spell_target_position` mage
         ON mage.`ID`=53140 AND mage.`EffectIndex`=0
        AND mage.`MapID`=portal.`MapID`
        AND ABS(mage.`PositionX`-portal.`PositionX`)<0.001
        AND ABS(mage.`PositionY`-portal.`PositionY`)<0.001
        AND ABS(mage.`PositionZ`-portal.`PositionZ`)<0.001
        AND ABS(mage.`Orientation`-portal.`Orientation`)<0.001
      WHERE portal.`ID`=53141 AND portal.`EffectIndex`=0) AS `destination_exact`,
    (SELECT COUNT(*) FROM `gameobject` WHERE `guid`=900500) AS `guid_collision`,
    (SELECT COUNT(*) FROM `gameobject`
      WHERE `id`=191164 AND `map`=530
        AND POW(`position_x`-12909.4,2)+POW(`position_y`+6878.77,2)<25) AS `nearby_duplicate`;
