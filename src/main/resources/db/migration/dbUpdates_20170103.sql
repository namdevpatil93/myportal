INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES('96','applicantQueryListAdmin','Applicant Query List Admin','9');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('2', '96');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '96');

ALTER TABLE `queries` ADD COLUMN `created_by` INT(11);
ALTER TABLE `queries` ADD COLUMN `last_modified_by` INT(11);
ALTER TABLE `queries` ADD COLUMN `last_modified_date` DATETIME;

INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES('97','replyApplicantQuery','Applicant Query Reply','9');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('2', '97');

INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES('98','saveApplicantQueryReply','Save Applicant Query Reply','9');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '98');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('2', '98');

INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES('99','adminReplyApplicantQuery','Applicant Query Reply Admin','9');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '99');

ALTER TABLE `applicant_post_assoc` CHANGE `status` `status` INT(11) NOT NULL;

UPDATE `module_operations` SET `module_operation_name` = 'showApplicantsPostAssocList, applicantsPostAssocList, downloadApplicantPostAssocCSV' WHERE `module_operation_id` = '20';

CREATE TABLE `user_notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `notification_id` bigint(20) NOT NULL,
  `applicant_id` bigint(20) NOT NULL,
  `sent_on` datetime NOT NULL,
  `notification_read` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('85','userNotificationList','User Notification List','8');
insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('95','2','85');

insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('100','markUserNotificationAsRead','Mark User Notification As Read','8');
insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('96','2','100');