/**
 * @Description		Tablas para la GESTIÓN de las ENTIDADES referentes a un GRUPOS de CUENTAS y CUENTA de USUARIO
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
	`Id` CHAR(36) CHARACTER SET ascii NOT NULL,
	`Name` VARCHAR(128) CHARACTER SET utf8mb4 NOT NULL,
	`Description` TINYTEXT CHARACTER SET utf8mb4 NULL,
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	`CanBeEditable` BIT(1) NOT NULL DEFAULT b'1',
	`IsVisible` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
//
DELIMITER ;

DROP TABLE IF EXISTS `UserAccounts`;
DELIMITER //
CREATE TABLE IF NOT EXISTS `UserAccounts` (
	`Id` CHAR(36) CHARACTER SET ascii NOT NULL,
	`PersonId` CHAR(36) CHARACTER SET ascii NOT NULL, -- [FK]
	`Email` VARCHAR(128) CHARACTER SET utf8mb4 NOT NULL, -- ascii? BASE64 
	`EmailCrypt` CHAR(64) CHARACTER SET ascii NOT NULL UNIQUE, 
	`Password` CHAR(64) CHARACTER SET ascii NOT NULL,
	`StartDate` DATE NOT NULL,
	`CaducityDate` DATE NULL,
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
	`UserAccountId` CHAR(36) CHARACTER SET ascii NOT NULL,
	`GroupId` CHAR(36) CHARACTER SET ascii NOT NULL,
	`StartDate` DATETIME NOT NULL,
	`IsEnabled` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY (`GroupId`, `UserAccountId`)
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




