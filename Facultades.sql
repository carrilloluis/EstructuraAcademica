/**
 * @Description		Tablas para la GESTIÓN de las ENTIDADES referentes a una FACULTAD
 * @owner			UNA Puno / OTI - 2023
 * @author			Luis Carrillo Gutiérrez, Ing.
 * @date			12.MAYO.2023
 * @version			0.0.1
 * @rebuild
 *		@date		24.MAYO.2023
 */

-- [TO-DO] : el nivel académico para PRE-GRADO y POST-GRADO
DROP TABLE IF EXISTS `AcademicalFaculties`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `AcademicalFaculties` (
	-- Identificador que guarda relación con el Sistema ENCHUFATE y que evita colisiones a diferencia de un AUTO INCREMENTABLE  
	`Id` CHAR(36) CHARACTER SET ascii NOT NULL,
	-- Identificador que guarda a la DB provista por el Ing. Fredy Collanqui
	`Code` CHAR(2) CHARACTER SET ascii NOT NULL,
	-- Descripción o denominación de la Facultad
	`Name` VARCHAR(128) CHARACTER SET utf8mb4 NOT NULL,
	-- [Bit de Control] para uso interno de los SISTEMAS, indica si un registro esta activo momentámente. 
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	-- [Bit de Control] para evitar cambios, una vez SANEADOS 
	`CanBeEditable` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY (`Id`), -- Respeta el KEY de la tabla de ENCHUFATE
	UNIQUE KEY (`Code`) -- respetar el KEY de la tabla del Ing. Fredy
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; -- COLLATE=utf8mb4_unicode_ci;
//
DELIMITER ;


-- Diccionario que gestiona los adicionales de una FACULTAD
DROP TABLE IF EXISTS `AcademicalFaculties_dict`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `AcademicalFaculties_dict` (
	-- Identificador de una TIPO de VALOR a ALMACENAR del DICCIONARIO para FACULTADES
	`Id` CHAR(2) CHARACTER SET ascii NOT NULL,
	-- Valor que describe el TIPO del DICCIONARIO
	`Label` VARCHAR(64) CHARACTER SET utf8mb4 NOT NULL,
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY(`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; -- COLLATE=utf8mb4_unicode_ci;
//
DELIMITER ;


-- Tabla que almacena los valores *adicionales* a una facultad
-- y que pueden ser llenados progresivamente, sin comprometer
-- a la entidad principal de FACULTAD
DROP TABLE IF EXISTS `AcademicalFacultiesAdditionals`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `AcademicalFacultiesAdditionals` (
	-- Identificador [PK] de los DATOS ADICIONALES de una FACULTAD 
	`Id` INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	-- Referencia a una FACULTAD 
	`FacultyId` CHAR(36) CHARACTER SET ascii NOT NULL,
	`Type` CHAR(2) CHARACTER SET ascii NOT NULL,
	-- Valor del DATO ADICIONAL de una FACULTAD
	`Value` VARCHAR(64) CHARACTER SET utf8mb4 NOT NULL,
	-- fecha de vigencia del DATO ADICIONAL (día desde que es válido el dato)
	`EffectiveDate` DATE NOT NULL,  -- CURRENT_DATE
	-- [Bit de Control] para uso interno de los SISTEMAS, indica si un registro  esta activo momentámente. 
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	FOREIGN KEY (`FacultyId`) REFERENCES `AcademicalFaculties`(`Id`),
	FOREIGN KEY (`Type`) REFERENCES `AcademicalFacultiesDict`(`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; -- COLLATE=utf8mb4_unicode_ci;
//
DELIMITER ;

