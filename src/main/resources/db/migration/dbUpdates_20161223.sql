INSERT  INTO `posts`(`post_id`,`post_title`,`message_key`,`post_type`,`post_order`,`active`) VALUES (21,'Driver cum conductor','post.driver.conductor',1,21,1);

UPDATE module_operations SET module_operation_name = 'showUploadChallan, saveChallan, downloadChallanData' WHERE module_operation_id = '22';

/* light motor vechicle added in conductor post page */
ALTER TABLE `applicant_post_assoc` ADD COLUMN light_motor_vechicle TINYINT(1) ;
ALTER TABLE `applicant_post_assoc` ADD COLUMN light_motor_vechicle_license_no VARCHAR(30);
ALTER TABLE `applicant_post_assoc` ADD COLUMN light_motor_vechicle_issue_date DATE ;

ALTER TABLE `posts` ADD COLUMN `post_code` VARCHAR(1) NOT NULL AFTER `active`;

UPDATE `posts` SET `post_code` = 'A' WHERE `post_id` = '1';
UPDATE `posts` SET `post_code` = 'B' WHERE `post_id` = '2';
UPDATE `posts` SET `post_code` = 'C' WHERE `post_id` = '3';
UPDATE `posts` SET `post_code` = 'D' WHERE `post_id` = '4';
UPDATE `posts` SET `post_code` = 'E' WHERE `post_id` = '5';
UPDATE `posts` SET `post_code` = 'F' WHERE `post_id` = '6';
UPDATE `posts` SET `post_code` = 'G' WHERE `post_id` = '7';
UPDATE `posts` SET `post_code` = 'H' WHERE `post_id` = '8';
UPDATE `posts` SET `post_code` = 'I' WHERE `post_id` = '9';
UPDATE `posts` SET `post_code` = 'J' WHERE `post_id` = '10';
UPDATE `posts` SET `post_code` = 'K' WHERE `post_id` = '11';
UPDATE `posts` SET `post_code` = 'L' WHERE `post_id` = '12';
UPDATE `posts` SET `post_code` = 'M' WHERE `post_id` = '13';
UPDATE `posts` SET `post_code` = 'N' WHERE `post_id` = '14';
UPDATE `posts` SET `post_code` = 'O' WHERE `post_id` = '15';
UPDATE `posts` SET `post_code` = 'P' WHERE `post_id` = '16';
UPDATE `posts` SET `post_code` = 'Q' WHERE `post_id` = '17';
UPDATE `posts` SET `post_code` = 'R' WHERE `post_id` = '18';
UPDATE `posts` SET `post_code` = 'S' WHERE `post_id` = '19';
UPDATE `posts` SET `post_code` = 'T' WHERE `post_id` = '20';
ALTER TABLE `applicant_post_assoc` ADD COLUMN `apprenticeship_in_msrtc` TINYINT NULL AFTER `differently_abled_others_text`;
ALTER TABLE `applicant_post_assoc` ADD COLUMN `apprenticeship_in_msrtc_trade` TINYINT NULL AFTER `apprenticeship_in_msrtc`;
ALTER TABLE `applicant_post_assoc` ADD COLUMN `apprenticeship_in_msrtc_year` TINYINT NULL AFTER `apprenticeship_in_msrtc_trade`;
ALTER TABLE `applicant_post_assoc` ADD COLUMN `apprenticeship_in_msrtc_division` TINYINT NULL AFTER `apprenticeship_in_msrtc_year`;

/* set verify otp */
ALTER TABLE `applicants` ADD COLUMN verify_otp TINYINT(1);