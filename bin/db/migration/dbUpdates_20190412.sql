INSERT INTO `system_settings`(`id`,`description`,`modified_time`,`value`) VALUES ( '44','Start Date Of Edit Window','2019-04-08 15:30:00','20/04/2019'); 
INSERT INTO `system_settings`(`id`,`description`,`modified_time`,`value`) VALUES ( '45','End Date Of Edit Window','2019-04-08 15:30:00','21/04/2019'); 

UPDATE `posts` SET `post_last_date_of_application` = '18/04/2019' WHERE `post_id` BETWEEN 1 AND 31;