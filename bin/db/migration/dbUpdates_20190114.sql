ALTER TABLE applicants ADD COLUMN drought_Affected TINYINT(1) NULL AFTER allocated_category;

ALTER TABLE districts ADD COLUMN is_drought_affected TINYINT(1) NULL AFTER district_order; 

ALTER TABLE applicant_other_information ADD COLUMN orphaned_person TINYINT(1) NULL AFTER city_id_third_preference; 