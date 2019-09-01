ALTER TABLE `applicant_post_assoc` ADD COLUMN is_second_class_in_mba TINYINT(1) NULL AFTER `knowledge_board_meetings_acts`;
ALTER TABLE `applicant_post_assoc` ADD COLUMN `post_graduate_degree_science` TINYINT(1) NULL AFTER `is_first_class_degree`;
ALTER TABLE `applicant_other_information` ADD COLUMN `locomotor_or_cerebralpalsy` TINYINT(1) NULL AFTER `orphaned_person`;
ALTER TABLE `applicant_other_information` ADD COLUMN `deaf_and_mute` TINYINT(1) NULL AFTER `locomotor_or_cerebralpalsy`;