USE openmrs_eip_mgt;

CREATE TABLE `site_info` (
     `id` bigint(20) NOT NULL AUTO_INCREMENT,
     `name` varchar(255) NOT NULL,
     `identifier` varchar(255) NOT NULL,
     `date_created` datetime NOT NULL,
     PRIMARY KEY (`id`),
     UNIQUE KEY `site_info_identifier_uk` (`identifier`),
     UNIQUE KEY `site_info_name_uk` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO site_info (name, identifier, date_created) VALUES ('Remote 1', 'Remote-1', now());
