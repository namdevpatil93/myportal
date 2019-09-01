SELECT COUNT(`order_no`) AS successful_online_count, SUM(amount) AS successful_total_online_amount FROM `payment_transactions` WHERE `payment_mode` = 1 AND `status` = 1 AND created_date BETWEEN '2017-01-12 00:00:00' AND '2017-01-12 23:59:59';

SELECT COUNT(`order_no`) AS failed_online_count FROM `payment_transactions` WHERE `payment_mode` =1 AND `status`=2 AND created_date BETWEEN '2017-01-12 00:00:00' AND '2017-01-12 23:59:59';

SELECT COUNT(`order_no`) AS challan_count FROM `payment_transactions` WHERE `payment_mode`=2 AND created_date BETWEEN '2017-01-12 00:00:00' AND '2017-01-12 23:59:59';

SELECT COUNT(`order_no`) AS successful_offline_count,SUM(amount) AS total_succeeful_offline_amount FROM `payment_transactions` WHERE `payment_mode` =2 AND `status`=1 AND created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59';

SELECT COUNT(`order_no`) AS successful_transaction_count,SUM(amount) AS total_sucsessful_amount FROM `payment_transactions` WHERE `status`=1 AND created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59';

SELECT COUNT(`order_no`) AS failed_transaction_count FROM `payment_transactions` WHERE `status`=2 AND created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59';

SELECT COUNT(*) FROM applicants WHERE created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59';

SELECT CASE WHEN `gender`=0 THEN 'Female' ELSE 'Male' END AS Gender , COUNT(gender) FROM `applicants` where created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59' GROUP BY `gender`;

SELECT CASE WHEN `caste_id`=1 THEN 'Open'
WHEN `caste_id`=2 THEN 'O.B.C.'
WHEN `caste_id`=3 THEN 'S.T.'
WHEN `caste_id`=4 THEN 'S.C.'
WHEN `caste_id`=5 THEN 'VJ-A'
WHEN `caste_id`=6 THEN 'NT-B'
WHEN `caste_id`=7 THEN 'NT-C'
WHEN `caste_id`=8 THEN 'NT-D'
WHEN `caste_id`=9 THEN 'S.B.C'
END AS Caste , COUNT(caste_id) AS ApllicantCountForCaste FROM `applicants` WHERE caste_id IS NOT NULL AND created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59' GROUP BY caste_id
UNION
SELECT CASE WHEN caste_id IS NULL THEN 'NOT APPLICABLE' END AS Caste, COUNT(*) AS ApllicantCountForCaste FROM `applicants` WHERE caste_id IS NULL AND created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59' GROUP BY caste_id;

SELECT CASE WHEN `caste_id`=1 THEN 'Open'
WHEN `caste_id`=2 THEN 'O.B.C.'
WHEN `caste_id`=3 THEN 'S.T.'
WHEN `caste_id`=4 THEN 'S.C.'
WHEN `caste_id`=5 THEN 'VJ-A'
WHEN `caste_id`=6 THEN 'NT-B'
WHEN `caste_id`=7 THEN 'NT-C'
WHEN `caste_id`=8 THEN 'NT-D'
WHEN `caste_id`=9 THEN 'S.B.C'
END AS Caste , COUNT(caste_id) AS ApllicantCountForCasteWithCreamyLayer FROM `applicants` WHERE caste_id IS NOT NULL AND caste_id NOT IN (1,3,4)  AND `non_creamy_layer`=1 AND created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59' GROUP BY caste_id
UNION
SELECT CASE WHEN `caste_id`=1 THEN 'Open' END AS Caste , COUNT(caste_id) AS ApllicantCountForCasteWithCreamyLayer FROM `applicants` WHERE caste_id IS NOT NULL AND caste_id =1 AND gender=0  AND `non_creamy_layer`=1 AND created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59' GROUP BY caste_id

