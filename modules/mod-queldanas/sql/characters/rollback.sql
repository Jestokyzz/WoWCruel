-- Character DB rollback cleanup for jc-2026-08-28-queldanas-v1.
DELETE FROM `character_aura` WHERE `spell`=80920;

