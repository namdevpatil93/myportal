DELIMITER $$

ALTER VIEW `view_applicant_post_payment_data` AS (
SELECT
 `pt`.`id`              AS `id`,
 `a`.`application_id`   AS `application_id`,
 `a`.`non_creamy_layer` AS `non_creamy_layer`,
 `a`.`gender`           AS `gender`,
 `c`.`caste_title`      AS `caste_title`,
 `pt`.`applicant_id`    AS `applicant_id`,
 `pt`.`order_no`        AS `order_no`,
 `pt`.`amount`          AS `amount`,
 CASE WHEN `a`.`non_creamy_layer`=0 AND c.id NOT IN (3,4) THEN (SELECT `c1`.`post_fees` FROM castes c1 WHERE c1.id=1)
  WHEN `a`.`non_creamy_layer`=1 THEN `c`.`post_fees` END        AS `post_fees`,
 (`pt`.`amount` / CASE WHEN `a`.`non_creamy_layer`=0 AND c.id NOT IN (3,4) THEN (SELECT `c1`.`post_fees` FROM castes c1 WHERE c1.id=1)
  WHEN `a`.`non_creamy_layer`=1 THEN `c`.`post_fees` END) AS `payment_made_for_post_count`,
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