DROP TABLE IF EXISTS `Campus`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `Campus` (
	`Id` CHAR(36) CHARACTER SET ascii NOT NULL,
	`Name` VARCHAR(128) CHARACTER SET utf8mb4 NOT NULL,
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY(`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
//
DELIMITER ;
/*
DROP TABLE IF EXISTS `AddressPerCampus`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `AddressPerCampus` (
	`Id` INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	`CampusId` CHAR(36) CHARACTER SET ascii NOT NULL,
	`Address` VARCHAR(128) CHARACTER SET utf8mb4 NOT NULL,
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	`CanBeEditable` BIT(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
//
DELIMITER ;

ALTER TABLE `AddressPerCampus` ADD CONSTRAINT `FK_CampusHasAddress` FOREIGN KEY (`CampusId`) REFERENCES `Campus`(`Id`);
*/
DROP TABLE IF EXISTS `CampusAdditionals_`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `CampusAdditionals_` (
	`Id` CHAR(2) CHARACTER SET ascii NOT NULL,
	`Name` VARCHAR(64) CHARACTER SET utf8mb4 NOT NULL,
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY(`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
//
DELIMITER ;

DROP TABLE IF EXISTS `CampusAdditionals`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `CampusAdditionals` (
	`Id` INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	`CampusId` CHAR(36) CHARACTER SET ascii NOT NULL,
	`Type` CHAR(2) CHARACTER SET ascii NOT NULL,
	`Value` VARCHAR(64) CHARACTER SET utf8mb4 NOT NULL,
	`EffectiveDate` DATE NOT NULL, 
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	`CanBeEditable` BIT(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; -- COLLATE=utf8mb4_unicode_ci;
//
DELIMITER ;

ALTER TABLE `CampusAdditionals` 
ADD CONSTRAINT `FK_CampusHasAdditional` FOREIGN KEY (`CampusId`)
REFERENCES `Campus`(`Id`);

ALTER TABLE `CampusAdditionals`
ADD CONSTRAINT `FK_CampusTypeAdditional` FOREIGN KEY (`Type`)
REFERENCES `CampusAdditionals_`(`Id`);