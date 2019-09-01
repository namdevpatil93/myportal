UPDATE `posts` SET `post_title` = 'Traffic Inspector (Jr.)' WHERE `post_id` = '6';

CREATE TABLE `notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `description` text,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

insert into `modules` (`module_id`, `module_name`, `display_name`, `is_enabled`) values('8','notification','Notification','1');

insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('81','notificationList','Notification List','8');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('82','newNotification,saveNotification','Create Notification','8');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('83','deleteNotification','Delete Notification','8');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('84','viewNotification','View Notification','8');

INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '81');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '82');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '83');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '84');

CREATE TABLE `queries` (
  `id` bigint(12) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `type_other` int(11) DEFAULT NULL,
  `title` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `applicant_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `replies` (
  `id` bigint(12) NOT NULL AUTO_INCREMENT,
  `query_id` bigint(12) NOT NULL,
  `parent_reply_id` bigint(12) DEFAULT NULL,
  `reply` text,
  `user_id` bigint(20) DEFAULT NULL,
  `user_type` int(1) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

insert into `modules` (`module_id`, `module_name`, `display_name`, `is_enabled`) values('9','applicantQuery','Applicant Query','1');

insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('91','applicantQueryList','Applicant Query List','9');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('92','newApplicantQuery,saveApplicantQuery','Create Applicant Query','9');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('93','deleteApplicantQuery','Delete Applicant Query','9');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('94','editApplicantQuery,saveApplicantQuery','Edit Applicant Query','9');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('95','viewQueriesAndNotifications','View Queries And Notifications','8');

INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('2', '91');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('2', '92');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('2', '93');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('2', '94');

INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '91');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '95');

ALTER TABLE cities ADD COLUMN city_order INT(11) NULL AFTER message_key;

UPDATE cities SET city_order = '1' WHERE id = '1'; 
UPDATE cities SET city_order = '2' WHERE id = '2'; 
UPDATE cities SET city_order = '3' WHERE id = '3'; 
UPDATE cities SET city_order = '4' WHERE id = '4'; 
UPDATE cities SET city_order = '5' WHERE id = '5'; 
UPDATE cities SET city_order = '6' WHERE id = '6'; 
UPDATE cities SET city_order = '7' WHERE id = '7'; 
UPDATE cities SET city_order = '8' WHERE id = '8'; 
UPDATE cities SET city_order = '9' WHERE id = '9'; 
UPDATE cities SET city_order = '10' WHERE id = '10'; 
UPDATE cities SET city_order = '11' WHERE id = '11'; 
UPDATE cities SET city_order = '12' WHERE id = '12'; 
UPDATE cities SET city_order = '13' WHERE id = '13'; 
UPDATE cities SET city_order = '14' WHERE id = '14'; 
UPDATE cities SET city_order = '15' WHERE id = '15'; 
UPDATE cities SET city_order = '16' WHERE id = '16'; 
UPDATE cities SET city_order = '17' WHERE id = '17'; 
UPDATE cities SET city_order = '18' WHERE id = '18'; 
UPDATE cities SET city_order = '19' WHERE id = '19'; 
UPDATE cities SET city_order = '20' WHERE id = '20'; 
UPDATE cities SET city_order = '21' WHERE id = '21'; 
UPDATE cities SET city_order = '22' WHERE id = '22'; 
UPDATE cities SET city_order = '23' WHERE id = '23'; 
UPDATE cities SET city_order = '24' WHERE id = '24'; 
UPDATE cities SET city_order = '25' WHERE id = '40'; 
UPDATE cities SET city_order = '26' WHERE id = '25'; 
UPDATE cities SET city_order = '27' WHERE id = '26'; 
UPDATE cities SET city_order = '28' WHERE id = '27'; 
UPDATE cities SET city_order = '29' WHERE id = '28'; 
UPDATE cities SET city_order = '30' WHERE id = '29'; 
UPDATE cities SET city_order = '31' WHERE id = '30'; 
UPDATE cities SET city_order = '32' WHERE id = '31'; 
UPDATE cities SET city_order = '33' WHERE id = '32'; 
UPDATE cities SET city_order = '34' WHERE id = '33'; 
UPDATE cities SET city_order = '35' WHERE id = '34'; 
UPDATE cities SET city_order = '36' WHERE id = '35'; 
UPDATE cities SET city_order = '37' WHERE id = '36'; 
UPDATE cities SET city_order = '38' WHERE id = '37'; 
UPDATE cities SET city_order = '39' WHERE id = '38'; 
UPDATE cities SET city_order = '40' WHERE id = '39';

ALTER TABLE districts ADD COLUMN district_order INT(11) NULL AFTER message_key;

