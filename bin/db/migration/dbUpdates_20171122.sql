UPDATE `module_operations` SET `module_operation_name` = 'applicantAttachmentDownloadForm, downloadApplicantFormsZip' WHERE `module_operation_id` = '105';

CREATE TABLE `applicant_forms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `post_id` int(11) NOT NULL,
  `location` varchar(255) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
);
