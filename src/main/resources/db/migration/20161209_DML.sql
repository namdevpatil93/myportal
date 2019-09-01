/*Data for the table `modules` */

insert  into `modules`(`module_id`,`module_name`,`display_name`,`is_enabled`) values (1,'admin','Admin',1),(2,'applicant','Applicant',1),(3,'file','File',1),(4,'payment','Payment',1);

/*Data for the table `module_operations` */

insert  into `module_operations`(`module_operation_id`,`module_operation_name`,`display_name`,`module_id`) values (1,'adminDashboard','Admin Dashboard',1),(2,'applicantDashboard','Applicant Dashboard',2),(3,'changePassword','Change Password',2),(4,'viewProfile','View Profile',2),(5,'apply','Apply',2),(6,'showPersonalInformation, savePersonalInformation','Save Personal Information',2),(7,'showOtherInformation, saveOtherInformation','Show Other Information',2),(8,'showPostSelection, showSelectedPosts, savePostSelection, savePostPriority','Show Post Selection',2),(9,'showApplicantFiles, saveApplicantFiles','Show Applicant Files',2),(10,'saveApplicantPostDetails','Save Applicant Post Details',2),(11,'deleteApplicantPost','Delete Applicant Post',2),(12,'viewPhoto, viewSignature','View Photo',3),(13,'showConfirmation','Show Confirmation',2),(14,'viewPostDetails','View Post Details',2),(15,'viewExperienceLetter','To View Experience Letter',3),(16,'validateSubmission','Check If Valid Application Submission',2),(17,'showPayment, makePayment','Show Payment',4),(18,'myAccount','My Account',2),(19,'verifyOTP, resendOTP','Verify OTP',2),(20,'applicantsPostAssocList, downloadApplicantPostAssocCSV','Applicant Post Assoc List',1);

/*Data for the table `roles` */

insert  into `roles`(`id`,`title`,`description`,`is_enabled`,`is_system_defined`,`parent_role_id`) values (1,'Admin','Admin',1,1,1),(2,'Applicant','Applicant',1,1,2);

/*Data for the table `role_module_operation_assoc` */

insert  into `role_module_operation_assoc`(`role_module_operation_id`,`role_id`,`module_operation_id`) values (1,1,1),(2,1,20),(3,2,2),(4,2,3),(5,2,4),(6,2,5),(7,2,6),(8,2,7),(9,2,8),(10,2,9),(11,2,10),(12,2,11),(13,2,12),(14,2,13),(15,2,14),(16,2,15),(17,2,16),(18,2,17),(19,2,18),(20,2,19);

/*Data for the table `users` */

insert  into `users`(`id`,`first_name`,`last_name`,`email`,`password`,`created_by`,`created_date`,`last_modified_by`,`last_modified_date`,`role_id`) values (1,'Admin','Admin','admin@admin.com','vQ10N+kETU5GKMqo/c9gxNH89gh75M0CHn74o7qxuhWHKiDlCSAMHl8GFEdZUJNo',1,'2016-10-05 20:41:02',1,'2016-10-05 20:41:05',1);

/*Data for the table `castes` */

insert  into `castes`(`id`,`caste_title`,`message_key`,`post_fees`) values (1,'Open','caste.open',500),(2,'O.B.C.','caste.obc',250),(3,'S.T.','caste.st',250),(4,'S.C.','caste.sc',250),(5,'VJ-A','caste.vja',250),(6,'NT-B','caste.ntb',250),(7,'NT-C','caste.ntc',250),(8,'NT-D','caste.ntd',250),(9,'S.B.C','caste.sbc',250);

/*Data for the table `cities` */

/*Data for the table `districts` */

/*Data for the table `divisions` */

