INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES ('104', 'downloadApplicantAttachment', 'Download Applicant Attachment', '1');
INSERT INTO `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) VALUES (NULL, '3', '104'); 

INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES ('105', 'applicantAttachmentDownloadForm', 'Applicant Attachment Download Form', '1');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('3', '105');

ALTER TABLE `applicant_post_assoc` ADD COLUMN `pdf_generated` TINYINT(1) DEFAULT 0 NULL AFTER `fifteen_year_exp_in_commerce`;
