ALTER TABLE `queries` ADD COLUMN `add_attachment` VARCHAR(250) NULL AFTER `last_modified_date`; 

ALTER TABLE `replies` CHANGE `STATUS` `status` TINYINT(1) DEFAULT 1 NULL, ADD COLUMN `add_attachment` VARCHAR(250) NULL AFTER `status`;

UPDATE `module_operations` SET `module_operation_name` = 'newApplicantQuery,saveApplicantQuery,viewAddedAttachment' WHERE `module_operation_id` = '92'; 

UPDATE `module_operations` SET `module_operation_name` = 'editApplicantQuery,saveApplicantQuery,viewAddedAttachment' WHERE `module_operation_id` = '94';

INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES ('32', 'viewAddedAttachment, viewReplyAttachment, downloadReplyAttachment, downloadAddedAttachment', 'View Added-Download, Reply-Download &  Attachment', '3');
INSERT INTO `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) VALUES ('32', '2', '32'); 
INSERT INTO `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) VALUES ('33', '1', '32');

UPDATE post_division_assoc SET active = '0' WHERE id = '94'; 
UPDATE post_division_assoc SET active = '0' WHERE id = '95'; 
UPDATE post_division_assoc SET active = '0' WHERE id = '96'; 
UPDATE post_division_assoc SET active = '0' WHERE id = '129'; 
UPDATE post_division_assoc SET active = '0' WHERE id = '130'; 
UPDATE post_division_assoc SET active = '0' WHERE id = '131';

INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('132', '21', '15'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('133', '21', '20'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('134', '21', '23'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('135', '21', '24'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('136', '21', '27'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('137', '21', '29');

TRUNCATE TABLE trades;
ALTER TABLE trades ADD COLUMN trade_order INT(11) NULL AFTER message_key, ADD COLUMN active TINYINT(1) DEFAULT 1 NOT NULL AFTER trade_order; 

INSERT INTO trades (id, title, message_key, trade_order) VALUES ('1', 'Motor Mechanic /  Diesel Mechanic', 'trade.motor.diesel.mechanic', '1'); 
INSERT INTO trades (id, title, message_key, trade_order) VALUES ('2', 'Sheet Metal Worker', 'trade.sheet.metal.worker', '2'); 
INSERT INTO trades (id, title, message_key, trade_order) VALUES ('3', 'Auto Electrician (DC)', 'trade.auto.electrician.dc', '3'); 
INSERT INTO trades (id, title, message_key, trade_order) VALUES ('4', 'Blacksmith welder / Tinsmith / Welder', 'trade.blacksmith.tinsmith.welder', '4'); 
INSERT INTO trades (id, title, message_key, trade_order) VALUES ('5', 'Painter', 'trade.painter', '5'); 
INSERT INTO trades (id, title, message_key, trade_order) VALUES ('6', 'Mechanical Equipment', 'trade.mechanical.equipment', '6'); 
INSERT INTO trades (id, title, message_key, trade_order) VALUES ('7', 'Refrigeration and Air Conditioning', 'trade.refrigeration.ac', '7'); 
INSERT INTO trades (id, title, message_key, trade_order) VALUES ('8', 'Tyre fitter', 'trade.tyre.fitter', '8'); 