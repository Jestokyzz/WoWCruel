-- Target: acore_world. New isolated vendor, no item price edits.
SET NAMES utf8mb4;
START TRANSACTION;
INSERT INTO creature_template (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`speed_swim`,`speed_flight`,`detection_range`,`rank`,`dmgschool`,`DamageModifier`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`dynamicflags`,`family`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`HoverHeight`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`ExperienceModifier`,`RacialLeader`,`movementId`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`VerifiedBuild`) SELECT 900500,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,'Хламовник Джигс','Бесплатные товары','',0,80,80,`exp`,35,128,`speed_walk`,`speed_run`,`speed_swim`,`speed_flight`,`detection_range`,0,`dmgschool`,`DamageModifier`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,2,`unit_flags2`,`dynamicflags`,`family`,`type`,`type_flags`,0,0,0,`PetSpellDataId`,`VehicleId`,0,0,'',0,`HoverHeight`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`ExperienceModifier`,`RacialLeader`,`movementId`,`RegenHealth`,`CreatureImmunitiesId`,2,'',0 FROM creature_template WHERE entry=2496;
INSERT INTO creature_template_model (CreatureID,Idx,CreatureDisplayID,DisplayScale,Probability,VerifiedBuild) VALUES (900500,0,7167,1,1,0);
INSERT INTO creature_template_locale (entry,locale,Name,Title,VerifiedBuild) VALUES (900500,'ruRU','Хламовник Джигс','Бесплатные товары',0);
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES (900500,0,49224,0,0,0,0);
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES (900500,1,900218,0,0,0,0);
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES (900500,2,900114,0,0,0,0);
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES (900500,3,900110,0,0,0,0);
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES (900500,4,900111,0,0,0,0);
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES (900500,5,900112,0,0,0,0);
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES (900500,6,900113,0,0,0,0);
INSERT INTO creature (guid,id,map,zoneId,areaId,spawnMask,phaseMask,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,wander_distance,curhealth,curmana,MovementType,Comment) VALUES (5300729,900500,571,4395,4620,1,1,0,5913.56,656.292,643.762,3.91454,300,0,1,0,0,'Jigs free custom vendor 2026-09-10');
COMMIT;
