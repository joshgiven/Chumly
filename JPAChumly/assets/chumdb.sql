-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema chumlydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `chumlydb` ;

-- -----------------------------------------------------
-- Schema chumlydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `chumlydb` ;
SHOW WARNINGS;
USE `chumlydb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `user` (
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(20) NULL,
  `role` VARCHAR(20) NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `location` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `location` (
  `id` INT NOT NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profile` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `profile` (
  `user_Id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `description` VARCHAR(256) NULL,
  `location_id` INT NULL,
  `image_url` VARCHAR(45) NULL,
  PRIMARY KEY (`user_Id`),
  INDEX `fk_profile_location_idx` (`location_id` ASC),
  CONSTRAINT `fk_profile_user`
    FOREIGN KEY (`user_Id`)
    REFERENCES `user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_profile_location`
    FOREIGN KEY (`location_id`)
    REFERENCES `location` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `interest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `interest` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `interest` (
  `id` INT NOT NULL,
  `category_id` INT NULL,
  `name` VARCHAR(256) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_interest_category_idx` (`category_id` ASC),
  CONSTRAINT `fk_interest_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `user_interest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_interest` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `user_interest` (
  `user_id` INT NOT NULL,
  `interest_id` INT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_user_interest_interest_idx` (`interest_id` ASC),
  CONSTRAINT `fk_user_interest_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_interest_interest`
    FOREIGN KEY (`interest_id`)
    REFERENCES `interest` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `availability`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `availability` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `availability` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `day` ENUM('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY') NULL,
  `am` TINYINT(1) NULL,
  `pm` TINYINT(1) NULL,
  `user_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_availability_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_availability_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `group` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_group` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `user_group` (
  `user_id` INT NULL,
  `group_id` INT NULL,
  INDEX `fk_user_group_user_idx` (`user_id` ASC),
  INDEX `fk_user_group_group_idx` (`group_id` ASC),
  CONSTRAINT `fk_user_group_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_group`
    FOREIGN KEY (`group_id`)
    REFERENCES `group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `connection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `connection` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `connection` (
  `user_id` INT NOT NULL,
  `chum_id` INT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_connection_chum_id_idx` (`chum_id` ASC),
  CONSTRAINT `fk_connetion_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connection_chum_id`
    FOREIGN KEY (`chum_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(256) NULL,
  `timestamp` DATETIME NULL,
  `sender_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_user_idx` (`sender_id` ASC),
  CONSTRAINT `fk_message_user`
    FOREIGN KEY (`sender_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
