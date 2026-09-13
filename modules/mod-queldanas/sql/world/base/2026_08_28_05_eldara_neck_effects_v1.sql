-- jc-2026-08-28-queldanas-neck-effects-v1
-- Four level-232 Eldara necklaces: merged permanent stats, real sockets,
-- custom Aldor/Scryer mechanics and authoritative cooldown/proc bindings.
START TRANSACTION;

UPDATE `item_template` SET
    `stat_value1`=115,
    `socketColor_1`=4, `socketContent_1`=0, `socketBonus`=3752,
    `spellid_1`=80923, `spelltrigger_1`=1, `spellcharges_1`=0, `spellppmRate_1`=0,
    `spellcooldown_1`=-1, `spellcategory_1`=0, `spellcategorycooldown_1`=-1,
    `spellid_2`=0, `spelltrigger_2`=0, `spellcharges_2`=0, `spellppmRate_2`=0,
    `spellcooldown_2`=-1, `spellcategory_2`=0, `spellcategorycooldown_2`=-1,
    `spellid_3`=0, `spelltrigger_3`=0, `spellcharges_3`=0, `spellppmRate_3`=0,
    `spellcooldown_3`=-1, `spellcategory_3`=0, `spellcategorycooldown_3`=-1
WHERE `entry`=900311;

UPDATE `item_template` SET
    `stat_value1`=115,
    `socketColor_1`=4, `socketContent_1`=0, `socketBonus`=3752,
    `spellid_1`=80922, `spelltrigger_1`=1, `spellcharges_1`=0, `spellppmRate_1`=0,
    `spellcooldown_1`=-1, `spellcategory_1`=0, `spellcategorycooldown_1`=-1,
    `spellid_2`=0, `spelltrigger_2`=0, `spellcharges_2`=0, `spellppmRate_2`=0,
    `spellcooldown_2`=-1, `spellcategory_2`=0, `spellcategorycooldown_2`=-1,
    `spellid_3`=0, `spelltrigger_3`=0, `spellcharges_3`=0, `spellppmRate_3`=0,
    `spellcooldown_3`=-1, `spellcategory_3`=0, `spellcategorycooldown_3`=-1
WHERE `entry`=900312;

UPDATE `item_template` SET
    `stat_value2`=161,
    `socketColor_1`=2, `socketContent_1`=0, `socketBonus`=2877,
    `spellid_1`=80921, `spelltrigger_1`=1, `spellcharges_1`=0, `spellppmRate_1`=0,
    `spellcooldown_1`=-1, `spellcategory_1`=0, `spellcategorycooldown_1`=-1,
    `spellid_2`=0, `spelltrigger_2`=0, `spellcharges_2`=0, `spellppmRate_2`=0,
    `spellcooldown_2`=-1, `spellcategory_2`=0, `spellcategorycooldown_2`=-1
WHERE `entry`=900313;

UPDATE `item_template` SET
    `socketColor_1`=2, `socketContent_1`=0, `socketBonus`=2882,
    `spellid_1`=80924, `spelltrigger_1`=0, `spellcharges_1`=0, `spellppmRate_1`=0,
    `spellcooldown_1`=120000, `spellcategory_1`=0, `spellcategorycooldown_1`=-1,
    `spellid_2`=0, `spelltrigger_2`=0, `spellcharges_2`=0, `spellppmRate_2`=0,
    `spellcooldown_2`=-1, `spellcategory_2`=0, `spellcategorycooldown_2`=-1
WHERE `entry`=900314;

DELETE FROM `spell_proc` WHERE `SpellId` BETWEEN 80921 AND 80923;
INSERT INTO `spell_proc`
SELECT 80921,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,
       `ProcFlags`,`SpellTypeMask`,`SpellPhaseMask`,`HitMask`,`AttributesMask`,`DisableEffectsMask`,
       `ProcsPerMinute`,`Chance`,45000,`Charges`
FROM `spell_proc` WHERE `SpellId`=45482;
INSERT INTO `spell_proc`
SELECT 80922,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,
       `ProcFlags`,`SpellTypeMask`,`SpellPhaseMask`,`HitMask`,`AttributesMask`,`DisableEffectsMask`,
       `ProcsPerMinute`,`Chance`,45000,`Charges`
FROM `spell_proc` WHERE `SpellId`=45481;
INSERT INTO `spell_proc`
SELECT 80923,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,
       `ProcFlags`,`SpellTypeMask`,`SpellPhaseMask`,`HitMask`,`AttributesMask`,`DisableEffectsMask`,
       `ProcsPerMinute`,`Chance`,45000,`Charges`
FROM `spell_proc` WHERE `SpellId`=45484;

DELETE FROM `spell_script_names` WHERE `spell_id` BETWEEN 80921 AND 80924;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(80921,'spell_queldanas_neck_proc'),
(80922,'spell_queldanas_neck_proc'),
(80923,'spell_queldanas_neck_proc'),
(80924,'spell_queldanas_neck_resolve');

COMMIT;
