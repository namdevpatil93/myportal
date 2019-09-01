ALTER TABLE applicants ADD COLUMN highest_qualification BIGINT(15) NULL AFTER child_of_farmer_who_committed_suicide; 
UPDATE system_settings SET value='<p>Hello</p><br><p>Please find attached challan file.</p><p><span>Warm Regards,</span><br/><br/>Recruitment Cell<br/>MSRTC</p>' WHERE id='23'; 
UPDATE system_settings SET value='<p>Hello</p><br><p>Please find attached report.</p><p><span>Warm Regards,</span><br/><br/>Recruitment Cell<br/>MSRTC</p>' WHERE id='29'; 
INSERT INTO system_settings(id,description,modified_time,value) VALUES ( '30','Enable Automatic Report Email','2018-04-17 09:20:32','0');

INSERT INTO system_settings(id,description,modified_time,value) VALUES ( '31','Email Report Cron Value','2018-04-17 09:20:32','0 0 0 * * *');
CREATE TABLE `document_category`( `id` INT(11) NOT NULL AUTO_INCREMENT , `category_title` VARCHAR(255) NOT NULL , `category_title_marathi` VARCHAR(255) NOT NULL , `document_type` BIGINT(20) NOT NULL , `active` TINYINT(1) NOT NULL DEFAULT '0' , `created_by` BIGINT(20) NOT NULL , `created_date` DATETIME NOT NULL , `last_modified_by` INT(11) NOT NULL , `last_modified_date` DATETIME NOT NULL , PRIMARY KEY (`id`) ) ENGINE='Default' COMMENT='' ROW_FORMAT=DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ; 

INSERT INTO `module_operations`(`module_operation_id`,`module_operation_name`,`display_name`,`module_id`) VALUES ( '111','categoryList','category','6'); 

UPDATE `module_operations` SET `module_operation_name`='categoryList,saveCategory,newCategory,changeCategoryStatus,editCategory,deleteDocumentCategory' WHERE `module_operation_id`='111'; 


 

INSERT INTO `role_module_operation_assoc`(`role_module_operation_id`,`role_id`,`module_operation_id`) VALUES ( NULL,'3','111'); 




CREATE TABLE `document_subcategory` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `document_type` BIGINT(20) NOT NULL,
  `category_type` BIGINT(20) NOT NULL,
  `subcategory_title` VARCHAR(255) NOT NULL,
  `subcategory_title_marathi` VARCHAR(255) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '0',
  `created_by` BIGINT(20) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `last_modified_by` BIGINT(20) NOT NULL,
  `last_modified_date` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8

INSERT INTO `module_operations`(`module_operation_id`,`module_operation_name`,`display_name`,`module_id`) VALUES ( NULL,'subCategoryList','Sub Category','6'); 

UPDATE `module_operations` SET `module_operation_name`='subCategoryList,saveSubCategory,newSubCategory,editSubCategory,documentSubCategoryfetch' WHERE `module_operation_id`='112'; 
INSERT INTO `role_module_operation_assoc`(`role_module_operation_id`,`role_id`,`module_operation_id`) VALUES ( NULL,'3','112'); 


INSERT INTO `module_operations`(`module_operation_id`,`module_operation_name`,`display_name`,`module_id`) VALUES ( NULL,'deleteDocumentSubCategory','Sub Category','6'); 
  UPDATE `module_operations` SET `module_operation_name`='deleteDocumentSubCategory,changeSubCategoryStatus' WHERE `module_operation_id`='113';
INSERT INTO `role_module_operation_assoc`(`role_module_operation_id`,`role_id`,`module_operation_id`) VALUES ( NULL,'3','113'); 
 



ALTER TABLE `documents` ADD COLUMN `category_type` bigint(20) DEFAULT '0' AFTER `document_name_mr`, ADD COLUMN `sub_category_type` bigint(20) DEFAULT '0' AFTER `category_type`; 

INSERT INTO `module_operations`(`module_operation_id`,`module_operation_name`,`display_name`,`module_id`) VALUES ( NULL,'documentSubCategoryfetchById','Documents category/subcategory','6'); 

 INSERT INTO `role_module_operation_assoc`(`role_module_operation_id`,`role_id`,`module_operation_id`) VALUES ( NULL,'3','114'); 


