ALTER TABLE `applicant_post_assoc` ADD COLUMN `grad_or_post_grad` INT(1) DEFAULT 0 NULL AFTER `other_qualification`, ADD COLUMN `institute_name` VARCHAR(100) NULL AFTER `grad_or_post_grad`, ADD COLUMN `work_exp` INT DEFAULT 0 NULL AFTER `institute_name`, ADD COLUMN `post_name` VARCHAR(100) NULL AFTER `work_exp`, ADD COLUMN `dc_division_id` INT NULL AFTER `post_name`;

