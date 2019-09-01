INSERT INTO `system_settings` (`id`, `description`, `modified_time`, `value`)VALUES (12, 'Last date of payment', NOW(), '31/01/2017');

ALTER TABLE post_division_assoc ADD COLUMN active TINYINT(1) DEFAULT 1 NOT NULL AFTER division_id;