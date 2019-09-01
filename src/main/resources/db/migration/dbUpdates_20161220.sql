/*Add marathi columns for first, middle and last names*/

ALTER TABLE applicants ADD COLUMN first_name_marathi VARCHAR(255) NOT NULL AFTER district_id, ADD COLUMN middle_name_marathi VARCHAR(255) NOT NULL AFTER first_name_marathi, ADD COLUMN last_name_marathi VARCHAR(255) NOT NULL AFTER middle_name_marathi; 