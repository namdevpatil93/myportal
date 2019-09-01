ALTER TABLE replies ADD COLUMN STATUS TINYINT(1) DEFAULT '1';

ALTER TABLE `sms_sent_history` CHANGE `sms_type` `sms_type` VARCHAR(100);