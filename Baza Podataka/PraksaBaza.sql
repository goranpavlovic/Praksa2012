SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`MetaEAVEntityType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MetaEAVEntityType` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`MetaEAVEntityType` (
  `EntityTypeId` INT NOT NULL ,
  `EntityTypeName` VARCHAR(45) NULL ,
  PRIMARY KEY (`EntityTypeId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TVStation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TVStation` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`TVStation` (
  `TvID` INT NOT NULL ,
  `TvName` VARCHAR(45) NULL ,
  `TvCountry` VARCHAR(45) NULL ,
  PRIMARY KEY (`TvID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EAVEntity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EAVEntity` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`EAVEntity` (
  `EntityId` CHAR(32) NOT NULL ,
  `EntityTypeId` INT NOT NULL ,
  `AtributeSetId` INT NOT NULL ,
  `DateTime` TIMESTAMP NULL ,
  `TvStation` INT NOT NULL ,
  PRIMARY KEY (`EntityId`, `EntityTypeId`, `TvStation`) ,
  INDEX `fk_EAVEntity_MetaEAVEntityType1_idx` (`EntityTypeId` ASC) ,
  INDEX `fk_EAVEntity_TVStation1_idx` (`TvStation` ASC) ,
  CONSTRAINT `fk_EAVEntity_MetaEAVEntityType1`
    FOREIGN KEY (`EntityTypeId` )
    REFERENCES `mydb`.`MetaEAVEntityType` (`EntityTypeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EAVEntity_TVStation1`
    FOREIGN KEY (`TvStation` )
    REFERENCES `mydb`.`TVStation` (`TvID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MetaEAVAttributeSet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MetaEAVAttributeSet` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`MetaEAVAttributeSet` (
  `AttributeSetId` INT NOT NULL ,
  `EntityTypeId` INT NOT NULL ,
  `AttributeSetName` VARCHAR(45) NULL ,
  `Required` TINYINT(1) NULL ,
  PRIMARY KEY (`AttributeSetId`, `EntityTypeId`) ,
  INDEX `fk_MetaEAVAttributeSet_MetaEAVEntityType1_idx` (`EntityTypeId` ASC) ,
  CONSTRAINT `fk_MetaEAVAttributeSet_MetaEAVEntityType1`
    FOREIGN KEY (`EntityTypeId` )
    REFERENCES `mydb`.`MetaEAVEntityType` (`EntityTypeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MetaEAVAttribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MetaEAVAttribute` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`MetaEAVAttribute` (
  `AttributeId` INT NOT NULL ,
  `EntityTypeId` INT NOT NULL ,
  `DefaultValue` VARCHAR(255) NULL ,
  `Datatype` VARCHAR(45) NULL ,
  `AttributeName` VARCHAR(100) NULL ,
  `RegularExpressionMatch` VARCHAR(255) NULL ,
  PRIMARY KEY (`AttributeId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MetaEAVDependency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MetaEAVDependency` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`MetaEAVDependency` (
  `EAVDependencyId` INT NOT NULL ,
  `EntityTypeId` INT NOT NULL ,
  `AttributeSetId` INT NOT NULL ,
  `AttributeId` INT NOT NULL ,
  PRIMARY KEY (`EAVDependencyId`, `AttributeSetId`, `AttributeId`, `EntityTypeId`) ,
  INDEX `fk_MetaEAVDependency_MetaEAVAttribute1_idx` (`AttributeId` ASC) ,
  INDEX `fk_MetaEAVDependency_MetaEAVAttributeSet1_idx` (`AttributeSetId` ASC) ,
  INDEX `fk_MetaEAVDependency_MetaEAVEntityType1_idx` (`EntityTypeId` ASC) ,
  CONSTRAINT `fk_MetaEAVDependency_MetaEAVAttribute1`
    FOREIGN KEY (`AttributeId` )
    REFERENCES `mydb`.`MetaEAVAttribute` (`AttributeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MetaEAVDependency_MetaEAVAttributeSet1`
    FOREIGN KEY (`AttributeSetId` )
    REFERENCES `mydb`.`MetaEAVAttributeSet` (`AttributeSetId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MetaEAVDependency_MetaEAVEntityType1`
    FOREIGN KEY (`EntityTypeId` )
    REFERENCES `mydb`.`MetaEAVEntityType` (`EntityTypeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EAVAttributeValue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EAVAttributeValue` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`EAVAttributeValue` (
  `ValueId` CHAR(32) NOT NULL ,
  `AttributeId` INT NOT NULL ,
  `Value` VARCHAR(255) NULL ,
  `EntityId` CHAR(32) NOT NULL ,
  PRIMARY KEY (`ValueId`, `EntityId`, `AttributeId`) ,
  INDEX `fk_EAVAttributeValue_EAVEntity1_idx` (`EntityId` ASC) ,
  INDEX `fk_EAVAttributeValue_MetaEAVAttribute1_idx` (`AttributeId` ASC) ,
  CONSTRAINT `fk_EAVAttributeValue_EAVEntity1`
    FOREIGN KEY (`EntityId` )
    REFERENCES `mydb`.`EAVEntity` (`EntityId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EAVAttributeValue_MetaEAVAttribute1`
    FOREIGN KEY (`AttributeId` )
    REFERENCES `mydb`.`MetaEAVAttribute` (`AttributeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MetadataTvAttribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MetadataTvAttribute` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`MetadataTvAttribute` (
  `AttributeId` INT NOT NULL ,
  `DefaultValue` VARCHAR(255) NULL ,
  `DataType` VARCHAR(45) NULL ,
  `AttributeName` VARCHAR(100) NULL ,
  `RegularExpressionMatch` VARCHAR(255) NULL ,
  PRIMARY KEY (`AttributeId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EAVTv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EAVTv` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`EAVTv` (
  `ValueId` INT NOT NULL ,
  `AttributeId` INT NOT NULL ,
  `Value` VARCHAR(255) NULL ,
  `TvId` INT NOT NULL ,
  PRIMARY KEY (`ValueId`, `TvId`, `AttributeId`) ,
  INDEX `fk_EAVTv_TVStation1_idx` (`TvId` ASC) ,
  INDEX `fk_EAVTv_MetadataTvAttribute1_idx` (`AttributeId` ASC) ,
  CONSTRAINT `fk_EAVTv_TVStation1`
    FOREIGN KEY (`TvId` )
    REFERENCES `mydb`.`TVStation` (`TvID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EAVTv_MetadataTvAttribute1`
    FOREIGN KEY (`AttributeId` )
    REFERENCES `mydb`.`MetadataTvAttribute` (`AttributeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Script`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Script` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Script` (
  `ScriptId` INT NOT NULL ,
  `ScriptName` VARCHAR(100) NULL ,
  `Path` VARCHAR(255) NULL ,
  `LastRun` TIMESTAMP NULL ,
  `RunTime` TIME NULL ,
  `TvStation` INT NOT NULL ,
  PRIMARY KEY (`ScriptId`, `TvStation`) ,
  INDEX `fk_Script_TVStation1_idx` (`TvStation` ASC) ,
  CONSTRAINT `fk_Script_TVStation1`
    FOREIGN KEY (`TvStation` )
    REFERENCES `mydb`.`TVStation` (`TvID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
