INSERT INTO roles (id, title, description, is_enabled, is_system_defined, parent_role_id) VALUES ('3', 'Super Admin', 'Super Admin', '1', '1', '1'); 
insert  into role_module_operation_assoc(role_module_operation_id,role_id,module_operation_id) values (101,3,1),(102,3,20),(103,3,21),(104,3,22),(105,3,23),(106,3,24),(107,3,25),(108,3,26),(109,3,27),(110,3,28),(111,3,29),(112,3,30),(113,3,32),(114,3,70),(115,3,71),(116,3,72),(117,3,73),(118,3,14),(119,3,12),(120,3,81),(121,3,82),(122,3,83),(123,3,84),(124,3,95),(125,3,91),(126,3,96),(127,3,98),(128,3,99);
DELETE FROM `role_module_operation_assoc` WHERE `role_module_operation_id` = '22'; 
DELETE FROM role_module_operation_assoc WHERE role_module_operation_id = '31';
update users set role_id = '3' where id in('2' , '3', '4', '5');