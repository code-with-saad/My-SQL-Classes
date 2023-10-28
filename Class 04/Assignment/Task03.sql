# Desgin a database of another e-commerce application closesly related to Daraz
# Features
# - user creation
# - agent creation
# - merchant creation
# - product
# - category
# - order_product
# - order
# - payment



CREATE TABLE `ecommerce`.`user_creation` (
  `user_id` INT NOT NULL DEFAULT 0,
  `user_name` VARCHAR(45) NOT NULL,
  `user_email` VARCHAR(45) NOT NULL,
  `user_password` VARCHAR(45) NOT NULL,
  `is_verified` TINYINT NOT NULL DEFAULT 0,
  `created_datetime` DATETIME NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;




CREATE TABLE `ecommerce`.`agent` (
  `agent_id` INT NOT NULL DEFAULT 0,
  `user_id` INT NOT NULL,
  `agent_created_datetime` DATETIME NULL,
  PRIMARY KEY (`agent_id`),
  INDEX `id_agent_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `id_agent_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `ecommerce`.`user_creation` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




CREATE TABLE `ecommerce`.`merchant` (
  `merchant_id` INT NOT NULL DEFAULT 0,
  `agent_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `created_datetime` DATETIME NULL,
  PRIMARY KEY (`merchant_id`),
  INDEX `agent_id_idx` (`agent_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `agent_id`
    FOREIGN KEY (`agent_id`)
    REFERENCES `ecommerce`.`agent` (`agent_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `ecommerce`.`user_creation` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



CREATE TABLE `ecommerce`.`products` (
  `product_id` INT NOT NULL DEFAULT 0,
  `product_name` VARCHAR(45) NOT NULL,
  `product_desc` VARCHAR(255) NOT NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  `product_category` INT NOT NULL,
  `merchant_id` INT NOT NULL,
  `created_datetime` DATETIME NULL DEFAULT NOW(),
  PRIMARY KEY (`product_id`),
  INDEX `idx_merchant_id_idx` (`merchant_id` ASC) VISIBLE,
  CONSTRAINT `idx_merchant_id`
    FOREIGN KEY (`merchant_id`)
    REFERENCES `ecommerce`.`merchant` (`merchant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `ecommerce`.`products` 
ADD INDEX `product_category_idx` (`product_category` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`products` 
ADD CONSTRAINT `product_category`
  FOREIGN KEY (`product_category`)
  REFERENCES `ecommerce`.`category` (`category_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;




CREATE TABLE `ecommerce`.`category` (
  `category_id` INT NOT NULL DEFAULT 0,
  `category_name` VARCHAR(145) NOT NULL,
  `category_desc` VARCHAR(255) NULL,
  `category_type` ENUM('Physical', 'Digital') NOT NULL,
  `created_datetime` DATETIME NULL DEFAULT NOW(),
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;





CREATE TABLE `ecommerce`.`orders` (
  `order_id` INT NOT NULL DEFAULT 0,
  `user_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `status` ENUM('Shipped', 'In Process', 'Canceled') NOT NULL,
  `comments` TEXT(500) NULL,
  `created_date` DATETIME NULL DEFAULT NOW(),
  PRIMARY KEY (`order_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;





CREATE TABLE `ecommerce`.`order_product` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity_ordered` VARCHAR(45) NOT NULL DEFAULT 0,
  `price_each` VARCHAR(45) NOT NULL DEFAULT 0,
  `created_date` DATETIME NULL DEFAULT NOW(),
  PRIMARY KEY (`order_id`),
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `ecommerce`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `ecommerce`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;







CREATE TABLE `ecommerce`.`payment` (
  `user_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `amount` INT NOT NULL,
  `payment_datetime` DATETIME NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `idx_order_id_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `idx_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `ecommerce`.`user_creation` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idx_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `ecommerce`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


































































































































































































































































































































































































































































