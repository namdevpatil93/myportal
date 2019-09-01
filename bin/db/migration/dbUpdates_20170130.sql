insert into `module_operations` (`module_operation_id`, `module_operation_name`, `display_name`, `module_id`)
values('102','showPaymentSearchForm, searchPayments, markPostAsSubmitted','Reconcile payments','5');

insert into `role_module_operation_assoc` (`role_module_operation_id`, `role_id`, `module_operation_id`) values('131','3','102');

UPDATE system_settings SET value = '14/02/2017' WHERE id = '12';
UPDATE system_settings SET value = '11/02/2017' WHERE id = '13';
