/*Inserted new trades */
INSERT INTO trades (`id`, `title`, `message_key`) VALUES ('6', 'Wireman', 'trade.wireman'); 
INSERT INTO trades (`id`, `title`, `message_key`) VALUES ('7', 'Blacksmith', 'trade.blacksmith'); 
INSERT INTO trades (`id`, `title`, `message_key`) VALUES ('8', 'Mechanical equipment', 'trade.mechanical.equipment'); 
INSERT INTO trades (`id`, `title`, `message_key`) VALUES ('9', 'Mechanical (Cooling & A.C.)', 'trade.mechanical.cooling.ac'); 
INSERT INTO trades (`id`, `title`, `message_key`) VALUES ('10', 'Diesel Mechanic', 'trade.diesel.mechanic'); 
INSERT INTO trades (`id`, `title`, `message_key`) VALUES ('11', 'Machinist', 'trade.machinist'); 
INSERT INTO trades (`id`, `title`, `message_key`) VALUES ('12', 'Turner', 'trade.turner'); 
INSERT INTO trades (`id`, `title`, `message_key`) VALUES ('13', 'Carpenter', 'trade.carpentar'); 
ALTER TABLE `applicant_post_assoc` ADD COLUMN fifteen_year_exp_in_commerce TINYINT(1);

ALTER TABLE `applicant_post_assoc` ADD COLUMN `learning_license` TINYINT(1) NULL AFTER `light_motor_vechicle_issue_date`, ADD COLUMN `learning_license_no` VARCHAR(30) NULL AFTER `learning_license`, ADD COLUMN `learning_license_issue_date` DATE NULL AFTER `learning_license_no`; 