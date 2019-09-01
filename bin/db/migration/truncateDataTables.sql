/*
 * Any new data table to be truncated needs to be placed between the foreign key check queries. 
 *Also please keep in mind the order of tables i.e. the child tables need to be truncated first befor the parent tables. 
 *
 **/

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE `advertisements`;
TRUNCATE TABLE `applicant_files`;
TRUNCATE TABLE `applicant_other_information`;
TRUNCATE TABLE `applicant_otps`;
TRUNCATE TABLE `applicant_post_assoc`;
TRUNCATE TABLE `applicants`;
TRUNCATE TABLE `challan_files`;
TRUNCATE TABLE `challans`;
TRUNCATE TABLE `change_password_requests`;
TRUNCATE TABLE `documents`;
TRUNCATE TABLE `payment_transactions`;
TRUNCATE TABLE `sms_sent_history`;

TRUNCATE TABLE `queries`;
TRUNCATE TABLE `user_notifications`;
TRUNCATE TABLE `notifications`;
TRUNCATE TABLE `replies`;

SET FOREIGN_KEY_CHECKS = 1;
