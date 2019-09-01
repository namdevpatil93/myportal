INSERT INTO `modules` (`module_id`, `module_name`, `display_name`) VALUES ('12', 'messages', 'Messages');

INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES ('108','messageList, newMessage, editMessage, saveMessage, deleteMessage', 'Messages', '12');

INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '108');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('3', '108');

INSERT INTO `modules` (`module_id`, `module_name`, `display_name`) VALUES ('13', 'systemSettings', 'systemSettings');
INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES ('109','viewSystemSettings, saveSystemSetting', 'System Settings', '13');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '109');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('3', '109');

UPDATE `system_settings` SET `description` = 'Disable Payments (Enable = 0, Disable = 1)' WHERE `id` = '20';
UPDATE `system_settings` SET `description` = 'Disable Post Selection (Enable = 0, Disable = 1)' WHERE `id` = '19';
UPDATE `system_settings` SET `description` = 'Disable Save As Draft (Enable = 0, Disable = 1)' WHERE `id` = '18';
UPDATE `system_settings` SET `description` = 'Disable New Registration (Enable = 0, Disable = 1)' WHERE `id` = '17';

UPDATE `system_settings` SET `description` = 'Last date of payment (dd/MM/yyyy)' WHERE `id` = '12';
UPDATE `system_settings` SET `description` = 'Last date of application (dd/MM/yyyy)' WHERE `id` = '13';
