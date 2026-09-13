SET NAMES utf8mb4;
START TRANSACTION;
DELETE FROM creature WHERE guid=5300729 AND id=900500;
DELETE FROM npc_vendor WHERE entry=900500;
DELETE FROM creature_template_locale WHERE entry=900500;
DELETE FROM creature_template_model WHERE CreatureID=900500;
DELETE FROM creature_template WHERE entry=900500;
COMMIT;
