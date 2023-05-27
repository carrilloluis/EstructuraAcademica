DROP TABLE IF EXISTS `AcademicalLevels_`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `AcademicalLevels_` (
	`Id` CHAR(2) CHARACTER SET ascii NOT NULL,
	`Label` VARCHAR(64) CHARACTER SET utf8mb4 NOT NULL,
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY(`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
//
DELIMITER ;

INSERT INTO `AcademicalLevels_` VALUES('01', 'pre-grado [bachillerato]', b'1');
INSERT INTO `AcademicalLevels_` VALUES('02', 'post-grado [maestría]', b'1');
INSERT INTO `AcademicalLevels_` VALUES('03', 'post-grado [doctorado]', b'1');