insert  into `divisions`(`division_id`,`division_title`,`message_key`) values (1,'Ahmad Nagar','division.ahmadnagar'),(2,'Akola','division.akola'),(3,'Amaravati','division.amaravati'),(4,'Aurangabad','division.aurangabad'),(5,'Beed','division.beed'),(6,'Bhandara','division.bhanadara'),(7,'BulDhana','division.bulDhana'),(8,'Chandrapur','division.chandrapur'),(9,'Dhule','division.dhule'),(10,'Gadchiroli','division.gadchiroli'),(11,'Jalgaon','division.jalgaon'),(12,'Jalna','division.jalna'),(13,'Kolhapur','division.kolhapur'),(14,'Latur','division.latur'),(15,'Mumbai City','division.mumbaiCity'),(16,'Mumbai Suburb','division.mumbaisuburb'),(17,'Nagpur','division.nagpur'),(18,'Nanded','division.nanded'),(19,'Nashik','division.nashik'),(20,'Palghar','division.palghar'),(21,'Parbhani','division.parbhani'),(22,'Pune','division.pune'),(23,'Raigad','division.raigad'),(24,'Ratnagiri','division.ratnagiri'),(25,'Sangli','division.sangli'),(26,'Satara','division.satara'),(27,'Sindhudurg','division.sindhudurg'),(28,'Solapur','division.solapur'),(29,'Thane','division.thane'),(30,'Usmanabad','division.usmanabad'),(31,'Vardha','division.vardha'),(32,'Yavatmal','division.yavatmal');

/*Data for the table `post_super_category` */

insert  into `post_super_category`(`id`,`super_category_title`,`message_key`,`super_category_order`) values (1,'Others','post.super.category.others',3),(2,'Supervisor','post.super.category.supervisor',2),(3,'Manager','post.super.category.manager',1);

/*Data for the table `post_category` */

insert  into `post_category`(`id`,`category_title`,`message_key`,`post_super_category`) values (1,'Unit Category Post','post.unit.category',1),(2,'Technical','post.technical',2),(3,'Non-Technical','post.nontechnical',2),(4,'Manager','post.manager',3);

/*Data for the table `posts` */

insert  into `posts`(`post_id`,`post_title`,`message_key`,`post_type`,`post_order`) values (1,'Driver(Junior)','post.driver.junior',1,1),(2,'Conductor(Junior)','post.conductor.junior',1,2),(3,'Clerk Typist(Junior)','post.clerk.typist.junior',1,3),(4,'Assistant(Junior)	','post.assistant.junior',1,4),(5,'Assistant Traffic Superintendent (Jr.)','post.assistant.traffic.superitendent.junior',3,13),(6,'Trafic Inspector (Jr.)','post.traffic.inspector.junior',3,14),(7,'Accountnt /Jr.Stock verifier (Jr.)','post.accountant.jrstock.verifier.junior',3,15),(8,'Store supervisor /Sr. Stock Verifier (Jr.)','post.storesupervisor.srstock.verifier.junior',3,16),(9,'Store Keeper (Jr.)','post.store.keeper.junior',3,17),(10,'Security Inspector (Jr.)','post.security.inspector.junior',3,18),(11,'Asst. Security inspector (Jr.)','post.assistant.security.inspector.junior',3,19),(12,'Firewarden (Jr.)','post.firewarden.junior',3,20),(13,'Junior Engineer(Civil) (Jr.)','post.junoirengineer.civil.junior',2,7),(14,'Jr.Engineer(Electrical) (Jr.)','post.junoirengineer.electrical.junior',2,8),(15,'Asst. work shop superintendent (Jr.)','post.assistant.workshop.superintendent.junior',2,9),(16,'Chargeman(Jr.)','post.chargeman.junior',2,10),(17,'Draftsman ( Mechanics ) (Jr.)','post.draftsman.junior',2,11),(18,'Sr.Computer Operator(Jr.)','post.senior.computeroperator.junior',2,12),(19,'General Manager (Project)','post.general.manager.project',4,5),(20,'General Manager (Information Technology) ','post.general.manager.project.informationTechnology',4,6);

