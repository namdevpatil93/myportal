DELIMITER $$

ALTER  VIEW `view_applicant_post_payment_data` AS (
SELECT
  `pt`.`id`              AS `id`,
  `a`.`application_id`   AS `application_id`,
  `a`.`non_creamy_layer` AS `non_creamy_layer`,
  `a`.`gender`           AS `gender`,
  `c`.`caste_title`      AS `caste_title`,
  `pt`.`applicant_id`    AS `applicant_id`,
  `pt`.`order_no`        AS `order_no`,
  `pt`.`amount`          AS `amount`,
  a.`drought_Affected` AS `drought_Affected`,
  (CASE WHEN a.`drought_Affected`=1 THEN (SELECT `c1`.`post_fees` FROM `castes` `c1` WHERE (`c1`.`id` = 4))  WHEN (a.`drought_Affected`=0 AND (`a`.`non_creamy_layer` = 0) AND (`c`.`id` NOT IN (3,4))) THEN (SELECT `c1`.`post_fees` FROM `castes` `c1` WHERE (`c1`.`id` = 1)) WHEN (`a`.`non_creamy_layer` = 1) THEN `c`.`post_fees` END) AS `post_fees`,
  (`pt`.`amount` / (CASE WHEN a.`drought_Affected`=1 THEN (SELECT `c1`.`post_fees` FROM `castes` `c1` WHERE (`c1`.`id` = 4)) WHEN (a.`drought_Affected`=0 AND (`a`.`non_creamy_layer` = 0) AND (`c`.`id` NOT IN (3,4))) THEN (SELECT `c1`.`post_fees` FROM `castes` `c1` WHERE (`c1`.`id` = 1)) WHEN (`a`.`non_creamy_layer` = 1) THEN `c`.`post_fees` END)) AS `payment_made_for_post_count`,
  (SELECT
     COUNT(0)
   FROM `applicant_post_assoc` `apa`
   WHERE ((`apa`.`txn_order_no` = `pt`.`order_no`)
          AND (`apa`.`status` = 2))) AS `actual_payment_successful_for_post_count`,
  `pt`.`created_date`    AS `transaction_date`
FROM ((`payment_transactions` `pt`
    LEFT JOIN `applicants` `a`
      ON ((`a`.`id` = `pt`.`applicant_id`)))
   LEFT JOIN `castes` `c`
     ON ((`c`.`id` = `a`.`caste_id`)))
WHERE ((`pt`.`payment_mode` = 1)
       AND (`pt`.`status` = 1)))$$

DELIMITER ;



DELIMITER $$

ALTER VIEW `view_applicant_post_payment_mismatch` AS (
SELECT
  `view_applicant_post_payment_data`.`id`                                       AS `id`,
  `view_applicant_post_payment_data`.`application_id`                           AS `application_id`,
  `view_applicant_post_payment_data`.`non_creamy_layer`                         AS `non_creamy_layer`,
  `view_applicant_post_payment_data`.`gender`                                   AS `gender`,
  `view_applicant_post_payment_data`.`caste_title`                              AS `caste_title`,
  `view_applicant_post_payment_data`.`applicant_id`                             AS `applicant_id`,
  `view_applicant_post_payment_data`.`order_no`                                 AS `order_no`,
  `view_applicant_post_payment_data`.`amount`                                   AS `amount`,
  `view_applicant_post_payment_data`.`post_fees`                                AS `post_fees`,
  `view_applicant_post_payment_data`.`payment_made_for_post_count`              AS `payment_made_for_post_count`,
  `view_applicant_post_payment_data`.`actual_payment_successful_for_post_count` AS `actual_payment_successful_for_post_count`,
  `view_applicant_post_payment_data`.`transaction_date`                         AS `transaction_date`,
  CASE WHEN view_applicant_post_payment_data.drought_Affected = 1 THEN  'Yes' 
       WHEN view_applicant_post_payment_data.drought_Affected = 0 THEN  'No'
       WHEN view_applicant_post_payment_data.drought_Affected IS NULL THEN  'No' END AS drought_Affected
FROM `view_applicant_post_payment_data`
WHERE (`view_applicant_post_payment_data`.`payment_made_for_post_count` <> `view_applicant_post_payment_data`.`actual_payment_successful_for_post_count`))$$

DELIMITER ;