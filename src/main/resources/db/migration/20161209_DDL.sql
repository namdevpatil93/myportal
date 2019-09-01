/*Table structure for table `modules` */

DROP TABLE IF EXISTS `modules`;

CREATE TABLE `modules` (
  `module_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `is_enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `module_operations` */

DROP TABLE IF EXISTS `module_operations`;

CREATE TABLE `module_operations` (
  `module_operation_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_operation_name` varchar(4000) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `module_id` smallint(6) NOT NULL,
  PRIMARY KEY (`module_operation_id`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `FK9xtsupkx3ux10kaq9u19hfxie` FOREIGN KEY (`module_id`) REFERENCES `modules` (`module_id`),
  CONSTRAINT `module_operations_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `modules` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_enabled` tinyint(1) DEFAULT NULL,
  `is_system_defined` tinyint(1) NOT NULL,
  `parent_role_id` tinyint(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `role_module_operation_assoc` */

DROP TABLE IF EXISTS `role_module_operation_assoc`;

CREATE TABLE `role_module_operation_assoc` (
  `role_module_operation_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `module_operation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`role_module_operation_id`),
  KEY `FK_5vdc1f9lfehkfj39wb9sh46a3` (`module_operation_id`),
  KEY `FK_phpl3f7ymus8fk6vdcy031luw` (`role_id`),
  CONSTRAINT `FK3h5y4tjjxpi63nr12ins75ak0` FOREIGN KEY (`module_operation_id`) REFERENCES `module_operations` (`module_operation_id`),
  CONSTRAINT `FK_5vdc1f9lfehkfj39wb9sh46a3` FOREIGN KEY (`module_operation_id`) REFERENCES `module_operations` (`module_operation_id`),
  CONSTRAINT `FK_phpl3f7ymus8fk6vdcy031luw` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `FKiccdocnwk97posasbi4vyef6g` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  `last_modified_by` int(11) DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `FKp56c1712k691lhsyewcssf40f` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `system_settings` */

DROP TABLE IF EXISTS `system_settings`;

CREATE TABLE `system_settings` (
  `id` bigint(20) NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `trades` */

DROP TABLE IF EXISTS `trades`;

CREATE TABLE `trades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `message_key` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `post_super_category` */

DROP TABLE IF EXISTS `post_super_category`;

CREATE TABLE `post_super_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `super_category_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `super_category_order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `post_category` */

DROP TABLE IF EXISTS `post_category`;

CREATE TABLE `post_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `post_super_category` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `posts` */

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `post_id` int(6) NOT NULL AUTO_INCREMENT,
  `post_title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `message_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `post_type` int(11) NOT NULL DEFAULT '0',
  `post_order` int(4) DEFAULT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`post_id`),
  KEY `fk_category_details` (`post_type`),
  CONSTRAINT `fk_category_details` FOREIGN KEY (`post_type`) REFERENCES `post_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `qualification_types` */

DROP TABLE IF EXISTS `qualification_types`;

CREATE TABLE `qualification_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `message_key` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `cities` */

DROP TABLE IF EXISTS `cities`;

CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `districts` */

DROP TABLE IF EXISTS `districts`;

CREATE TABLE `districts` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `message_key` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `divisions` */

DROP TABLE IF EXISTS `divisions`;

CREATE TABLE `divisions` (
  `division_id` int(6) NOT NULL AUTO_INCREMENT,
  `division_title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `message_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`division_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `castes` */

DROP TABLE IF EXISTS `castes`;

CREATE TABLE `castes` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `caste_title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `message_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `post_fees` int(11) NOT NULL DEFAULT '250',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


/*Table structure for table `applicants` */

DROP TABLE IF EXISTS `applicants`;

CREATE TABLE `applicants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` int(1) DEFAULT NULL,
  `address` mediumtext COLLATE utf8_unicode_ci,
  `pin_code` int(11) DEFAULT NULL,
  `email_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile_number` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marital_status` int(11) DEFAULT NULL,
  `maharashtra_domiciled` tinyint(1) DEFAULT NULL,
  `read_write_speak_marathi` tinyint(1) DEFAULT NULL,
  `caste_id` int(11) DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `first_login` tinyint(1) NOT NULL DEFAULT '1',
  `non_creamy_layer` tinyint(1) DEFAULT NULL,
  `certificate_validity_ending_Date` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `subcategory` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `district_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKaluc24vf3qkmlgbo3klhgn38b` (`role_id`),
  KEY `fk_caste_details` (`caste_id`),
  CONSTRAINT `FKaluc24vf3qkmlgbo3klhgn38b` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `fk_caste_details` FOREIGN KEY (`caste_id`) REFERENCES `castes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `applicant_files` */

DROP TABLE IF EXISTS `applicant_files`;

CREATE TABLE `applicant_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicant_id` int(11) NOT NULL,
  `photo_file_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `signature_file_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `last_modified_date` datetime NOT NULL,
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `applicant_other_information` */

DROP TABLE IF EXISTS `applicant_other_information`;

CREATE TABLE `applicant_other_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicant_id` int(11) NOT NULL,
  `part_time_employee` tinyint(1) DEFAULT NULL,
  `ex_service_man` tinyint(1) DEFAULT NULL,
  `retirement_date` date DEFAULT NULL,
  `st_employee` tinyint(1) DEFAULT NULL,
  `sports_person` tinyint(1) DEFAULT NULL,
  `sports_level` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `project_effected` tinyint(1) DEFAULT NULL,
  `earth_quake_effected` tinyint(1) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `exserviceman_total_experience_in_years` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exserviceman_total_experience_in_months` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parttimeemployee_total_experience_in_years` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parttimeemployee_total_experience_in_months` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_applicant` (`applicant_id`),
  CONSTRAINT `fk_applicant` FOREIGN KEY (`applicant_id`) REFERENCES `applicants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `applicant_otps` */

DROP TABLE IF EXISTS `applicant_otps`;

CREATE TABLE `applicant_otps` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `applicant_id` bigint(20) NOT NULL,
  `otp` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `applicant_post_assoc` */

DROP TABLE IF EXISTS `applicant_post_assoc`;

CREATE TABLE `applicant_post_assoc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicant_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `is_ssc_passed` tinyint(1) DEFAULT NULL,
  `other_qualification_details` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_night_blindness` tinyint(1) DEFAULT NULL,
  `is_color_blindness` tinyint(1) DEFAULT NULL,
  `is_vision_acuity` tinyint(1) DEFAULT NULL,
  `is_differently_abled` tinyint(1) DEFAULT NULL,
  `is_blindness_and_low_vision` tinyint(1) DEFAULT NULL,
  `is_deaf_and_mute` tinyint(1) DEFAULT NULL,
  `is_locomotor_or_cerebral_palsy` tinyint(1) DEFAULT NULL,
  `is_own_heavy_driving_license_number` tinyint(1) DEFAULT NULL,
  `heavy_driving_license_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `heavy_driving_license_issue_date` date DEFAULT NULL,
  `heavy_driving_license_end_date` date DEFAULT NULL,
  `is_own_psv_batch_number` tinyint(1) DEFAULT NULL,
  `psv_batch_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_own_conductor_batch_number` tinyint(1) DEFAULT NULL,
  `conductor_batch_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `conductor_batch_number_issue_date` date DEFAULT NULL,
  `conductor_batch_number_end_date` date DEFAULT NULL,
  `is_experienced` tinyint(1) DEFAULT NULL,
  `is_min_three_yrs_exp` tinyint(1) DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_experience_in_years` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_experience_in_months` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_height_within_range` tinyint(1) DEFAULT NULL,
  `is_past_accidental_or_death_incident` tinyint(1) DEFAULT NULL,
  `past_accidental_or_death_incident_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `division_id` int(11) DEFAULT NULL,
  `is_guarantor_person_name_and_mobile_no` tinyint(1) DEFAULT NULL,
  `guarantor_person_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `guarantor_person_mobile_number` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_iti_passed` tinyint(1) DEFAULT NULL,
  `iti_passout_college_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_graduate_from_affiliated_institute` tinyint(1) DEFAULT NULL,
  `degree_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `college_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_mscit_or_doeacc_pass_certification` tinyint(1) DEFAULT NULL,
  `is_typing_exam_passed` tinyint(1) DEFAULT NULL,
  `trade_id` int(11) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `mba_from_government_affiliated_institute` tinyint(1) DEFAULT NULL,
  `university_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `it_engineer` tinyint(1) DEFAULT NULL,
  `knowledge_of_sap_and_oracle` tinyint(1) DEFAULT NULL,
  `min_ten_yrs_exp_as_it_project_manager` tinyint(1) DEFAULT NULL,
  `bcom_passed` tinyint(1) DEFAULT NULL,
  `one_year_exp_as_accountant` tinyint(1) DEFAULT NULL,
  `mscitOrGaccc` tinyint(1) DEFAULT NULL,
  `two_year_exp_as_transport_association` tinyint(1) DEFAULT NULL,
  `mscit_or_gaccc` tinyint(1) DEFAULT NULL,
  `bcom_or_bsc_or_diploma_holders_in_automobile_or_mechanical` tinyint(1) DEFAULT NULL,
  `architect_engineering_degree` tinyint(1) DEFAULT NULL,
  `electrical_engineering_degree` tinyint(1) DEFAULT NULL,
  `one_year_exp_as_transport_association` tinyint(1) DEFAULT NULL,
  `submitted_date` date DEFAULT NULL,
  `qualification_for_military_force` tinyint(1) DEFAULT NULL,
  `fire_safety_degree_from_affiliated_institute` tinyint(1) DEFAULT NULL,
  `miltary_force_degree_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `military_force_university_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fire_and_safety_degree_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fire_and_safety_university_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `automobile_mechanical_engineering_degree` tinyint(1) DEFAULT NULL,
  `one_year_exp_in_automobile_repairing` tinyint(1) DEFAULT NULL,
  `diploma_in_autocad` tinyint(1) DEFAULT NULL,
  `diploma_in_autocad_university_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `autocad_certification_from_government` tinyint(1) DEFAULT NULL,
  `autocad_certification_government_institute_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `experience_in_autocad` tinyint(1) DEFAULT NULL,
  `experience_letter_upload` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `txn_order_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_applicants` (`applicant_id`),
  KEY `fk_posts` (`post_id`),
  CONSTRAINT `fk_applicants` FOREIGN KEY (`applicant_id`) REFERENCES `applicants` (`id`),
  CONSTRAINT `fk_posts` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `change_password_requests` */

DROP TABLE IF EXISTS `change_password_requests`;

CREATE TABLE `change_password_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_address` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `user_type` tinyint(2) NOT NULL,
  `token` varchar(225) COLLATE utf8_unicode_ci NOT NULL,
  `created_date` datetime NOT NULL,
  `expired` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


/*Table structure for table `payment_transactions` */

DROP TABLE IF EXISTS `payment_transactions`;

CREATE TABLE `payment_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicant_id` int(11) NOT NULL,
  `order_no` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `txn_reference_no` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `auth_status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `response_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `last_modified_date` datetime NOT NULL,
  `payment_mode` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `sms_sent_history` */

DROP TABLE IF EXISTS `sms_sent_history`;

CREATE TABLE `sms_sent_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sms_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sent_to` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sent_time` datetime DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `challans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jrnl_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tran_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fee_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `application_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `validation_data` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tran_date` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tran_branch` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tran_time` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `applicant_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `challan_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `uploaded_by` int(11) NOT NULL,
  `uploaded_date` datetime NOT NULL,
  `original_file_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `document_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `document_type` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  `last_modified_by` int(11) DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE applicant_other_information CHANGE city_id city_id_first_preference INT(11) NULL, ADD COLUMN city_id_second_preference INT(11) NULL AFTER city_id_first_preference, ADD COLUMN city_id_third_preference INT(11) NULL AFTER city_id_second_preference; 

/* advertisements table */
CREATE TABLE `advertisements` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) DEFAULT NULL,
  `description` text,
  `document_name` varchar(150) DEFAULT NULL,
  `created_by` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `last_modified_by` bigint(20) DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `advertisement_no` varchar(50) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `closing_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `advertisements` ADD COLUMN `is_active` TINYINT NULL AFTER `closing_date`; 

/*14-12-20168*/
ALTER TABLE castes ADD COLUMN caste_order INT(11) NULL AFTER post_fees;

ALTER TABLE `documents` CHANGE `description` `description` TEXT CHARSET utf8 COLLATE utf8_unicode_ci NULL, CHANGE `document_name` `document_name` VARCHAR(255) CHARSET utf8 COLLATE utf8_unicode_ci NULL;

ALTER TABLE `documents` ADD COLUMN `title_mr` VARCHAR(255) NULL AFTER `last_modified_date`, ADD COLUMN `description_mr` TEXT NULL AFTER `title_mr`, ADD COLUMN `document_name_mr` VARCHAR(255) NULL AFTER `description_mr`; 

CREATE TABLE post_division_assoc( id INT(11) NOT NULL AUTO_INCREMENT, post_id INT(11), division_id INT(11), PRIMARY KEY (id), CONSTRAINT fk_post FOREIGN KEY (post_id) REFERENCES posts(post_id), CONSTRAINT fk_division FOREIGN KEY (division_id) REFERENCES divisions(division_id) );

ALTER TABLE `advertisements` CHANGE `title` `title` VARCHAR(255) CHARSET utf8 COLLATE utf8_general_ci NULL, CHANGE `document_name` `document_name` VARCHAR(255) CHARSET utf8 COLLATE utf8_general_ci NULL, ADD COLUMN `title_marathi` VARCHAR(255) NULL AFTER `is_active`, ADD COLUMN `description_marathi` TEXT NULL AFTER `title_marathi`, ADD COLUMN `document_name_marathi` VARCHAR(255) NULL AFTER `description_marathi`, ADD COLUMN `advertisement_no_marathi` VARCHAR(50) NULL AFTER `document_name_marathi`; 