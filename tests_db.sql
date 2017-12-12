SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema tests_bd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tests_bd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tests_bd` DEFAULT CHARACTER SET utf8 ;
USE `tests_bd` ;

-- -----------------------------------------------------
-- Table `tests_bd`.`TypeSection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tests_bd`.`TypeSection` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` LONGTEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tests_bd`.`Test`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tests_bd`.`Test` (
  `uuid` CHAR(36) NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`uuid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tests_bd`.`Section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tests_bd`.`Section` (
  `uuid` CHAR(36) NOT NULL,
  `type_section_id` INT NULL,
  `test_id` CHAR(36) NULL,
  PRIMARY KEY (`uuid`),
  INDEX `type_seqtion_idx` (`type_section_id` ASC),
  INDEX `test_id_idx` (`test_id` ASC),
  CONSTRAINT `type_seqtion`
    FOREIGN KEY (`type_section_id`)
    REFERENCES `tests_bd`.`TypeSection` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `test_id`
    FOREIGN KEY (`test_id`)
    REFERENCES `tests_bd`.`Test` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tests_bd`.`TypeQuestion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tests_bd`.`TypeQuestion` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tests_bd`.`Question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tests_bd`.`Question` (
  `uuid` CHAR(36) NOT NULL,
  `name` VARCHAR(45) NULL,
  `question_type_id` INT NULL,
  `section_id` INT NULL,
  `answer` VARCHAR(200) NULL,
  PRIMARY KEY (`uuid`),
  INDEX `section_id_idx` (`section_id` ASC),
  INDEX `question_type_idx` (`question_type_id` ASC),
  CONSTRAINT `section_id`
    FOREIGN KEY (`section_id`)
    REFERENCES `tests_bd`.`Section` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `question_type`
    FOREIGN KEY (`question_type_id`)
    REFERENCES `tests_bd`.`TypeQuestion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tests_bd`.`GradeSeqtion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tests_bd`.`GradeSeqtion` (
  `uuid` CHAR(36) NOT NULL,
  `seqtion_id` CHAR(36) NULL,
  `grade_max` INT NULL,
  `grade_min` INT NULL,
  PRIMARY KEY (`uuid`),
  INDEX `seqtion_id_idx` (`seqtion_id` ASC),
  CONSTRAINT `seqtion_id`
    FOREIGN KEY (`seqtion_id`)
    REFERENCES `tests_bd`.`Section` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `tests_bd`;

DELIMITER $$
USE `tests_bd`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Test_BEFORE_INSERT` BEFORE INSERT ON `Test` FOR EACH ROW
BEGIN
	IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;	
END$$

USE `tests_bd`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Section_BEFORE_INSERT` BEFORE INSERT ON `Section` FOR EACH ROW
BEGIN
	IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;
END$$

USE `tests_bd`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Question_BEFORE_INSERT` BEFORE INSERT ON `Question` FOR EACH ROW
BEGIN
	IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;
END$$

USE `tests_bd`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`GradeSeqtion_BEFORE_INSERT` BEFORE INSERT ON `GradeSeqtion` FOR EACH ROW
BEGIN
	IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
