ALTER TABLE `payment_transactions` ADD INDEX `payment_mode` (`payment_mode`);
ALTER TABLE `payment_transactions` ADD INDEX `status` (`status`);
ALTER TABLE `payment_transactions` ADD INDEX `order_no` (`order_no`);
ALTER TABLE `payment_transactions` ADD INDEX `applicant_id` (`applicant_id`);

ALTER TABLE `applicant_post_assoc` ADD INDEX `post_id` (`post_id`);
ALTER TABLE `applicant_post_assoc` ADD INDEX `txn_order_no` (`txn_order_no`);
ALTER TABLE `applicant_post_assoc` ADD INDEX  `applicant_id` (`applicant_id`);