UPDATE districts SET district_order = '1' WHERE id = '1'; 
UPDATE districts SET district_order = '2' WHERE id = '2'; 
UPDATE districts SET district_order = '3' WHERE id = '3'; 
UPDATE districts SET district_order = '4' WHERE id = '4'; 
UPDATE districts SET district_order = '5' WHERE id = '5'; 
UPDATE districts SET district_order = '6' WHERE id = '6'; 
UPDATE districts SET district_order = '7' WHERE id = '7'; 
UPDATE districts SET district_order = '8' WHERE id = '8'; 
UPDATE districts SET district_order = '9' WHERE id = '9'; 
UPDATE districts SET district_order = '10' WHERE id = '10'; 
UPDATE districts SET district_order = '11' WHERE id = '11'; 
UPDATE districts SET district_order = '12' WHERE id = '12'; 
UPDATE districts SET district_order = '13' WHERE id = '13'; 
UPDATE districts SET district_order = '14' WHERE id = '14'; 
UPDATE districts SET district_order = '15' WHERE id = '15'; 
UPDATE districts SET district_order = '16' WHERE id = '16'; 
UPDATE districts SET district_order = '17' WHERE id = '17'; 
UPDATE districts SET district_order = '18' WHERE id = '18'; 
UPDATE districts SET district_order = '19' WHERE id = '19'; 
UPDATE districts SET district_order = '20' WHERE id = '20'; 
UPDATE districts SET district_order = '21' WHERE id = '21'; 
UPDATE districts SET district_order = '22' WHERE id = '22'; 
UPDATE districts SET district_order = '23' WHERE id = '23'; 
UPDATE districts SET district_order = '24' WHERE id = '24'; 
UPDATE districts SET district_order = '25' WHERE id = '40'; 
UPDATE districts SET district_order = '26' WHERE id = '25'; 
UPDATE districts SET district_order = '27' WHERE id = '26'; 
UPDATE districts SET district_order = '28' WHERE id = '27'; 
UPDATE districts SET district_order = '29' WHERE id = '28'; 
UPDATE districts SET district_order = '30' WHERE id = '29'; 
UPDATE districts SET district_order = '31' WHERE id = '30'; 
UPDATE districts SET district_order = '32' WHERE id = '31'; 
UPDATE districts SET district_order = '33' WHERE id = '32'; 
UPDATE districts SET district_order = '34' WHERE id = '33'; 
UPDATE districts SET district_order = '35' WHERE id = '34'; 
UPDATE districts SET district_order = '36' WHERE id = '35'; 
UPDATE districts SET district_order = '37' WHERE id = '36'; 
UPDATE districts SET district_order = '38' WHERE id = '37'; 
UPDATE districts SET district_order = '39' WHERE id = '38'; 
UPDATE districts SET district_order = '40' WHERE id = '39';

ALTER TABLE divisions ADD COLUMN division_order INT(11) NULL AFTER message_key; 

UPDATE divisions SET division_order = '1' WHERE division_id = '1'; 
UPDATE divisions SET division_order = '2' WHERE division_id = '2'; 
UPDATE divisions SET division_order = '3' WHERE division_id = '3'; 
UPDATE divisions SET division_order = '4' WHERE division_id = '4'; 
UPDATE divisions SET division_order = '5' WHERE division_id = '5'; 
UPDATE divisions SET division_order = '6' WHERE division_id = '6'; 
UPDATE divisions SET division_order = '7' WHERE division_id = '7'; 
UPDATE divisions SET division_order = '8' WHERE division_id = '36'; 
UPDATE divisions SET division_order = '9' WHERE division_id = '33'; 
UPDATE divisions SET division_order = '10' WHERE division_id = '35'; 
UPDATE divisions SET division_order = '11' WHERE division_id = '34'; 
UPDATE divisions SET division_order = '12' WHERE division_id = '8'; 
UPDATE divisions SET division_order = '13' WHERE division_id = '9'; 
UPDATE divisions SET division_order = '14' WHERE division_id = '10'; 
UPDATE divisions SET division_order = '15' WHERE division_id = '11'; 
UPDATE divisions SET division_order = '16' WHERE division_id = '12'; 
UPDATE divisions SET division_order = '17' WHERE division_id = '13'; 
UPDATE divisions SET division_order = '18' WHERE division_id = '14'; 
UPDATE divisions SET division_order = '19' WHERE division_id = '15'; 
UPDATE divisions SET division_order = '20' WHERE division_id = '17'; 
UPDATE divisions SET division_order = '21' WHERE division_id = '18'; 
UPDATE divisions SET division_order = '22' WHERE division_id = '19'; 
UPDATE divisions SET division_order = '23' WHERE division_id = '20'; 
UPDATE divisions SET division_order = '24' WHERE division_id = '21'; 
UPDATE divisions SET division_order = '25' WHERE division_id = '22'; 
UPDATE divisions SET division_order = '26' WHERE division_id = '23'; 
UPDATE divisions SET division_order = '27' WHERE division_id = '24'; 
UPDATE divisions SET division_order = '28' WHERE division_id = '25'; 
UPDATE divisions SET division_order = '29' WHERE division_id = '26'; 
UPDATE divisions SET division_order = '30' WHERE division_id = '27'; 
UPDATE divisions SET division_order = '31' WHERE division_id = '28'; 
UPDATE divisions SET division_order = '32' WHERE division_id = '29'; 
UPDATE divisions SET division_order = '33' WHERE division_id = '30'; 
UPDATE divisions SET division_order = '34' WHERE division_id = '31'; 
UPDATE divisions SET division_order = '35' WHERE division_id = '32'; 