/*Data for the table `qualification_types` */

insert  into `qualification_types`(`id`,`title`,`message_key`) values (1,'SSC','qualificationType.ssc'),(2,'HSC','qualificationType.hsc'),(3,'Graduate','qualificationType.graduate'),(4,'Post-Graduate','qualificationType.postGraduate');

/*Data for the table `system_settings` */

insert  into `system_settings`(`id`,`description`,`modified_time`,`value`) values (1,'SMS Gupshup Method','2016-11-30 13:57:08','sendMessage'),(2,'SMS Gupshup UserId','2016-11-30 13:57:08','2000123831'),(3,'SMS Gupshup Password','2016-11-30 13:57:08','avinash'),(4,'SMS Gupshup BaseUrl','2016-11-30 13:57:08','http://enterprise.smsgupshup.com/GatewayAPI/rest?'),(5,'SMS Gupshup Message Type','2016-11-30 13:57:08','TEXT'),(6,'SMS Gupshup Auth Scheme','2016-11-30 13:57:08','PLAIN'),(7,'SMS Gupshup Mask(Subject)','2016-11-30 13:57:08','MSRTC'),(8,'SMS Gupshup Version','2016-11-30 13:57:08','1.1'),(9,'Offline payment fees type','2016-12-04 19:30:33','248'),(10,'Offline payment bank charges','2016-12-04 19:30:33','60');

/*Data for the table `trades` */

insert  into `trades`(`id`,`title`,`message_key`) values (1,'Motor mechanic -178','trade.motorMechanic'),(2,'Sheet metal Worker-40','trade.sheetMetalWorker'),(3,'Electrician-28','trade.electrician'),(4,'Painter – 14','trade.painter'),(5,'Welder – 12','trade.welder');

/*Data for the table `cities` */

insert  into cities(id,city_name,message_key) values (1,'Ahmednagar','city.ahmednagar'),(2,'Akola','city.akola'),(3,'Amravati','city.amravati'),(4,'Aurangabad','city.aurangabad'),(5,'Beed','city.beed'),(6,'Bhandara','city.bhandara'),(7,'Buldhana','city.buldhana'),(8,'Chandrapur','city.chandrapur'),(9,'Dhule','city.dhule'),(10,'Gadchiroli','city.gadchiroli'),(11,'Gondia','city.gondia'),(12,'Hingoli','city.hingoli'),(13,'Jalgaon','city.jalgaon'),(14,'Jalna','city.jalna'),(15,'Kalyan','city.kalyan'),(16,'Kolhapur','city.kolhapur'),(17,'Latur','city.latur'),(18,'Mumbai City','city.mumbaicity'),(19,'Nagpur','city.nagpur'),(20,'Nanded','city.nanded'),(21,'Nandurbar','city.nandurbar'),(22,'Nashik','city.nashik'),(23,'Navi Mumbai','city.navimumbai'),(24,'Osmanabad','city.osmanabad'),(25,'Parbhani','city.parbhani'),(26,'Pune','city.pune'),(27,'Raigad','city.raigad'),(28,'Ratnagiri','city.ratnagiri'),(29,'Sangli','city.sangli'),(30,'Satara','city.satara'),(31,'Savada','city.savada'),(32,'Sindhudurg','city.sindhudurg'),(33,'Solapur','city.solapur'),(34,'Telhara','city.telhara'),(35,'Thane','city.thane'),(36,'Tuljapur','city.tuljapur'),(37,'Wardha','city.wardha'),(38,'Washim','city.washim'),(39,'Yavatmal','city.yavatmal');

/*Data for the table `districts` */