SELECT CASE WHEN `caste_id`=1 THEN 'Open'
WHEN `caste_id`=2 THEN 'O.B.C.'
WHEN `caste_id`=3 THEN 'S.T.'
WHEN `caste_id`=4 THEN 'S.C.'
WHEN `caste_id`=5 THEN 'VJ-A'
WHEN `caste_id`=6 THEN 'NT-B'
WHEN `caste_id`=7 THEN 'NT-C'
WHEN `caste_id`=8 THEN 'NT-D'
WHEN `caste_id`=9 THEN 'S.B.C'
END AS Caste , COUNT(caste_id) AS ApllicantCountForCasteWithoutCreamyLayer FROM `applicants` WHERE (caste_id IS NOT NULL AND `non_creamy_layer`=0) OR (caste_id IS NOT NULL AND `non_creamy_layer`IS NULL) AND created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59' GROUP BY caste_id
UNION
SELECT CASE WHEN caste_id IS NULL THEN 'NOT APPLICABLE' END AS Caste , COUNT(*) AS ApllicantCountForCasteWithoutCreamyLayer FROM `applicants` WHERE caste_id IS NULL AND created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59' GROUP BY caste_id
UNION
SELECT CASE WHEN `caste_id`=1 THEN 'Open' END AS Caste , COUNT(caste_id) AS ApllicantCountForCasteWithCreamyLayer FROM `applicants` WHERE caste_id IS NOT NULL AND caste_id =1 AND gender=0  AND `non_creamy_layer` IS NULL AND created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59' GROUP BY caste_id


SELECT 
 CASE WHEN `post_id`=1 THEN 'Driver (Jr.)'
 WHEN `post_id`=2 THEN 'Conductor (Jr.)'
 WHEN `post_id`=3 THEN 'Clerk Typist (Jr.)'
 WHEN `post_id`=4 THEN 'Assistant(Jr.)'
 WHEN `post_id`=5 THEN 'Assistant Traffic Superintendent (Jr.)'
 WHEN `post_id`=6 THEN 'Traffic Inspector (Jr.)'
 WHEN `post_id`=7 THEN 'Accountant (Jr.) / Jr.Stock Verifier (Jr.)'
 WHEN `post_id`=8 THEN 'Store Supervisor (Jr.) / Sr. Stock Verifier (Jr.)'
 WHEN `post_id`=9 THEN 'Store Keeper (Jr.)'
 WHEN `post_id`=10 THEN 'Security Inspector (Jr.)'
 WHEN `post_id`=11 THEN 'Asst. Security Inspector (Jr.)'
 WHEN `post_id`=12 THEN 'Firewarden (Jr.)'
 WHEN `post_id`=13 THEN 'Junior Engineer (Civil) (Jr.)'
 WHEN `post_id`=14 THEN 'Junior Engineer (Electrical)(Jr.)'
 WHEN `post_id`=15 THEN 'Asst. Works Superintendent (Jr.)'
 WHEN `post_id`=16 THEN 'Chargeman (Jr.)'
 WHEN `post_id`=17 THEN 'Draftsman ( Mechanics ) (Jr.)'
 WHEN `post_id`=18 THEN 'Sr.Computer Operator (Jr.) / Divisional Computer Supervisor (Jr.)'
 WHEN `post_id`=19 THEN 'General Manager (Project)'
 WHEN `post_id`=20 THEN 'General Manager (Information Technology)'
 WHEN `post_id`=21 THEN 'Driver Cum Conductor (Jr.)' END AS Post,
COUNT(post_id) FROM `applicant_post_assoc` WHERE created_date BETWEEN '2017-01-11 00:00:00' AND '2017-01-11 23:59:59' GROUP BY post_id;

-- Application Confirmed (Payment Completed Successfully -- ONLINE)
SELECT COUNT(DISTINCT(pt.order_no)) FROM `payment_transactions` pt
JOIN `applicant_post_assoc` p ON pt.`order_no` =  p.txn_order_no AND p.post_id = 21
WHERE `payment_mode` = 1
AND pt.status = 1
AND pt.created_date BETWEEN '2017-01-13 00:00:00' AND '2017-01-13 23:59:59'

-- No of Challans generated

SELECT COUNT(*) FROM `payment_transactions` pt
LEFT JOIN `applicants` a ON a.id = pt.applicant_id
WHERE `payment_mode` = 2
AND pt.created_date
BETWEEN '2017-01-16 00:00:00' AND '2017-01-16 23:59:59';

-- Application Confirmed (Payment Completed Successfully -- Offline)
SELECT COUNT(DISTINCT(pt.order_no)) FROM `payment_transactions` pt
JOIN `applicant_post_assoc` p ON pt.`order_no` =  p.txn_order_no AND p.post_id = 21
WHERE `payment_mode` = 2
AND pt.status = 1
AND p.submitted_date BETWEEN '2017-01-17 00:00:00' AND '2017-01-17 23:59:59'
