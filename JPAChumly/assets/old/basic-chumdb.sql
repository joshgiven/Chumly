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
  `user_id` INT NULL,
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
  `user_id` INT NULL,
  `chum_id` INT NULL,
  INDEX `fk_connection_chum_id_idx` (`chum_id` ASC),
  PRIMARY KEY (`user_id`, `chum_id`),
  CONSTRAINT `fk_connetion_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connection_chum_id`
    FOREIGN KEY (`chum_id`)
    REFERENCES `user` (`id`)
    ON DELETE CASCADE
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
  `message_id` INT NULL,
  `chum_id` INT NULL,
  INDEX `fk_message_chum_idx` (`chum_id` ASC),
  PRIMARY KEY (`message_id`, `chum_id`),
  CONSTRAINT `fk_message_chum_user`
    FOREIGN KEY (`chum_id`)
    REFERENCES `user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_chum_message`
    FOREIGN KEY (`message_id`)
    REFERENCES `message` (`id`)
    ON DELETE CASCADE
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

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `chumdb`;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`) VALUES (1, 'Geoff', 'Geoff', 'ggg@Gmail.com', 'USER');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`) VALUES (2, 'Matt', 'Matt', 'mmm@Gmail.com', 'USER');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`) VALUES (3, 'Josh', 'Josh', 'jjj@Gmail.com', 'USER');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`) VALUES (4, 'Admin', 'Admin', 'admin@Gmail.com', 'ADMIN');

COMMIT;


-- -----------------------------------------------------
-- Data for table `location`
-- -----------------------------------------------------
START TRANSACTION;
USE `chumdb`;
INSERT INTO `location` (`id`, `city`, `state`) VALUES (1, 'Chicago', 'IL');
INSERT INTO `location` (`id`, `city`, `state`) VALUES (2, 'Green Bay', 'WI');
INSERT INTO `location` (`id`, `city`, `state`) VALUES (3, 'Denver', 'CO');
INSERT INTO `location` (`id`, `city`, `state`) VALUES (4, 'San Francisco', 'CA');
INSERT INTO `location` (`id`, `city`, `state`) VALUES (5, 'Boca Raton', 'FL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `profile`
-- -----------------------------------------------------
START TRANSACTION;
USE `chumdb`;
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `description`, `location_id`, `image_url`) VALUES (NULL, 1, 'Geoff', 'Edwards', 'I am the best', 1, NULL);
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `description`, `location_id`, `image_url`) VALUES (NULL, 2, 'Matt', 'Jump', 'I am second best', 2, NULL);
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `description`, `location_id`, `image_url`) VALUES (NULL, 3, 'Josh', 'Given', 'I know more than Matt and Geoff combined', 3, NULL);
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `description`, `location_id`, `image_url`) VALUES (NULL, 4, 'Admin', 'Admin', 'Admin', 3, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `chumdb`;
INSERT INTO `category` (`id`, `name`) VALUES (1, 'Sports');

COMMIT;


-- -----------------------------------------------------
-- Data for table `interest`
-- -----------------------------------------------------
START TRANSACTION;
USE `chumdb`;
INSERT INTO `interest` (`id`, `category_id`, `name`) VALUES (1, 1, 'Quidditch');
INSERT INTO `interest` (`id`, `category_id`, `name`) VALUES (2, 1, 'Football');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_interest`
-- -----------------------------------------------------
START TRANSACTION;
USE `chumdb`;
INSERT INTO `user_interest` (`user_id`, `interest_id`) VALUES (1, 1);
INSERT INTO `user_interest` (`user_id`, `interest_id`) VALUES (2, 1);
INSERT INTO `user_interest` (`user_id`, `interest_id`) VALUES (3, 2);
INSERT INTO `user_interest` (`user_id`, `interest_id`) VALUES (1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `availability`
-- -----------------------------------------------------
START TRANSACTION;
USE `chumdb`;
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (1, 'MONDAY', 1, 1, 1);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (2, 'TUESDAY', 1, 1, 1);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (3, 'WEDNESDAY', 1, 1, 1);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (4, 'THURSDAY', 1, 1, 1);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (5, 'FRIDAY', 1, 1, 1);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (6, 'SATURDAY', 1, 1, 1);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (7, 'SUNDAY', 1, 1, 1);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (8, 'MONDAY', 0, 1, 2);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (9, 'TUESDAY', 0, 1, 2);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (10, 'WEDNESDAY', 0, 1, 2);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (11, 'THURSDAY', 0, 1, 2);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (12, 'FRIDAY', 0, 1, 2);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (13, 'SATURDAY', 1, 1, 2);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (14, 'SUNDAY', 1, 1, 2);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (15, 'MONDAY', 0, 0, 3);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (16, 'TUESDAY', 0, 0, 3);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (17, 'WEDNESDAY', 0, 0, 3);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (18, 'THURSDAY', 0, 0, 3);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (19, 'FRIDAY', 0, 1, 3);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (20, 'SATURDAY', 1, 1, 3);
INSERT INTO `availability` (`id`, `day`, `am`, `pm`, `user_id`) VALUES (21, 'SUNDAY', 1, 1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `connection`
-- -----------------------------------------------------
START TRANSACTION;
USE `chumdb`;
INSERT INTO `connection` (`user_id`, `chum_id`) VALUES (1, 2);
INSERT INTO `connection` (`user_id`, `chum_id`) VALUES (3, 4);
INSERT INTO `connection` (`user_id`, `chum_id`) VALUES (1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `message`
-- -----------------------------------------------------
START TRANSACTION;
USE `chumdb`;
INSERT INTO `message` (`id`, `message`, `timestamp`, `sender_id`) VALUES (1, 'first test message', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `message_chum`
-- -----------------------------------------------------
START TRANSACTION;
USE `chumdb`;
INSERT INTO `message_chum` (`message_id`, `chum_id`) VALUES (1, 2);

COMMIT;