insert  into districts(id,name,message_key) values (1,'Ahmednagar','city.ahmednagar'),(2,'Akola','city.akola'),(3,'Amravati','city.amravati'),(4,'Aurangabad','city.aurangabad'),(5,'Beed','city.beed'),(6,'Bhandara','city.bhandara'),(7,'Buldhana','city.buldhana'),(8,'Chandrapur','city.chandrapur'),(9,'Dhule','city.dhule'),(10,'Gadchiroli','city.gadchiroli'),(11,'Gondia','city.gondia'),(12,'Hingoli','city.hingoli'),(13,'Jalgaon','city.jalgaon'),(14,'Jalna','city.jalna'),(15,'Kalyan','city.kalyan'),(16,'Kolhapur','city.kolhapur'),(17,'Latur','city.latur'),(18,'Mumbai City','city.mumbaicity'),(19,'Nagpur','city.nagpur'),(20,'Nanded','city.nanded'),(21,'Nandurbar','city.nandurbar'),(22,'Nashik','city.nashik'),(23,'Navi Mumbai','city.navimumbai'),(24,'Osmanabad','city.osmanabad'),(25,'Parbhani','city.parbhani'),(26,'Pune','city.pune'),(27,'Raigad','city.raigad'),(28,'Ratnagiri','city.ratnagiri'),(29,'Sangli','city.sangli'),(30,'Satara','city.satara'),(31,'Savada','city.savada'),(32,'Sindhudurg','city.sindhudurg'),(33,'Solapur','city.solapur'),(34,'Telhara','city.telhara'),(35,'Thane','city.thane'),(36,'Tuljapur','city.tuljapur'),(37,'Wardha','city.wardha'),(38,'Washim','city.washim'),(39,'Yavatmal','city.yavatmal');

insert into `modules` (`module_id`, `module_name`, `display_name`, `is_enabled`) values('5','challan','Challan','1');
insert into `modules` (`module_id`, `module_name`, `display_name`, `is_enabled`) values('6','documents','Documents','1');

insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('21','viewPreviousUploads, challanList, challanFileList','View Previous Uploads','5');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('22','showUploadChallan, saveChallan','Upload Challans','5');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('23','downloadChallanFile','Download Challan File','3');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('24','documentList','Documents List','6');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('25','newDocument,saveDocument','Create Document','6');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('26','editDocument,saveDocument','Edit Document','6');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('27','deleteDocument','Delete Document','6');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('28','changeStatus','ChangeStatus','6');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('29','allDocuments','All Documents','6');
insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) values('30','onlineQueryApi, submitQuery, changeStatus','Online Query Api','5');

insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('21','1','21');
insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('22','1','22');
insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('24','1','23');
insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('25','1','24');
insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('26','1','25');
insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('27','1','26');
insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('28','1','27');
insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('29','1','28');
insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('30','1','29');
insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('31','1','30');

/* update bank charges 12-12-2016 */
UPDATE `system_settings` SET `value` = 50 WHERE `id` = 10;

/* Update posts to set draftsman post as inactive*/

UPDATE posts SET active = '0' WHERE post_id = '17';

/* update gupshup userid and password and gateway 12-12-2016 */
UPDATE `system_settings` SET `value` = '2000164567' WHERE `id` = 2;
UPDATE `system_settings` SET `value` = 'j7pehBStS' WHERE `id` = 3;
UPDATE `system_settings` SET `value` = 'http://enterprise.smsgupshup.com/GatewayAPI/rest?' WHERE `id` = 4;

INSERT INTO `modules` (`module_id`, `module_name`, `display_name`) VALUES ('7', 'advertisement', 'Advertisement'); 

INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES ('70', 'newAdvertisement,saveAdvertisement', 'Save Advertisement', '7');
INSERT INTO `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) VALUES ('71', '1', '70');

INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES ('71', 'advertisementList', 'Advertisement List', '7');
INSERT INTO `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) VALUES ('72', '1', '71'); 

INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES ('72', 'editAdvertisement,saveAdvertisement', 'Edit Advertisement', '7');
INSERT INTO `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) VALUES ('73', '1', '72'); 

INSERT INTO `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`) VALUES ('73', 'deleteAdvertisement,changeStatus', 'Delete Advertisement', '7');
INSERT INTO `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) VALUES ('74', '1', '73'); 

