-- Queries to reset the primary keys of the MSRTC Portal DB for new Drive --
ALTER TABLE `advertisements` AUTO_INCREMENT = 1;
ALTER TABLE `applicant_files` AUTO_INCREMENT = 1;
ALTER TABLE `applicant_forms` AUTO_INCREMENT = 1;
ALTER TABLE `applicant_notifications` AUTO_INCREMENT = 1;
ALTER TABLE `applicant_other_information` AUTO_INCREMENT = 1;
ALTER TABLE `applicant_otps` AUTO_INCREMENT = 1;
ALTER TABLE `applicant_post_assoc` AUTO_INCREMENT = 1;
ALTER TABLE `applicant_queries` AUTO_INCREMENT = 1;
ALTER TABLE `applicants` AUTO_INCREMENT = 1;
ALTER TABLE `challan_files` AUTO_INCREMENT = 1;
ALTER TABLE `challans` AUTO_INCREMENT = 1;
ALTER TABLE `document_category` AUTO_INCREMENT = 1;
ALTER TABLE `document_subcategory` AUTO_INCREMENT = 1;
ALTER TABLE `documents` AUTO_INCREMENT = 1;
ALTER TABLE `change_password_requests` AUTO_INCREMENT = 1;
ALTER TABLE `documents` AUTO_INCREMENT = 1;
ALTER TABLE `messages` AUTO_INCREMENT = 1;
ALTER TABLE `notifications` AUTO_INCREMENT = 1;
ALTER TABLE `payment_transactions` AUTO_INCREMENT = 1;
ALTER TABLE `queries` AUTO_INCREMENT = 1;
ALTER TABLE `replies` AUTO_INCREMENT = 1;
ALTER TABLE `sms_sent_history` AUTO_INCREMENT = 1;
ALTER TABLE `user_notifications` AUTO_INCREMENT = 1;

-- Queries reset the primary keys of the MSRTC EPASS DB for new Drive --
ALTER TABLE `ep_applicant_assigned_city_assoc` AUTO_INCREMENT = 1;
ALTER TABLE `ep_applicant_assigned_city_assoc_deleted` AUTO_INCREMENT = 1;
ALTER TABLE `ep_applicant_exam_marks` AUTO_INCREMENT = 1;
ALTER TABLE `ep_applicant_post_assoc` AUTO_INCREMENT = 1;
ALTER TABLE `ep_applicants` AUTO_INCREMENT = 1;
ALTER TABLE `ep_audit_logs` AUTO_INCREMENT = 1;
ALTER TABLE `ep_exam_applicant_assoc` AUTO_INCREMENT = 1;
ALTER TABLE `ep_exam_city_assoc` AUTO_INCREMENT = 1;
ALTER TABLE `ep_exam_date_assoc` AUTO_INCREMENT = 1;
ALTER TABLE `ep_exam_date_shift_assoc` AUTO_INCREMENT = 1;
ALTER TABLE `ep_exam_post_assoc` AUTO_INCREMENT = 1;
ALTER TABLE `ep_exams` AUTO_INCREMENT = 1;
ALTER TABLE `ep_merit_ranks` AUTO_INCREMENT = 1;
ALTER TABLE `ep_vacancy_matrix` AUTO_INCREMENT = 1;
ALTER TABLE `ep_venue_availability_date_shift_assoc` AUTO_INCREMENT = 1;
ALTER TABLE `ep_venue_availability_dates` AUTO_INCREMENT = 1;
ALTER TABLE `ep_venues` AUTO_INCREMENT = 1;
