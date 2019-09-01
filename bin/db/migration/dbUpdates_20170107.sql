ALTER TABLE applicants CHANGE first_name_marathi first_name_marathi VARCHAR(255) CHARSET utf8 COLLATE utf8_unicode_ci NULL, CHANGE middle_name_marathi middle_name_marathi VARCHAR(255) CHARSET utf8 COLLATE utf8_unicode_ci NULL, CHANGE last_name_marathi last_name_marathi VARCHAR(255) CHARSET utf8 COLLATE utf8_unicode_ci NULL;


ALTER TABLE `challans` 
ADD COLUMN `tran_mode` VARCHAR(255) NULL AFTER `created_date`, 
ADD COLUMN `from_account_sys` VARCHAR(255) NULL AFTER `tran_mode`, 
ADD COLUMN `from_acct_no` VARCHAR(255) NULL AFTER `from_account_sys`, 
ADD COLUMN `post_applied` VARCHAR(255) NULL AFTER `from_acct_no`, 
ADD COLUMN `category` VARCHAR(255) NULL AFTER `post_applied`, 
ADD COLUMN `last_date_for_acceptance` VARCHAR(255) NULL AFTER `category`, 
ADD COLUMN `dob` VARCHAR(255) NULL AFTER `last_date_for_acceptance`;

ALTER TABLE `challans` CHANGE `amount` `amount` VARCHAR(255) NULL;