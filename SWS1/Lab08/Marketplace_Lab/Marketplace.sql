/************************************************************************************
* Create the database named marketplace, all of its tables, and the marketplace user
*************************************************************************************/

-- Create marketplace database

DROP DATABASE IF EXISTS marketplace;

CREATE DATABASE marketplace;

-- Create tables and set content

USE marketplace;

CREATE TABLE UserInfo (
  Username varchar(15) NOT NULL PRIMARY KEY,
  Password varchar(50) NOT NULL,
  PasswordSHA256 varchar(100) NOT NULL,
  SaltScrypt varchar(50) NOT NULL,
  PasswordScrypt varchar(100) NOT NULL,
  AuthenticationTokenSHA256 varchar(100) NULL
);
  
INSERT INTO UserInfo VALUES ('john', 'wildwest', '9DE6156696AC75758C79BE74B981021C428A0A01BEB5A6212B408848FD133B2E', 'OO58ntoxwO9toPe44tWuHg==', 'vozehaAc0Av4+/GRokKCNzTLPV2a5rqpekXPI4DM1P0=', NULL),
						('alice', 'rabbit', 'D37D96B42AD43384915E4513505C30C0B1C4E7C765B5577EDA25B5DBD7F26D89', 'rHcaPchDGb7l+Mb4OaCMwA==', 'btg7c6SbUKeOgTCIVtvSjmVOGlFL4As10OgNVLA9i80=', NULL),
						('robin', 'arrow', '864EA39FE7E2B27155A29E46FB9458D05E2CCADE4151D02B7C851B10257EDA7A', 'cb4w8aXmFKwWbKEaDNDVjQ==', 'psFKW2gQ/YduJKFov/KlCDDo3oG26rbupQfkRylC8ys=', NULL),
						('donald', 'daisy', '42029EF215256F8FA9FEDB53542EE6553EEF76027B116F8FAC5346211B1E473C', 'O6xFVYWuLseNcxtXMwSWcg==', '8tSgPiMadcvvycQwc2QZOlSFBgH2U8VyuXomm+2INoU=', NULL),
						('luke', 'force', '32500D7500CE0755C1A0F96EF86B10C3100F70F9CA6D8F4D3673D2925AFC2151', '6EAj4i4UgWbWGb3EqIrTTQ==', 'xy7KQA/14/1GmMTH52iGKDsDPN2UJN1kTaUeqIjQ0Ks=', NULL),
                        ('snoopy', 'woodstock', '4303150A368B17442381E0B44AAD6B40FD45241FAD98F686B5295DD03A22FEE0', 'thmYIVJmGU0MWmjQyylKCA==', 'J64xVuoUb4/C2cySZYNSzsRDfCwwWosJui8hVb8Bn7E=', NULL),
						('bob', 'patrick', '23DDDA4810068CC44360DFFD31B6C5A9AD13FB9E6A69C9354A5D1B07F1B9843F', 'TGp52yhg7728U/CstzHeYw==', 'KizQxmykb+sriIWxce5hvaS/PLhafpOLQvHAX6IghE8=', NULL);
                          
CREATE TABLE UserRole (   
  Username VARCHAR(15) NOT NULL,
  Rolename VARCHAR(15) NOT NULL,

  PRIMARY KEY (Username, Rolename)
);
  
INSERT INTO UserRole VALUES ('john', 'sales'),
                            ('alice', 'sales'),
                            ('robin', 'marketing'),
                            ('donald', 'productmanager'),
                            ('luke', 'productmanager'),
                            ('snoopy', 'productmanager'),
                            ('bob', 'burgerman');
                                
CREATE TABLE Product (
    ProductID INT NOT NULL AUTO_INCREMENT,
    Code VARCHAR(10) NOT NULL DEFAULT '',
    Description VARCHAR(100) NOT NULL DEFAULT '',
    Price DECIMAL(9,2) NOT NULL DEFAULT '0.00',
    Username varchar(15) NOT NULL,
  
    PRIMARY KEY (ProductID),
    FOREIGN KEY (Username) REFERENCES UserInfo(Username)
);
  
INSERT INTO Product VALUES 
  (1, '0001', 'DVD Life of Brian - used, some scratches but still works', 5.95, 'donald'),
  (2, '0002', 'Ferrari F50 - red, 43000 km, no accidents', 250000.00, 'luke'),
  (3, '0003', 'Commodore C64 - used, the best computer ever built', 444.95, 'luke'),
  (4, '0004', 'Printed Software-Security script - brand new', 10.95, 'donald');

CREATE TABLE Purchase (
    PurchaseID INT NOT NULL AUTO_INCREMENT,
    Firstname VARCHAR(50) NOT NULL DEFAULT '',
    Lastname VARCHAR(50) NOT NULL DEFAULT '',
    CreditCardNumber VARCHAR(100) NOT NULL DEFAULT '',
    TotalPrice DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  
    PRIMARY KEY (PurchaseID)
);

INSERT INTO Purchase VALUES (1, 'Ferrari', 'Driver', '1111 2222 3333 4444', 250000.00),
                            (2, 'C64', 'Freak', '1234 5678 9012 3456', 444.95),
                            (3, 'Script', 'Lover', '5555 6666 7777 8888', 10.95);
                            
-- Create marketplace user and set rights

USE mysql;

DROP USER IF EXISTS 'marketplace'@'localhost';

CREATE USER 'marketplace'@'localhost' IDENTIFIED BY 'marketplace';

GRANT SELECT         ON `marketplace`.* TO 'marketplace'@'localhost';
GRANT UPDATE         ON `marketplace`.`UserInfo` TO 'marketplace'@'localhost';
GRANT INSERT, DELETE ON `marketplace`.`Product` TO 'marketplace'@'localhost';
GRANT INSERT, DELETE ON `marketplace`.`Purchase` TO 'marketplace'@'localhost';
