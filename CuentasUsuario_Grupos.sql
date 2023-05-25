/**
 * @Description		Tablas para la GESTIÓN de las ENTIDADES referentes a un GRUPOS de CUENTAS y CUENTA de USUARIO
 * @owner			UNA Puno / OTI - 2023
 * @author			Franklin Aimituma Suyo, Ing.
 * @date			20.MAYO.2023
 * @VERSION			0.0.1
 * @rebuild
 *		@author		Luis Carrillo Gutiérrez, Ing.
 *		@date		22.MAYO.2023
 */

/**
 * @Description		GRUPOS de CUENTAS de USUARIO, para efectos de consulta y aplicación de reglas.
 */
DROP TABLE IF EXISTS `UserAccountsGroups`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `UserAccountsGroups` (
	-- Llave de identificación de los GRUPOS de Cuentas de Usuario 
	`Id` CHAR(36) CHARACTER SET ascii NOT NULL,
	-- Denominación coloquial en la 
	`Name` VARCHAR(128) CHARACTER SET utf8mb4 NOT NULL,
	-- Texto con descripción adicional | detallada de un grupo
	`Description` TINYTEXT CHARACTER SET utf8mb4 NULL,
	-- [Bit de Control] para uso interno de los SISTEMAS, indica si un registro  esta activo momentámente. 
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	-- [Bit de Control] para evitar cambios, una vez SANEADOS 
	`CanBeEditable` BIT(1) NOT NULL DEFAULT b'1',
	-- [Bit de Control] de Visibilidad, fuera de los entornos de ADM 
	`IsVisible` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
//
DELIMITER ;


-- TODO: oficina /entidad a la que esta ligada la CUENTA!!! 
DROP TABLE IF EXISTS `UserAccounts`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `UserAccounts` (
	-- Llave identificatoria de un usuario ante los diversos sistemas
	`Id` CHAR(36) CHARACTER SET ascii NOT NULL,
	-- Nos indica que TIPO de CUENTA de USUARIO debe ser asignada
	-- `AcademicalLevel` CHAR(2) CHARACTER SET ascii NOT NULL DEFAULT 'A1', -- estudiante de PRE-GRADO 
	-- Referencial a una PERSONA registrada dentro de la UNA Puno
	`PersonId` CHAR(36) CHARACTER SET ascii NOT NULL, -- [FK]
	-- Correo Electrónico asignada de la CUENTA de USUARIO (identificador)
	`Email` VARCHAR(128) CHARACTER SET utf8mb4 NOT NULL, -- ascii? BASE64
	-- Correo Electrónico ENCRYPTado en SHA-256, para evitar colisiones 
	`EmailCrypt` CHAR(64) CHARACTER SET ascii NOT NULL UNIQUE,
	-- Campo para el manejo de la contraseña de la CUENTA de USUARIO 
	`Password` CHAR(64) CHARACTER SET ascii NOT NULL,
	-- Fecha de INICIO adicional para el registro y/o validez de una CUENTA de USUARIO
	`StartDate` DATE NOT NULL,
	-- Si se establece está fecha se determina la fecha de CADUCIDAD de una CUENTA de USUARIO
	`CaducityDate` DATE NULL,
	-- [Bit de Control] para uso interno de los SISTEMAS, indica si un registro  esta activo momentámente.
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	-- `CanBeEditable` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
//
DELIMITER ;

-- Relaciona que PERSONA es la *dueña* de la CUENTA de USUARIO
ALTER TABLE `UserAccounts` ADD CONSTRAINT `FK_WhosOwnerThisAccount` FOREIGN KEY (`PersonId`) REFERENCES `PersonProfiles`(`Id`);

/* -- --------------------------------------------------------------- */

DROP TABLE IF EXISTS `GroupsMembers`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `GroupsMembers` (
	-- Identificador de la CUENTA de USUARIO que pertenece al GRUPO
	`UserAccountId` CHAR(36) CHARACTER SET ascii NOT NULL,
	-- Apuntador al GRUPO de USUARIOS al que pertenece
	`GroupId` CHAR(36) CHARACTER SET ascii NOT NULL,
	-- Fecha de Ingreso al Grupo / redundante a la Auditoría
	`StartDate` DATETIME NOT NULL,
	-- [Bit de Control] para uso interno de los SISTEMAS, indica si un registro  esta activo momentámente.
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY (`GroupId`, `UserAccountId`)
	-- FOREIGN KEY (`UserAccountId`) REFERENCES `UserAccounts`(`Id`),
	-- FOREIGN KEY (`GroupId`) REFERENCES `Groups`(`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
//
DELIMITER ;

-- Relación que estable la CUENTA de USUARIO 
ALTER TABLE `GroupsMembers`
ADD CONSTRAINT `FK_WhosTheUserAccount` FOREIGN KEY (`UserAccountId`)
REFERENCES `UserAccounts`(`Id`);

ALTER TABLE `GroupsMembers`
ADD CONSTRAINT `FK_WhichGroupAssociated` FOREIGN KEY (`GroupId`)
REFERENCES `UserAccountsGroups`(`Id`);




