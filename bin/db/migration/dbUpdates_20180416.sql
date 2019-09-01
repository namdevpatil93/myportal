-- Alter queries to make email address column unique --
ALTER TABLE `applicants` ADD UNIQUE (`email_address`);
ALTER TABLE `ep_applicants` ADD UNIQUE (`email_address`);
