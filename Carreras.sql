DROP TABLE IF EXISTS `Academical_CareerSchools`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `Academical_CareerSchools`
(
	`Id` CHAR(36) CHARACTER SET ascii NOT NULL,
	`Code` SMALLINT(2) UNSIGNED ZEROFILL NOT NULL, -- SIU
	`FacultyId` CHAR(36) CHARACTER SET ascii NOT NULL, -- `cod_fac` char(2) NOT NULL, -- facultad 
	`Name` VARCHAR(128) CHARACTER SET utf8mb4 NOT NULL,
	`AcademicalLevel` CHAR(2) CHARACTER SET ascii NOT NULL, 
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	`CanBeEditable` BIT(1) NOT NULL DEFAULT b'1',
	`IsVisible` BIT(1) NOT NULL DEFAULT b'1'
	-- PRIMARY KEY(`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
//
DELIMITER ;