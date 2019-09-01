ALTER TABLE `castes` CHANGE `post_fees` `post_fees` INT(11) DEFAULT '300' NOT NULL; 
UPDATE `castes` SET `post_fees`='600' WHERE `id`='1'; 
 UPDATE `castes` SET `post_fees`='300' WHERE `id`='2'; 
 UPDATE `castes` SET `post_fees`='300' WHERE `id`='3'; 
 UPDATE `castes` SET `post_fees`='300' WHERE `id`='4'; 
 UPDATE `castes` SET `post_fees`='300' WHERE `id`='5'; 
 UPDATE `castes` SET `post_fees`='300' WHERE `id`='6'; 
 UPDATE `castes` SET `post_fees`='300' WHERE `id`='7'; 
 UPDATE `castes` SET `post_fees`='300' WHERE `id`='8'; 
 UPDATE `castes` SET `post_fees`='300' WHERE `id`='9'; 
 
 INSERT INTO `castes`(`id`,`caste_title`,`message_key`,`post_fees`,`caste_order`) VALUES ( 10,'S.E.B.C ( Maratha)','caste.maratha','300','10'); 