/* set post order 13-12-2016 */
UPDATE `posts` SET `post_order` = 1 WHERE `post_id` = 19;
UPDATE `posts` SET `post_order` = 2 WHERE `post_id` = 20;
UPDATE `posts` SET `post_order` = 3 WHERE `post_id` = 13;
UPDATE `posts` SET `post_order` = 4 WHERE `post_id` = 14;
UPDATE `posts` SET `post_order` = 5 WHERE `post_id` = 15;
UPDATE `posts` SET `post_order` = 6 WHERE `post_id` = 16;
UPDATE `posts` SET `post_order` = 7 WHERE `post_id` = 18;
UPDATE `posts` SET `post_order` = 8 WHERE `post_id` = 5;
UPDATE `posts` SET `post_order` = 9 WHERE `post_id` = 6;
UPDATE `posts` SET `post_order` = 10 WHERE `post_id` = 7;
UPDATE `posts` SET `post_order` = 11 WHERE `post_id` = 8;
UPDATE `posts` SET `post_order` = 12 WHERE `post_id` = 9;
UPDATE `posts` SET `post_order` = 13 WHERE `post_id` = 10;
UPDATE `posts` SET `post_order` = 14 WHERE `post_id` = 11;
UPDATE `posts` SET `post_order` = 15 WHERE `post_id` = 12;
UPDATE `posts` SET `post_order` = 16 WHERE `post_id` = 1;
UPDATE `posts` SET `post_order` = 17 WHERE `post_id` = 2;
UPDATE `posts` SET `post_order` = 18 WHERE `post_id` = 3;
UPDATE `posts` SET `post_order` = 19 WHERE `post_id` = 4;
UPDATE `posts` SET `post_order` = 20 WHERE `post_id` = 17;
INSERT INTO `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) VALUES ('75', '1', '14'); 

DELETE FROM `divisions` WHERE `division_id` = 16; 

/* 14-12-2016*/
DELETE FROM districts WHERE id = '15'; 
DELETE FROM districts WHERE id = '23'; 
DELETE FROM districts WHERE id = '31'; 
DELETE FROM districts WHERE id = '34'; 
DELETE FROM districts WHERE id = '36'; 
INSERT INTO districts (id, name, message_key) VALUES ('40', 'Palghar', 'city.palghar'); 
UPDATE districts SET name = 'Mumbai' WHERE id = '18'; 

UPDATE castes SET caste_order = '1' WHERE id = '1'; 
UPDATE castes SET caste_order = '2' WHERE id = '4'; 
UPDATE castes SET caste_order = '3' WHERE id = '3'; 
UPDATE castes SET caste_order = '4' WHERE id = '5'; 
UPDATE castes SET caste_order = '5' WHERE id = '6'; 
UPDATE castes SET caste_order = '6' WHERE id = '7'; 
UPDATE castes SET caste_order = '7' WHERE id = '8'; 
UPDATE castes SET caste_order = '8' WHERE id = '9'; 
UPDATE castes SET caste_order = '9' WHERE id = '2';
INSERT INTO cities (id, city_name, message_key) VALUES ('40', 'Palghar', 'city.palghar'); 

INSERT INTO divisions (division_id, division_title, message_key) VALUES ('33', 'Central Workshop (Aurangabad)', 'division.centralworkshop.aurangabad'); 
INSERT INTO divisions (division_id, division_title, message_key) VALUES ('34', 'Central Workshop (Nagpur)', 'division.centralworkshop.nagpur'); 
INSERT INTO divisions (division_id, division_title, message_key) VALUES ('35', 'Central Workshop (Mumbai)', 'division.centralworkshop.mumbai'); 
INSERT INTO divisions (division_id, division_title, message_key) VALUES ('36', 'Central Office (Mumbai)', 'division.centraloffice.mumbai');
 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('1', '1', '1'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('2', '1', '2'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('3', '1', '3'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('4', '1', '4'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('5', '1', '5'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('6', '1', '6'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('7', '1', '7'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('8', '1', '8'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('9', '1', '9'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('10', '1', '10'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('11', '1', '11'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('12', '1', '12'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('13', '1', '13'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('14', '1', '14'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('15', '1', '15'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('16', '1', '17');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('17', '1', '18'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('18', '1', '19');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('19', '1', '20'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('20', '1', '21'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('21', '1', '22'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('22', '1', '23'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('23', '1', '24'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('24', '1', '25'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('25', '1', '26'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('26', '1', '27'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('27', '1', '28'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('28', '1', '29'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('29', '1', '30'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('30', '1', '31'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('31', '1', '32');

INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('32', '2', '1'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('33', '2', '2'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('34', '2', '3'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('35', '2', '4'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('36', '2', '5'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('37', '2', '6'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('38', '2', '7'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('39', '2', '8'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('40', '2', '9'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('41', '2', '10'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('42', '2', '11'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('43', '2', '12'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('44', '2', '13'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('45', '2', '14'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('46', '2', '15'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('47', '2', '17');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('48', '2', '18'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('49', '2', '19');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('50', '2', '20'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('51', '2', '21'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('52', '2', '22'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('53', '2', '23'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('54', '2', '24'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('55', '2', '25'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('56', '2', '26'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('57', '2', '27'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('58', '2', '28'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('59', '2', '29'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('60', '2', '30'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('61', '2', '31'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('62', '2', '32');

INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('63', '3', '1'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('64', '3', '2'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('65', '3', '3'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('66', '3', '4'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('67', '3', '5'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('68', '3', '6'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('69', '3', '7'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('70', '3', '8'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('71', '3', '9'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('72', '3', '10'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('73', '3', '11'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('74', '3', '12'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('75', '3', '13'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('76', '3', '14'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('77', '3', '15'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('78', '3', '17');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('79', '3', '18'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('80', '3', '19');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('81', '3', '20'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('82', '3', '21'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('83', '3', '22'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('84', '3', '23'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('85', '3', '24'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('86', '3', '25'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('87', '3', '26'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('88', '3', '27'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('89', '3', '28'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('90', '3', '29'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('91', '3', '30'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('92', '3', '31'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('93', '3', '32');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('94', '3', '33');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('95', '3', '34');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('96', '3', '35');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('97', '3', '36');

INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('98', '4', '1'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('99', '4', '2'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('100', '4', '3'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('101', '4', '4'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('102', '4', '5'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('103', '4', '6'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('104', '4', '7'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('105', '4', '8'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('106', '4', '9'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('107', '4', '10'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('108', '4', '11'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('109', '4', '12'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('110', '4', '13'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('111', '4', '14'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('112', '4', '15'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('113', '4', '17');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('114', '4', '18'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('115', '4', '19');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('116', '4', '20'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('117', '4', '21'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('118', '4', '22'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('119', '4', '23'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('120', '4', '24'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('121', '4', '25'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('122', '4', '26'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('123', '4', '27'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('124', '4', '28'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('125', '4', '29'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('126', '4', '30'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('127', '4', '31'); 
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('128', '4', '32');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('129', '4', '33');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('130', '4', '34');
INSERT INTO post_division_assoc (id, post_id, division_id) VALUES ('131', '4', '35');

INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES ('1', '12');

UPDATE `divisions` SET `division_title` = 'Ahmednagar' WHERE `division_id` = '1';

/* 20-12-2016  */

INSERT INTO `module_operations` (`module_operation_name`,`display_name`,`module_id`) VALUES ('viewChallan', 'View Challan', 2);
INSERT INTO `role_module_operation_assoc` (`role_id`, `module_operation_id`) VALUES (2,74);
