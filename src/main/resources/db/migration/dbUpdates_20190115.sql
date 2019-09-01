ALTER TABLE divisions ADD COLUMN is_drought_affected TINYINT(1) NULL AFTER division_order; 

ALTER TABLE districts DROP COLUMN is_drought_affected; 