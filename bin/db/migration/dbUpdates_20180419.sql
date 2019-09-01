INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`)
VALUES ('110','showResetApplicantPassword, resetApplicantPassword', 'Reset Applicant Password', '1');

INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '110');
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('3', '110');

