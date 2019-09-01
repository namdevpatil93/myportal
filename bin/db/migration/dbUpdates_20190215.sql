ALTER TABLE `applicant_post_assoc` ADD COLUMN `mba_degree_name` VARCHAR(50) NULL AFTER `knowledge_Board_meetings_acts`, ADD COLUMN `mba_university` VARCHAR(100) NULL AFTER `mba_degree_name`, ADD COLUMN `mba_marks` FLOAT NULL AFTER `mba_university`, ADD COLUMN `is_icwa_diploma` TINYINT(1) NULL AFTER `mba_marks`, ADD COLUMN `icwa_diploma_name` VARCHAR(50) NULL AFTER `is_icwa_diploma`, ADD COLUMN `icwa_university_name` VARCHAR(100) NULL AFTER `icwa_diploma_name`, ADD COLUMN `icwa_marks` FLOAT NULL AFTER `icwa_university_name`, ADD COLUMN `is_first_class_degree` TINYINT(1) NULL AFTER `icwa_marks`; 

ALTER TABLE `applicant_post_assoc` CHANGE `post_graduate_marks` `post_graduate_marks` FLOAT DEFAULT '0' NULL , CHANGE `mba_marks` `mba_marks` FLOAT DEFAULT '0' NULL , CHANGE `icwa_marks` `icwa_marks` FLOAT DEFAULT '0' NULL ; 

UPDATE `applicant_post_assoc` SET `applicant_post_assoc`.`post_graduate_marks`='0',`applicant_post_assoc`.`mba_marks`='0',`applicant_post_assoc`.`icwa_marks`='0'

UPDATE `castes` SET `post_fees`='1000' WHERE `id`='1'; 
 UPDATE `castes` SET `post_fees`='500' WHERE `id`='2'; 
 UPDATE `castes` SET `post_fees`='500' WHERE `id`='3'; 
 UPDATE `castes` SET `post_fees`='500' WHERE `id`='4'; 
 UPDATE `castes` SET `post_fees`='500' WHERE `id`='5'; 
 UPDATE `castes` SET `post_fees`='500' WHERE `id`='6'; 
 UPDATE `castes` SET `post_fees`='500' WHERE `id`='7'; 
 UPDATE `castes` SET `post_fees`='500' WHERE `id`='8'; 
 UPDATE `castes` SET `post_fees`='500' WHERE `id`='9'; 
 UPDATE `castes` SET `post_fees`='500' WHERE `id`='10'; 
 
ALTER TABLE posts ADD COLUMN post_last_date_of_application VARCHAR(10) NULL AFTER show_user_response;
