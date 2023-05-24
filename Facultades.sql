/**
 * @Description		Tablas para la GESTIÓN de las ENTIDADES referentes a una FACULTAD
 * @author		Luis Carrillo Gutiérrez, Ing.
 * @date		
 * @version		0.0.1
 */

DROP TABLE IF EXISTS `AcademicalFaculties`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `AcademicalFaculties` (  
	`Id` CHAR(36) CHARACTER SET ascii NOT NULL,
	`Code` CHAR(2) CHARACTER SET ascii NOT NULL,
	`AcademicalLevel` CHAR(2) CHARACTER SET ascii NOT NULL,
	`Name` VARCHAR(128) CHARACTER SET utf8mb4 NOT NULL, 
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1', 
	`CanBeEditable` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY (`Id`),
	UNIQUE KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
//
DELIMITER ;

DROP TABLE IF EXISTS `AcademicalFaculties_`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `AcademicalFaculties_` (
	`Id` CHAR(2) CHARACTER SET ascii NOT NULL,
	`Label` VARCHAR(64) CHARACTER SET utf8mb4 NOT NULL,
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY(`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
//
DELIMITER ;

DROP TABLE IF EXISTS `AcademicalFacultiesAdditionals`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `AcademicalFacultiesAdditionals` (
	`Id` INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	`FacultyId` CHAR(36) CHARACTER SET ascii NOT NULL,
	`Type` CHAR(2) CHARACTER SET ascii NOT NULL,
	`Value` VARCHAR(64) CHARACTER SET utf8mb4 NOT NULL,
	`EffectiveDate` DATE NOT NULL, 
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	`CanBeEditable` BIT(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; -- COLLATE=utf8mb4_unicode_ci;
//
DELIMITER ;

ALTER TABLE `AcademicalFacultiesAdditionals` 
ADD CONSTRAINT `FK_FacultyHasAdditional` FOREIGN KEY (`FacultyId`)
REFERENCES `AcademicalFaculties`(`Id`);

ALTER TABLE `AcademicalFacultiesAdditionals`
ADD CONSTRAINT `FK_FacultyTypeAdditional` FOREIGN KEY (`Type`)
REFERENCES `AcademicalFaculties_`(`Id`);
