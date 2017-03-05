-- Create the Webshop tables

DROP DATABASE IF EXISTS webshop;

CREATE DATABASE webshop;

USE webshop;

CREATE TABLE offer (
  product_id INTEGER(5) NOT NULL,
  shopuser_id INTEGER(5) NOT NULL,
  date INTEGER(11) NOT NULL,
  PRIMARY KEY(product_id),
  INDEX offer_FKIndex1(product_id),
  INDEX offer_FKIndex2(shopuser_id),
  UNIQUE INDEX offer_index2292(product_id, shopuser_id)
);

CREATE TABLE product (
  product_id INTEGER(5) NOT NULL AUTO_INCREMENT,
  productname VARCHAR(255) NOT NULL,
  description VARCHAR(255) NULL,
  price_unit DECIMAL(7,2) NOT NULL,
  amount INTEGER(5) NOT NULL,
  PRIMARY KEY(product_id)
);

CREATE TABLE purchase (
  shopuser_id INTEGER(5) NOT NULL,
  product_id INTEGER(5) NOT NULL,
  amount INTEGER(5) NOT NULL,
  date INTEGER(11) NOT NULL,
  INDEX purchase_FKIndex1(product_id),
  INDEX purchase_FKIndex2(shopuser_id)
);

CREATE TABLE rating (
  shopuser_id INTEGER(5) NOT NULL,
  product_id INTEGER(5) NOT NULL,
  mark INTEGER(1) NOT NULL,
  commentary VARCHAR(255) NULL,
  INDEX rating_FKIndex1(product_id),
  INDEX rating_FKIndex2(shopuser_id),
  UNIQUE INDEX rating_index2304(shopuser_id, product_id)
);

CREATE TABLE shopuser (
  shopuser_id INTEGER(5) NOT NULL AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  userpassword VARCHAR(45) NOT NULL,
  authorisation INT(1) NULL,
  PRIMARY KEY(shopuser_id),
  UNIQUE INDEX client_index2200(username)
);

CREATE VIEW v_product AS
    SELECT * FROM product
    WHERE amount >= 0
    WITH CASCADED CHECK OPTION;

-- Fill in test data

INSERT INTO `shopuser` (`shopuser_id`, `username`, `userpassword`, `authorisation`) VALUES
(1, 'customer1', 'customer1', 1),
(2, 'customer2', 'customer2', 1),
(4, 'customer3', 'customer3', 0),
(5, 'customer4', 'customer4', 0),
(3, 'seller1', 'seller1', 2),
(6, 'seller2', 'seller2', 2),
(7, 'admin', 'admin', 3);

INSERT INTO `v_product` (`product_id`, `productname`, `description`, `price_unit`, `amount`) VALUES
(1, 'iPhone 23', 'Will be terrific, delivery approx. mid 2027', 1199.00, 100),
(2, 'Star Wars 7 - The Rise of the ZHAW-Jedis', 'Black-Ray Disc, turbo HD', 39.95, 12),
(3, '4 ECTS points', 'Useful to correct minor exam-accidents', 8500.00, 20),
(4, 'Star Wars 8 - The Students strike back', 'Directed by George Lucas, starring Mark Hamill and Harrison Ford', 49.95, 30),
(5, 'Light Sabre, green', 'The one from the movies, good condition, signed by Darth Vader himself', 2222.00, 1);

INSERT INTO `offer` (`product_id`, `shopuser_id`, `date`) VALUES
(1, 3, UNIX_TIMESTAMP('2011-03-27 03:00:00')),
(2, 6, UNIX_TIMESTAMP('2011-04-26 02:00:00')),
(3, 3, UNIX_TIMESTAMP('2011-05-10 04:00:00')),
(4, 6, UNIX_TIMESTAMP('2011-06-14 03:00:00')),
(5, 6, UNIX_TIMESTAMP('2011-06-23 05:03:00'));

INSERT INTO `purchase` (`shopuser_id`, `product_id`, `amount`, `date` ) VALUES
(1, 4, 21, UNIX_TIMESTAMP('2011-06-25 03:03:00')),
(2, 2, 10, UNIX_TIMESTAMP('2011-06-26 03:05:00')),
(5, 5, 11, UNIX_TIMESTAMP('2011-06-27 12:03:00')),
(4, 1, 5, UNIX_TIMESTAMP('2011-06-28 03:03:00')),
(2, 1, 0, UNIX_TIMESTAMP('2011-06-29 04:03:00'));

INSERT INTO `rating` (`product_id`, `shopuser_id`, `mark`, `commentary`) VALUES
(3, 1, 8, 'The product is great'),
(3, 4, 6, 'The product is cool'),
(2, 4, 3, 'I love it!'),
(1, 4, 3, 'Wow!!!');

-- Create webshop user and set rights

USE mysql;

DROP USER IF EXISTS 'webshop_user'@'localhost';

CREATE USER 'webshop_user'@'localhost' IDENTIFIED BY 'changeit';

GRANT SELECT ON `webshop`.* TO 'webshop_user'@'localhost';
GRANT INSERT, UPDATE, DELETE ON `webshop`.`shopuser` TO 'webshop_user'@'localhost';
GRANT INSERT, UPDATE, DELETE ON `webshop`.`v_product` TO 'webshop_user'@'localhost';
GRANT INSERT, UPDATE, DELETE ON `webshop`.`product` TO 'webshop_user'@'localhost';
GRANT INSERT, UPDATE, DELETE ON `webshop`.`purchase` TO 'webshop_user'@'localhost';
GRANT INSERT, UPDATE, DELETE ON `webshop`.`offer` TO 'webshop_user'@'localhost';
GRANT INSERT, UPDATE, DELETE ON `webshop`.`rating` TO 'webshop_user'@'localhost';

