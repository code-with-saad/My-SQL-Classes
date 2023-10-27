# Desgin a database of Human Resource Managment application
# Requirements
# a superadmin (sa) can add admin and superadmin
# sa or admin can add employees
# sa or admin can mark leave of employee
# sa or admin can mark an employee absent
# sa or admin can add entry of salary every month



CREATE TABLE `human_resource_managment`.super_admin (
  `id` INT NOT NULL DEFAULT 0,
  `name` VARCHAR(45) NOT NULL,
  `number` VARCHAR(15) NOT NULL,
  `city/country` TEXT NOT NULL,
  `super_adminId` INT NULL,
  PRIMARY KEY (`id`));

Select * from super_admin;

INSERT INTO super_admin VALUES (1, "Saad", "03351323557", "Karachi, Pakistan", null);



CREATE TABLE `human_resource_managment`.`admin` (
  `id` INT NOT NULL DEFAULT 0,
  `name` VARCHAR(45) NOT NULL,
  `number` VARCHAR(45) NOT NULL,
  `city/country` TEXT NOT NULL,
  `super_adminId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `super_adminId_idx` (`super_adminId` ASC) VISIBLE,
  CONSTRAINT `super_adminId1`
    FOREIGN KEY (`super_adminId`)
    REFERENCES `human_resource_managment`.`super_admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

Select * from admin;

INSERT INTO admin VALUES (1, "Ahmed", "03323134470", "Karachi, Pakistan", 1);




CREATE TABLE `human_resource_managment`.`employees` (
  `id` INT NOT NULL DEFAULT 0,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `number` VARCHAR(45) NOT NULL,
  `city/country` VARCHAR(45) NOT NULL,
  `super_adminId` INT NULL,
  `admin` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `super_adminId2_idx` (`super_adminId` ASC) VISIBLE,
  INDEX `adminId1_idx` (`admin` ASC) VISIBLE,
  CONSTRAINT `super_adminId2`
    FOREIGN KEY (`super_adminId`)
    REFERENCES `human_resource_managment`.`super_admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `adminId1`
    FOREIGN KEY (`admin`)
    REFERENCES `human_resource_managment`.`admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

Select * from employees;

INSERT INTO employees VALUES (1, "Ali", "Khan", "alikhan@gmail.com",  "03351323557", "Karachi, Pakistan", null, 1);



CREATE TABLE `human_resource_managment`.`attendance` (
  `empId` INT NOT NULL,
  `present` TINYINT NULL,
  `absent` TINYINT NULL,
  `leave` TINYINT NULL,
  `super_adminId` INT NULL,
  `admin` INT NOT NULL,
  INDEX `super_adminId3_idx` (`super_adminId` ASC) VISIBLE,
  INDEX `adminId2_idx` (`admin` ASC) VISIBLE,
  CONSTRAINT `super_adminId3`
    FOREIGN KEY (`super_adminId`)
    REFERENCES `human_resource_managment`.`super_admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION, 
    CONSTRAINT `employeeId`
    FOREIGN KEY (`empId`)
    REFERENCES `human_resource_managment`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `adminId2`
    FOREIGN KEY (`admin`)
    REFERENCES `human_resource_managment`.`admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SELECT * from attendance;

INSERT INTO attendance VALUES (1, False, False, True, null, 1);



CREATE TABLE `human_resource_managment`.`salary` (
  `empId` INT NOT NULL,
  `salary` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `super_adminId` INT NOT NULL,
  `adminId` INT NULL,
  INDEX `emp_Id_idx` (`empId` ASC) VISIBLE,
  INDEX `super_adminId4_idx` (`super_adminId` ASC) VISIBLE,
  INDEX `adminId3_idx` (`adminId` ASC) VISIBLE,
  CONSTRAINT `emp_Id`
    FOREIGN KEY (`empId`)
    REFERENCES `human_resource_managment`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `super_adminId4`
    FOREIGN KEY (`super_adminId`)
    REFERENCES `human_resource_managment`.`super_admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `adminId3`
    FOREIGN KEY (`adminId`)
    REFERENCES `human_resource_managment`.`admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



SELECT * FROM SALARY;

INSERT INTO SALARY VALUES (1, "500000", str_to_date('01-10-2023','%m-%d-%Y'), 1, null)



















































































































































































