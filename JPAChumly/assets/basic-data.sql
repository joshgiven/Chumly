SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


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

