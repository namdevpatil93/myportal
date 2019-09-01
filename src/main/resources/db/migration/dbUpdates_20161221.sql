ALTER TABLE applicants CHANGE pin_code pin_code VARCHAR(11) NOT NULL;

/* added new column in applicationpostassociation table */
ALTER TABLE `applicant_post_assoc` ADD COLUMN differently_abled_others TINYINT(1) ;
ALTER TABLE `applicant_post_assoc` ADD COLUMN differently_abled_others_text VARCHAR(100) ;