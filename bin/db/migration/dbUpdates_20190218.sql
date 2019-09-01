 ALTER TABLE applicant_post_assoc ADD COLUMN organisation_time_from DATE NULL AFTER post_graduate_degree_science, ADD COLUMN organisation_time_to DATE NULL AFTER organisation_time_from; 

ALTER TABLE applicant_post_assoc ADD COLUMN company_address VARCHAR(50) NULL AFTER organisation_time_to; 