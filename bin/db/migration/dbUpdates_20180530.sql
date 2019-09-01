INSERT INTO system_settings(id,description,modified_time,value) VALUES ( '21','Challan Email Subject','2018-04-17 09:20:32','Sample Subject'); 

INSERT INTO system_settings(id,description,modified_time,value) VALUES ( '22','Challan Email Ids','2018-04-17 09:20:32','diwanshu.tiwari@sts.in, diwanshutiwar94@gmail.com'); 

INSERT INTO system_settings(id,description,modified_time,value) VALUES ( '23','Challan Email Body','2018-04-17 09:20:32','<p>Hello</p><br><p>asas hgadfj aghfhjasdg hjgafh jhgf</p><p><span>Warm Regards,</span><br/><br/>Recruitment Cell<br/>MSRTC</p>'); 

INSERT INTO system_settings(id,description,modified_time,VALUE) VALUES ( '24','Enable Automatic Email','2018-04-17 09:20:32','1'); 

INSERT INTO system_settings(id,description,modified_time,value) VALUES ( '25','Email Cron Value','2018-04-17 09:20:32','1 0 0 * * *'); 

INSERT INTO system_settings(id,description,modified_time,VALUE) VALUES ( '26','Start Date Of Registration','2018-04-17 09:20:32','21/02/2019'); 

INSERT INTO system_settings(id,description,modified_time,VALUE) VALUES ( '27','Application Report Email Ids','2018-04-17 09:20:32','diwanshu.tiwari@sts.in,diwanshutiwar94@gmail.com'); 

INSERT INTO system_settings(id,description,modified_time,VALUE) VALUES ( '28','Report Email Subject','2018-04-17 09:20:32','Report Subject'); 

INSERT INTO system_settings(id,description,modified_time,VALUE) VALUES ( '29','Report Email Body','2018-04-17 09:20:32','<p>Hello</p><br><p>asas hgadfj aghfhjasdg hjgafh jhgf</p><p><span>Warm Regards,</span><br/><br/>Recruitment Cell<br/>MSRTC</p>');

UPDATE module_operations SET module_operation_name = 'showUploadChallan, saveChallan, downloadChallanData, showPostPaymentCount' WHERE module_operation_id = '22'; 