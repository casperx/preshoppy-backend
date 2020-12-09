CREATE TABLE `event` (
  `e_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `e_name` varchar(200) NOT NULL,
  `e_detail` varchar(5000) NOT NULL,
  `e_start_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `e_end_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `e_location` varchar(500) NOT NULL,
  `e_contact` varchar(500) NOT NULL,
  `e_event_pic` varchar(100) NOT NULL,
  PRIMARY KEY (`e_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user_role` (
  `ur_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ur_name` varchar(100) NOT NULL,
  PRIMARY KEY (`ur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO user_role (ur_name) VALUES
  ('Admin'),
  ('Supporter'),
  ('Buyer'),
  ('Seller');

CREATE TABLE `user_vendor_status` (
  `uvs_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uvs_name` varchar(100) NOT NULL,
  `uvs_detail` varchar(256) NOT NULL,
  PRIMARY KEY (`uvs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO user_vendor_status (uvs_name,uvs_detail) VALUES
  ('not request','not request'),
  ('request pending','Your request is pending for our Supporter to inspect.'),
  ('request granted','Your request has been granted. You are seller now.'),
  ('request rejected','Your request has been rejected. Please review your information again.');

CREATE TABLE `user_address` (
  `ua_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `u_id` int(10) unsigned NOT NULL,
  `ua_tel` varchar(100) NOT NULL,
  `ua_address` varchar(500) NOT NULL,
  `ua_name` varchar(100) NOT NULL,
  PRIMARY KEY (`ua_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user` (
  `u_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `u_email` varchar(64) NOT NULL,
  `u_password` varchar(256) NOT NULL,
  `u_first_name` varchar(100) NOT NULL,
  `u_last_name` varchar(100) NOT NULL,
  `u_profile_pic` varchar(100) NOT NULL,
  `u_id_card_pic` varchar(100) DEFAULT NULL,
  `u_verify_pic` varchar(100) DEFAULT NULL,
  `u_tel` varchar(100) NOT NULL,
  `uvs_id` int(10) unsigned NOT NULL DEFAULT 1,
  `ur_id` int(10) unsigned NOT NULL DEFAULT 3,
  `ua_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`u_id`),
  KEY `u_ur` (`ur_id`),
  KEY `u_uvs` (`uvs_id`),
  KEY `u_ua` (`ua_id`),
  CONSTRAINT `u_ua` FOREIGN KEY (`ua_id`) REFERENCES `user_address` (`ua_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `u_ur` FOREIGN KEY (`ur_id`) REFERENCES `user_role` (`ur_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `u_uvs` FOREIGN KEY (`uvs_id`) REFERENCES `user_vendor_status` (`uvs_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `user_address`
  ADD KEY `ua_u` (`u_id`),
  ADD CONSTRAINT `ua_u` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE;
