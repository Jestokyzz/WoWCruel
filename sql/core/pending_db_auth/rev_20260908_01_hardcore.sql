-- Target: isolated hardcore_test_auth_v1. Preflight must prove 1010 is free or owned by Hardcore.
DELETE FROM `rbac_linked_permissions` WHERE `id` = 199 AND `linkedId` = 1010;
DELETE FROM `rbac_permissions` WHERE `id` = 1010;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES (1010, 'Command: hardcore');
DELETE FROM `rbac_linked_permissions` WHERE `id` = 199 AND `linkedId` = 1010;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES (199, 1010);
