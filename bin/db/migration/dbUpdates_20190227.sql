INSERT INTO `post_super_category`(`id`,`super_category_title`,`message_key`,`super_category_order`) VALUES ( '5','Officers','post.super.category.officer','5'); 

INSERT INTO `post_category`(`id`,`category_title`,`message_key`,`post_super_category`) VALUES ( '6','Technical','post.technical','5'); 
INSERT INTO `post_category`(`id`,`category_title`,`message_key`,`post_super_category`) VALUES ( '7','Non-Technical','post.nontechnical','5'); 



UPDATE `posts` SET `post_type`='6' WHERE `post_id`='23'; 
UPDATE `posts` SET `post_type`='7' WHERE `post_id`='24'; 
UPDATE `posts` SET `post_type`='6' WHERE `post_id`='25'; 
UPDATE `posts` SET `post_type`='7' WHERE `post_id`='26'; 
UPDATE `posts` SET `post_type`='7' WHERE `post_id`='27'; 
UPDATE `posts` SET `post_type`='7' WHERE `post_id`='28'; 
UPDATE `posts` SET `post_type`='6' WHERE `post_id`='29'; 
UPDATE `posts` SET `post_type`='7' WHERE `post_id`='30'; 
UPDATE `posts` SET `post_type`='7' WHERE `post_id`='31'; 