INSERT INTO `system_settings` (`id`, `description`, `modified_time` ,`value`)
VALUES ('17', 'Disable New Registration', '2018-04-17 09:20:32', '1');

INSERT INTO `system_settings` (`id`, `description`, `modified_time` ,`value`)
VALUES ('18', 'Disable Save As Draft', '2018-04-17 09:20:32', '1');

INSERT INTO `system_settings` (`id`, `description`, `modified_time` ,`value`)
VALUES ('19', 'Disable Post Selection', '2018-04-17 09:20:32', '1');

INSERT INTO `system_settings` (`id`, `description`, `modified_time` ,`value`)
VALUES ('20', 'Disable Payments', '2018-04-17 09:20:32', '1');

CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `message_mr` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `qualifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `title_mr` text NOT NULL,
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `module_operations` (`module_operation_id`,`module_operation_name`, `display_name`, `module_id`) VALUES ('106', 'administration', 'Administration', '1');

INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '106');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('3', '106');

INSERT INTO `modules` (`module_id`, `module_name`, `display_name`) VALUES ('11', 'qualifications', 'Qualifications');
INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES ('107', 'qualificationList, newQualification,editQualification, saveQualification, deleteQualification', 'Qualifications', '11');

INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '107');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('3', '107');

