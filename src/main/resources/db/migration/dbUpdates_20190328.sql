UPDATE module_operations SET module_operation_name='onlineQueryApi, submitQuery, changeStatus, submitQueryList' WHERE module_operation_id='30'; 

INSERT INTO system_settings(id,description,modified_time,value) VALUES ( '37','Enable Automatic Payment Report','2019-03-14 03:07:32','0'); 
INSERT INTO system_settings(id,description,modified_time,value) VALUES ( '33','Payment Report Email Ids','2019-03-14 03:07:32','ashish.meshram@sts.in, diwanshu.tiwari@sts.in ,pradeep.tiwari@sts.in'); 
INSERT INTO system_settings(id,description,modified_time,value) VALUES ( '34','Payment Report Email Subject','2019-03-14 03:07:32','Payment Transaction Report'); 
INSERT INTO system_settings(id,description,modified_time,value) VALUES ( '35','Payment Report Cron Value','2019-03-14 03:07:32','0 0 2 * * *'); 

INSERT INTO system_settings(id,description,modified_time,value) VALUES ( '36','Payment Report Email Body','2019-03-14 03:07:32','<p>Hello</p><br><p>Please find attached report.</p><p><span>Warm Regards,</span><br/><br/>Recruitment Cell<br/>MSRTC</p>'); 

INSERT INTO `system_settings`(`id`,`description`,`modified_time`,`value`) VALUES ( '38','Start Date for Report Generation','2019-03-29 12:15:30','20/02/2019'); 
