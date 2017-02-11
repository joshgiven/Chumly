SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema chumdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `chumdb` ;
CREATE SCHEMA IF NOT EXISTS `chumdb` ;
USE `chumdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(20) NULL,
  `email` VARCHAR(45) NULL,
  `role` ENUM('ADMIN', 'USER') NULL,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `location` ;

CREATE TABLE IF NOT EXISTS `location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NULL,
  `state` CHAR(2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profile` ;

CREATE TABLE IF NOT EXISTS `profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `description` VARCHAR(256) NULL,
  `location_id` INT NULL,
  `image_url` VARCHAR(128) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_profile_location_idx` (`location_id` ASC),
  CONSTRAINT `fk_profile_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_location`
    FOREIGN KEY (`location_id`)
    REFERENCES `location` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `interest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `interest` ;

CREATE TABLE IF NOT EXISTS `interest` (
  `id` INT NOT NULL AUTO_INCREMENT,
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


-- -----------------------------------------------------
-- Table `user_interest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_interest` ;

CREATE TABLE IF NOT EXISTS `user_interest` (
  `user_id` INT NOT NULL,
  `interest_id` INT NOT NULL,
  INDEX `fk_user_interest_interest_idx` (`interest_id` ASC),
  PRIMARY KEY (`user_id`, `interest_id`),
  CONSTRAINT `fk_user_interest_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_interest_interest`
    FOREIGN KEY (`interest_id`)
    REFERENCES `interest` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `availability`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `availability` ;

CREATE TABLE IF NOT EXISTS `availability` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `day` ENUM('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY') NULL,
  `am` TINYINT(1) NULL,
  `pm` TINYINT(1) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_availability_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_availability_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group` ;

CREATE TABLE IF NOT EXISTS `group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_group` ;

CREATE TABLE IF NOT EXISTS `user_group` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `group_id` INT NULL,
  INDEX `fk_user_group_user_idx` (`user_id` ASC),
  INDEX `fk_user_group_group_idx` (`group_id` ASC),
  PRIMARY KEY (`user_id`),
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


-- -----------------------------------------------------
-- Table `connection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `connection` ;

CREATE TABLE IF NOT EXISTS `connection` (
  `user_id` INT NOT NULL,
  `chum_id` INT NOT NULL,
  INDEX `fk_connection_chum_id_idx` (`chum_id` ASC),
  PRIMARY KEY (`user_id`, `chum_id`),
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


-- -----------------------------------------------------
-- Table `message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message` ;

CREATE TABLE IF NOT EXISTS `message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(256) NOT NULL,
  `timestamp` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `sender_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_user_idx` (`sender_id` ASC),
  CONSTRAINT `fk_message_user`
    FOREIGN KEY (`sender_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `message_chum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message_chum` ;

CREATE TABLE IF NOT EXISTS `message_chum` (
  `message_id` INT NOT NULL,
  `chum_id` INT NOT NULL,
  INDEX `fk_message_chum_idx` (`chum_id` ASC),
  PRIMARY KEY (`message_id`, `chum_id`),
  CONSTRAINT `fk_message_chum_user`
    FOREIGN KEY (`chum_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_chum_message`
    FOREIGN KEY (`message_id`)
    REFERENCES `message` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO chum@localhost;
 DROP USER chum@localhost;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'chum'@'localhost' IDENTIFIED BY 'chum';

GRANT SELECT, INSERT, TRIGGER ON TABLE * TO 'chum'@'localhost';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'chum'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
