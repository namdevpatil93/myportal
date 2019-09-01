ALTER TABLE applicants ADD COLUMN is_belong_to_ews TINYINT(1) NULL AFTER drought_Affected; 

 ALTER TABLE applicants ADD COLUMN ews_certificate_number VARCHAR(250) NULL AFTER is_belong_to_ews; 
 
 INSERT INTO castes(id,caste_title,message_key,post_fees,caste_order) VALUES ( 11,'E.W.S.','caste.ews','500','11'); 