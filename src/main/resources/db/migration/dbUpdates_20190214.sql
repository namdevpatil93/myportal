ALTER TABLE applicant_post_assoc ADD COLUMN post_graduate_degree_name VARCHAR(50) NULL AFTER advt_no; 

ALTER TABLE applicant_post_assoc ADD COLUMN post_graduate_marks FLOAT NULL AFTER post_graduate_degree_name; 

ALTER TABLE applicant_post_assoc ADD COLUMN management_experience TINYINT(1) NULL AFTER post_graduate_marks; 

ALTER TABLE applicant_post_assoc ADD COLUMN is_large_office_and_large_staff_members TINYINT(1) NULL AFTER management_experience; 

ALTER TABLE applicant_post_assoc ADD COLUMN knowledge_board_meetings_acts TINYINT(1) NULL AFTER is_large_office_and_large_staff_members;