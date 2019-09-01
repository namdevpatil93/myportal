INSERT INTO modules (module_id, module_name, display_name) VALUES ('10', 'reports', 'Reports'); 
INSERT INTO module_operations (module_operation_id, module_operation_name, display_name, module_id) VALUES ('101', 'viewReports,downloadReport', 'View Reports', '10'); 
INSERT INTO role_module_operation_assoc (role_module_operation_id, role_id, module_operation_id) VALUES (129, '1', '101'); 
INSERT INTO role_module_operation_assoc (role_module_operation_id, role_id, module_operation_id) VALUES (130, '3', '101');