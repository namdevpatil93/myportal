ALTER TABLE `applicants` CHANGE verify_otp mobile_no_verified TINYINT(1);

INSERT INTO `system_settings` (`id`, `value`, `description`, `modified_time`)
	VALUES (11, '26/12/2016', 'Age validation between fixedDate and dateOfBirth', NOW());
	
ALTER TABLE `applicants` CHANGE verify_otp mobile_no_verified TINYINT(1);

ALTER TABLE `applicant_post_assoc` MODIFY `apprenticeship_in_msrtc_trade` VARCHAR(100);
ALTER TABLE `applicant_post_assoc` MODIFY `apprenticeship_in_msrtc_year` VARCHAR(100);
ALTER TABLE `applicant_post_assoc` MODIFY `apprenticeship_in_msrtc_division` VARCHAR(100);

UPDATE `posts` SET `post_code` = 'U' WHERE `post_id` = '21';

INSERT  INTO `module_operations`(`module_operation_id`,`module_operation_name`,`display_name`,`module_id`) 
VALUES (75,'findDisabledPost','Find Disabled Post',2);
INSERT  INTO `role_module_operation_assoc`(`role_module_operation_id`,`role_id`,`module_operation_id`) VALUES (78,2,75);