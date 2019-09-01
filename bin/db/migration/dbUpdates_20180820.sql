ALTER TABLE applicants ADD COLUMN certificate_number VARCHAR(250) NULL AFTER highest_qualification;
ALTER TABLE applicants ADD COLUMN allocated_category INT(11) NULL AFTER certificate_number; 