SELECT * FROM littlelemondb.orders;
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondb` DEFAULT CHARACTER SET utf8mb3 ;
USE `littlelemondb` ;

-- -----------------------------------------------------
-- Table `littlelemondb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `CustomerName` VARCHAR(255) NULL DEFAULT NULL,
  `ContactNb` INT NULL DEFAULT NULL,
  `Email` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menuitems` (
  `MenuItemsID` INT NOT NULL,
  `Desserts` VARCHAR(255) NULL DEFAULT NULL,
  `Starters` VARCHAR(255) NULL DEFAULT NULL,
  `Courses` VARCHAR(255) NULL DEFAULT NULL,
  `Drinks` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`MenuItemsID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menu` (
  `MenuID` INT NOT NULL,
  `Cuisines` VARCHAR(100) NULL DEFAULT NULL,
  `Starters` VARCHAR(255) NULL DEFAULT NULL,
  `Courses` VARCHAR(255) NULL DEFAULT NULL,
  `Drinks` VARCHAR(255) NULL DEFAULT NULL,
  `Desserts` VARCHAR(255) NULL DEFAULT NULL,
  `MenuItemsID` INT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `MenuItemsID_idx` (`MenuItemsID` ASC) VISIBLE,
  CONSTRAINT `MenuItemsID`
    FOREIGN KEY (`MenuItemsID`)
    REFERENCES `littlelemondb`.`menuitems` (`MenuItemsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`staff` (
  `StaffID` INT NOT NULL AUTO_INCREMENT,
  `Role` VARCHAR(255) NULL DEFAULT NULL,
  `Salary` DECIMAL(10,0) NULL DEFAULT NULL,
  `PhoneNb` INT NULL DEFAULT NULL,
  `Email` VARCHAR(255) NULL DEFAULT NULL,
  `FullName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NOT NULL,
  `TableNb` INT NULL DEFAULT NULL,
  `CustomerID` INT NULL DEFAULT NULL,
  `StaffID` INT NULL DEFAULT NULL,
  `MenuID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `StaffID_idx` (`StaffID` ASC) VISIBLE,
  INDEX `MenuID_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemondb`.`customer` (`CustomerID`),
  CONSTRAINT `MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemondb`.`menu` (`MenuID`),
  CONSTRAINT `StaffID`
    FOREIGN KEY (`StaffID`)
    REFERENCES `littlelemondb`.`staff` (`StaffID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `Quantity` VARCHAR(255) NULL DEFAULT NULL,
  `TotalCost` DECIMAL(10,0) NULL DEFAULT NULL,
  `CustomerID` INT NULL DEFAULT NULL,
  `StaffID` INT NULL DEFAULT NULL,
  `MenuID` INT NULL,
  `MenuItemsID` INT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `StaffID_idx` (`StaffID` ASC) VISIBLE,
  INDEX `MenuID_idx` (`MenuID` ASC) VISIBLE,
  INDEX `MenuItemsID_idx` (`MenuItemsID` ASC) VISIBLE,
  CONSTRAINT `FK_CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemondb`.`customer` (`CustomerID`),
  CONSTRAINT `FK_StaffID`
    FOREIGN KEY (`StaffID`)
    REFERENCES `littlelemondb`.`staff` (`StaffID`),
  CONSTRAINT `MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemondb`.`menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MenuItemsID`
    FOREIGN KEY (`MenuItemsID`)
    REFERENCES `littlelemondb`.`menuitems` (`MenuItemsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`delivery` (
  `DeliveryID` INT NOT NULL AUTO_INCREMENT,
  `DeliveryDate` DATE NULL DEFAULT NULL,
  `DeliveryStatus` VARCHAR(255) NULL DEFAULT NULL,
  `OrderID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `OrderID_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `OrderID`
    FOREIGN KEY (`OrderID`)
    REFERENCES `littlelemondb`.`orders` (`OrderID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `littlelemondb` ;

-- -----------------------------------------------------
-- Placeholder table for view `littlelemondb`.`ordersview`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`ordersview` (`OrderID` INT, `Quantity` INT, `TotalCost` INT);

-- -----------------------------------------------------
-- View `littlelemondb`.`ordersview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `littlelemondb`.`ordersview`;
USE `littlelemondb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`balsam23`@`localhost` SQL SECURITY DEFINER VIEW `littlelemondb`.`ordersview` AS select `littlelemondb`.`orders`.`OrderID` AS `OrderID`,`littlelemondb`.`orders`.`Quantity` AS `Quantity`,`littlelemondb`.`orders`.`TotalCost` AS `TotalCost` from `littlelemondb`.`orders` where (`littlelemondb`.`orders`.`Quantity` > 2);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SELECT * FROM littlelemondb.orders;
-- Add indexes
ALTER TABLE `littlelemondb`.`orders`
  ADD INDEX `MenuID_idx` (`MenuID` ASC) VISIBLE,
  ADD INDEX `MenuItemsID_idx` (`MenuItemsID` ASC) VISIBLE;

-- Add foreign key constraints
ALTER TABLE `littlelemondb`.`orders`
  ADD CONSTRAINT `FK_MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemondb`.`menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_MenuItemsID`
    FOREIGN KEY (`MenuItemsID`)
    REFERENCES `littlelemondb`.`menuitems` (`MenuItemsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

    