SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `Praksa2012` ;
CREATE SCHEMA IF NOT EXISTS `Praksa2012` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `Praksa2012` ;

-- -----------------------------------------------------
-- Table `Praksa2012`.`MetaEAVEntityType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Praksa2012`.`MetaEAVEntityType` ;

CREATE  TABLE IF NOT EXISTS `Praksa2012`.`MetaEAVEntityType` (
  `EntityTypeId` INT NOT NULL AUTO_INCREMENT ,
  `EntityTypeName` VARCHAR(45) NULL ,
  PRIMARY KEY (`EntityTypeId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Praksa2012`.`TVStation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Praksa2012`.`TVStation` ;

CREATE  TABLE IF NOT EXISTS `Praksa2012`.`TVStation` (
  `TvID` INT NOT NULL AUTO_INCREMENT ,
  `TvName` VARCHAR(45) NULL ,
  `TvCountry` VARCHAR(45) NULL ,
  PRIMARY KEY (`TvID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Praksa2012`.`EAVEntity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Praksa2012`.`EAVEntity` ;

CREATE  TABLE IF NOT EXISTS `Praksa2012`.`EAVEntity` (
  `EntityId` CHAR(32) NOT NULL ,
  `EntityTypeId` INT NOT NULL ,
  `DateTime` TIMESTAMP NULL ,
  `TvStation` INT NOT NULL ,
  PRIMARY KEY (`EntityId`) ,
  INDEX `fk_EAVEntity_MetaEAVEntityType1_idx` (`EntityTypeId` ASC) ,
  INDEX `fk_EAVEntity_TVStation1_idx` (`TvStation` ASC) ,
  CONSTRAINT `fk_EAVEntity_MetaEAVEntityType1`
    FOREIGN KEY (`EntityTypeId` )
    REFERENCES `Praksa2012`.`MetaEAVEntityType` (`EntityTypeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EAVEntity_TVStation1`
    FOREIGN KEY (`TvStation` )
    REFERENCES `Praksa2012`.`TVStation` (`TvID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Praksa2012`.`MetaEAVAttributeSet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Praksa2012`.`MetaEAVAttributeSet` ;

CREATE  TABLE IF NOT EXISTS `Praksa2012`.`MetaEAVAttributeSet` (
  `AttributeSetId` INT NOT NULL AUTO_INCREMENT ,
  `AttributeSetName` VARCHAR(45) NULL ,
  `Required` TINYINT(1) NULL ,
  PRIMARY KEY (`AttributeSetId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Praksa2012`.`MetaEAVAttribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Praksa2012`.`MetaEAVAttribute` ;

CREATE  TABLE IF NOT EXISTS `Praksa2012`.`MetaEAVAttribute` (
  `AttributeId` INT NOT NULL AUTO_INCREMENT ,
  `DefaultValue` VARCHAR(255) NULL ,
  `Datatype` VARCHAR(45) NULL ,
  `AttributeName` VARCHAR(100) NULL ,
  `RegularExpressionMatch` VARCHAR(255) NULL ,
  PRIMARY KEY (`AttributeId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Praksa2012`.`EAVAttributeValue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Praksa2012`.`EAVAttributeValue` ;

CREATE  TABLE IF NOT EXISTS `Praksa2012`.`EAVAttributeValue` (
  `ValueId` CHAR(32) NOT NULL ,
  `AttributeId` INT NOT NULL ,
  `Value` VARCHAR(255) NULL ,
  `EntityId` CHAR(32) NOT NULL ,
  PRIMARY KEY (`ValueId`) ,
  INDEX `fk_EAVAttributeValue_EAVEntity1_idx` (`EntityId` ASC) ,
  INDEX `fk_EAVAttributeValue_MetaEAVAttribute1_idx` (`AttributeId` ASC) ,
  CONSTRAINT `fk_EAVAttributeValue_EAVEntity1`
    FOREIGN KEY (`EntityId` )
    REFERENCES `Praksa2012`.`EAVEntity` (`EntityId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EAVAttributeValue_MetaEAVAttribute1`
    FOREIGN KEY (`AttributeId` )
    REFERENCES `Praksa2012`.`MetaEAVAttribute` (`AttributeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Praksa2012`.`MetadataTvAttribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Praksa2012`.`MetadataTvAttribute` ;

CREATE  TABLE IF NOT EXISTS `Praksa2012`.`MetadataTvAttribute` (
  `AttributeId` INT NOT NULL AUTO_INCREMENT ,
  `DefaultValue` VARCHAR(255) NULL ,
  `DataType` VARCHAR(45) NULL ,
  `AttributeName` VARCHAR(100) NULL ,
  `RegularExpressionMatch` VARCHAR(255) NULL ,
  PRIMARY KEY (`AttributeId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Praksa2012`.`EAVTv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Praksa2012`.`EAVTv` ;

CREATE  TABLE IF NOT EXISTS `Praksa2012`.`EAVTv` (
  `ValueId` INT NOT NULL AUTO_INCREMENT ,
  `AttributeId` INT NOT NULL ,
  `Value` VARCHAR(255) NULL ,
  `TvId` INT NOT NULL ,
  PRIMARY KEY (`ValueId`) ,
  INDEX `fk_EAVTv_TVStation1_idx` (`TvId` ASC) ,
  INDEX `fk_EAVTv_MetadataTvAttribute1_idx` (`AttributeId` ASC) ,
  CONSTRAINT `fk_EAVTv_TVStation1`
    FOREIGN KEY (`TvId` )
    REFERENCES `Praksa2012`.`TVStation` (`TvID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EAVTv_MetadataTvAttribute1`
    FOREIGN KEY (`AttributeId` )
    REFERENCES `Praksa2012`.`MetadataTvAttribute` (`AttributeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Praksa2012`.`Script`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Praksa2012`.`Script` ;

CREATE  TABLE IF NOT EXISTS `Praksa2012`.`Script` (
  `ScriptId` INT NOT NULL AUTO_INCREMENT ,
  `ScriptName` VARCHAR(100) NULL ,
  `Path` VARCHAR(255) NULL ,
  `LastRun` TIMESTAMP NULL ,
  `RunTime` TIME NULL ,
  `TvStation` INT NOT NULL ,
  PRIMARY KEY (`ScriptId`) ,
  INDEX `fk_Script_TVStation1_idx` (`TvStation` ASC) ,
  CONSTRAINT `fk_Script_TVStation1`
    FOREIGN KEY (`TvStation` )
    REFERENCES `Praksa2012`.`TVStation` (`TvID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Praksa2012`.`MetaEntitySetDependency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Praksa2012`.`MetaEntitySetDependency` ;

CREATE  TABLE IF NOT EXISTS `Praksa2012`.`MetaEntitySetDependency` (
  `AttributeSetId` INT NOT NULL ,
  `EntityTypeId` INT NOT NULL ,
  PRIMARY KEY (`AttributeSetId`, `EntityTypeId`) ,
  INDEX `fk_MetaEAVAttributeSet_has_MetaEAVEntityType_MetaEAVEntityT_idx` (`EntityTypeId` ASC) ,
  INDEX `fk_MetaEAVAttributeSet_has_MetaEAVEntityType_MetaEAVAttribu_idx` (`AttributeSetId` ASC) ,
  CONSTRAINT `fk_MetaEAVAttributeSet_has_MetaEAVEntityType_MetaEAVAttribute1`
    FOREIGN KEY (`AttributeSetId` )
    REFERENCES `Praksa2012`.`MetaEAVAttributeSet` (`AttributeSetId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MetaEAVAttributeSet_has_MetaEAVEntityType_MetaEAVEntityType1`
    FOREIGN KEY (`EntityTypeId` )
    REFERENCES `Praksa2012`.`MetaEAVEntityType` (`EntityTypeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Praksa2012`.`MetaAtrSetDependecy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Praksa2012`.`MetaAtrSetDependecy` ;

CREATE  TABLE IF NOT EXISTS `Praksa2012`.`MetaAtrSetDependecy` (
  `AttributeId` INT NOT NULL ,
  `AttributeSetId` INT NOT NULL ,
  PRIMARY KEY (`AttributeId`, `AttributeSetId`) ,
  INDEX `fk_MetaEAVAttribute_has_MetaEAVAttributeSet_MetaEAVAttribut_idx` (`AttributeSetId` ASC) ,
  INDEX `fk_MetaEAVAttribute_has_MetaEAVAttributeSet_MetaEAVAttribut_idx1` (`AttributeId` ASC) ,
  CONSTRAINT `fk_MetaEAVAttribute_has_MetaEAVAttributeSet_MetaEAVAttribute1`
    FOREIGN KEY (`AttributeId` )
    REFERENCES `Praksa2012`.`MetaEAVAttribute` (`AttributeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MetaEAVAttribute_has_MetaEAVAttributeSet_MetaEAVAttributeS1`
    FOREIGN KEY (`AttributeSetId` )
    REFERENCES `Praksa2012`.`MetaEAVAttributeSet` (`AttributeSetId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
