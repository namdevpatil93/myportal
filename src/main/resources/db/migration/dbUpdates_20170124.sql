UPDATE users SET PASSWORD='LIkLQ6hdRd5h/KMXGWwr2Ub0TZq9f/hP9PxBhF4k3s7f3540XpU/RULK4SCJvOwy' WHERE id=5;

ALTER TABLE  `applicant_other_information` ADD INDEX  `part_time_employee` (`part_time_employee`);
ALTER TABLE  `applicant_other_information` ADD INDEX  `ex_service_man` (`ex_service_man`);
ALTER TABLE  `applicant_other_information` ADD INDEX  `st_employee` (`st_employee`);
ALTER TABLE  `applicant_other_information` ADD INDEX  `sports_person` (`sports_person`);
ALTER TABLE  `applicant_other_information` ADD INDEX  `project_effected` (`project_effected`);
ALTER TABLE  `applicant_other_information` ADD INDEX  `earth_quake_effected` (`earth_quake_effected`);

ALTER TABLE  `applicants` ADD INDEX  `caste_id` (`caste_id`);
ALTER TABLE  `applicants` ADD INDEX  `district_id` (`district_id`);
ALTER TABLE  `applicants` ADD INDEX  `application_id` (`application_id`);
ALTER TABLE  `applicants` ADD INDEX  `gender` (`gender`);
