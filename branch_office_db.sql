SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema branch_office_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema branch_office_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `branch_office_db` DEFAULT CHARACTER SET utf8 ;
USE `branch_office_db` ;

-- -----------------------------------------------------
-- Table `branch_office_db`.`Passport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `branch_office_db`.`Passport` (
  `uuid` CHAR(36) NOT NULL,
  `passport_number` VARCHAR(10) NULL,
  `nationality` VARCHAR(45) NULL,
  PRIMARY KEY (`uuid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `branch_office_db`.`Branch_office`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `branch_office_db`.`Branch_office` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `branch_office_db`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `branch_office_db`.`User` (
  `uuid` CHAR(36) NOT NULL,
  `name` VARCHAR(45) NULL,
  `surname` VARCHAR(45) NULL,
  `patronymic` VARCHAR(45) NULL,
  `passport_id` INT NULL,
  `branch_office_id` INT NULL,
  PRIMARY KEY (`uuid`),
  INDEX `passport_id_idx` (`passport_id` ASC),
  INDEX `branch_office_id_idx` (`branch_office_id` ASC),
  CONSTRAINT `passport_id`
    FOREIGN KEY (`passport_id`)
    REFERENCES `branch_office_db`.`Passport` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `branch_office_id`
    FOREIGN KEY (`branch_office_id`)
    REFERENCES `branch_office_db`.`Branch_office` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `branch_office_db`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `branch_office_db`.`Status` (
  `id` INT NOT NULL,
  `status_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `branch_office_db`.`Exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `branch_office_db`.`Exam` (
  `uuid` CHAR(36) NOT NULL,
  `test` CHAR(36) NULL,
  PRIMARY KEY (`uuid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `branch_office_db`.`Test_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `branch_office_db`.`Test_request` (
  `uuid` CHAR(36) NOT NULL,
  `user_id` CHAR(36) NULL,
  `request_date` DATE NULL,
  `test_date` DATE NULL,
  `exam_id` CHAR(36) NULL,
  `status` INT NULL,
  PRIMARY KEY (`uuid`),
  INDEX `user_id_idx` (`user_id` ASC),
  INDEX `status_id_idx` (`status` ASC),
  INDEX `exam_id_idx` (`exam_id` ASC),
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `branch_office_db`.`User` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `status_id`
    FOREIGN KEY (`status`)
    REFERENCES `branch_office_db`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `exam_id`
    FOREIGN KEY (`exam_id`)
    REFERENCES `branch_office_db`.`Exam` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `branch_office_db`.`Answer_test`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `branch_office_db`.`Answer_test` (
  `uuid` CHAR(36) NOT NULL,
  `test_request_id` CHAR(36) NULL,
  `question_id` INT NULL,
  `answer_id` INT NULL,
  PRIMARY KEY (`uuid`),
  INDEX `test_request_idx` (`test_request_id` ASC),
  CONSTRAINT `test_request`
    FOREIGN KEY (`test_request_id`)
    REFERENCES `branch_office_db`.`Test_request` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `branch_office_db`.`Answer_free_response`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `branch_office_db`.`Answer_free_response` (
  `uuid` CHAR(36) NOT NULL,
  `test_request_id` CHAR(36) NULL,
  `question_id` INT NULL,
  `answer` LONGTEXT NULL,
  PRIMARY KEY (`uuid`),
  INDEX `test_request_idx` (`test_request_id` ASC),
  CONSTRAINT `test_request`
    FOREIGN KEY (`test_request_id`)
    REFERENCES `branch_office_db`.`Test_request` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `branch_office_db`.`Answer_audio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `branch_office_db`.`Answer_audio` (
  `uuid` CHAR(36) NOT NULL,
  `test_request_id` CHAR(36) NULL,
  `question_id` INT NULL,
  `answer` VARCHAR(45) NULL,
  PRIMARY KEY (`uuid`),
  INDEX `test_request_id_idx` (`test_request_id` ASC),
  CONSTRAINT `test_request_id`
    FOREIGN KEY (`test_request_id`)
    REFERENCES `branch_office_db`.`Test_request` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `branch_office_db`.`Result`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `branch_office_db`.`Result` (
  `uuid` CHAR(36) NOT NULL,
  `test_request_id` CHAR(36) NULL,
  `grade` INT NULL,
  PRIMARY KEY (`uuid`),
  INDEX `test_request_id_idx` (`test_request_id` ASC),
  CONSTRAINT `test_request_id`
    FOREIGN KEY (`test_request_id`)
    REFERENCES `branch_office_db`.`Test_request` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `branch_office_db`;

DELIMITER $$
USE `branch_office_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Passport_BEFORE_INSERT` BEFORE INSERT ON `Passport` FOR EACH ROW
BEGIN
	IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;	
END$$

USE `branch_office_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`User_BEFORE_INSERT` BEFORE INSERT ON `User` FOR EACH ROW
BEGIN
	IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;	
END$$

USE `branch_office_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `branch_office_db`.`Exam_BEFORE_INSERT` BEFORE INSERT ON `Exam` FOR EACH ROW
BEGIN
	IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;
END$$

USE `branch_office_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Test_request_BEFORE_INSERT` BEFORE INSERT ON `Test_request` FOR EACH ROW
BEGIN
	IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;	
END$$

USE `branch_office_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Answer_test_BEFORE_INSERT` BEFORE INSERT ON `Answer_test` FOR EACH ROW
BEGIN
	IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;	
END$$

USE `branch_office_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Answer_free_response_BEFORE_INSERT` BEFORE INSERT ON `Answer_free_response` FOR EACH ROW
BEGIN
	IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;	
END$$

USE `branch_office_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Answer_audio_BEFORE_INSERT` BEFORE INSERT ON `Answer_audio` FOR EACH ROW
BEGIN
	IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;	
END$$

USE `branch_office_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Result_BEFORE_INSERT` BEFORE INSERT ON `Result` FOR EACH ROW
BEGIN
	IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;	
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
