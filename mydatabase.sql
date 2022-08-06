-- -------------------------------------------Создание базы данных----------------------------------------------------------------------- --
CREATE SCHEMA IF NOT EXISTS bookshop;
USE `bookshop` ;
CREATE TABLE IF NOT EXISTS `bookshop`.`authors` (
  `id_author` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_author`));
CREATE TABLE IF NOT EXISTS `bookshop`.`cards` (
  `id_cards` INT NOT NULL AUTO_INCREMENT,
  `amount_of_discount` INT NULL DEFAULT '0',
  PRIMARY KEY (`id_cards`));
CREATE TABLE IF NOT EXISTS `bookshop`.`clients` (
  `id_clients` INT NOT NULL AUTO_INCREMENT,
  `client_name` TINYTEXT NOT NULL,
  `contacts` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_clients`));
CREATE TABLE IF NOT EXISTS `bookshop`.`covertype` (
  `id_covertype` INT NOT NULL AUTO_INCREMENT,
  `typeofcover` TINYTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_covertype`));
CREATE TABLE IF NOT EXISTS `bookshop`.`discounts` (
  `id_discounts` INT NOT NULL AUTO_INCREMENT,
  `discount_name` VARCHAR(100) NOT NULL,
  `discount_terms` VARCHAR(100) NOT NULL,
  `validity` DATETIME NOT NULL,
  `amount` INT NOT NULL,
  PRIMARY KEY (`id_discounts`));
CREATE TABLE IF NOT EXISTS `bookshop`.`publishing_houses` (
  `id_publishing_houses` INT NOT NULL AUTO_INCREMENT,
  `publishing_house` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_publishing_houses`));
CREATE TABLE IF NOT EXISTS `bookshop`.`editions` (
  `id_editions` INT NOT NULL AUTO_INCREMENT,
  `count` INT NULL DEFAULT NULL,
  `year_of_publishing` DATETIME NULL DEFAULT NULL,
  `price` INT NULL DEFAULT NULL,
  `id_publishing_house` INT NOT NULL,
  `id_covertype` INT NOT NULL,
  PRIMARY KEY (`id_editions`),
  CONSTRAINT `fk_to_publishing_houses`
    FOREIGN KEY (`id_publishing_house`)
    REFERENCES `bookshop`.`publishing_houses` (`id_publishing_houses`),
  CONSTRAINT `fl_to_covertype`
    FOREIGN KEY (`id_covertype`)
    REFERENCES `bookshop`.`covertype` (`id_covertype`));
CREATE TABLE IF NOT EXISTS `bookshop`.`entrances` (
  `id_entrances` INT NOT NULL AUTO_INCREMENT,
  `entrance_date` DATE NULL DEFAULT NULL,
  `entrance_place` TINYTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_entrances`));
CREATE TABLE IF NOT EXISTS `bookshop`.`editions_to_entrances` (
  `id_editions` INT NOT NULL,
  `id_entrances` INT NOT NULL,
  `count_of_entrance` INT NULL DEFAULT '0',
  PRIMARY KEY (`id_editions`, `id_entrances`),
  CONSTRAINT `fk_ete_editions`
    FOREIGN KEY (`id_editions`)
    REFERENCES `bookshop`.`editions` (`id_editions`),
  CONSTRAINT `fk_ete_entrances`
    FOREIGN KEY (`id_entrances`)
    REFERENCES `bookshop`.`entrances` (`id_entrances`));
CREATE TABLE IF NOT EXISTS `bookshop`.`points` (
  `id_points` INT NOT NULL AUTO_INCREMENT,
  `adress` VARCHAR(50) NOT NULL,
  `terms` TINYTEXT NOT NULL,
  PRIMARY KEY (`id_points`));
CREATE TABLE IF NOT EXISTS `bookshop`.`orders` (
  `id_orders` INT NOT NULL AUTO_INCREMENT,
  `id_clients` INT NULL DEFAULT NULL,
  `id_points` INT NULL DEFAULT NULL,
  `id_cards` INT NULL DEFAULT NULL,
  `orderdate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_orders`),
  CONSTRAINT `fk_orders_cards`
    FOREIGN KEY (`id_cards`)
    REFERENCES `bookshop`.`cards` (`id_cards`),
  CONSTRAINT `fk_orders_clients`
    FOREIGN KEY (`id_clients`)
    REFERENCES `bookshop`.`clients` (`id_clients`),
  CONSTRAINT `fk_orders_points`
    FOREIGN KEY (`id_points`)
    REFERENCES `bookshop`.`points` (`id_points`));
CREATE TABLE IF NOT EXISTS `bookshop`.`editions_to_orders` (
  `id_editions` INT NOT NULL,
  `id_orders` INT NOT NULL,
  `count_of_goods` INT NOT NULL,
  PRIMARY KEY (`id_editions`, `id_orders`),
  CONSTRAINT `fk_eto_editions`
    FOREIGN KEY (`id_editions`)
    REFERENCES `bookshop`.`editions` (`id_editions`),
  CONSTRAINT `fk_eto_orders`
    FOREIGN KEY (`id_orders`)
    REFERENCES `bookshop`.`orders` (`id_orders`));
CREATE TABLE IF NOT EXISTS `bookshop`.`example` (
  `id_example` INT NOT NULL AUTO_INCREMENT,
  `column_1` INT NULL DEFAULT NULL,
  `column_2` TEXT NULL DEFAULT NULL,
  `column_3` INT NULL DEFAULT NULL,
  `column_4` DATETIME NULL DEFAULT NULL,
  `column_5` INT NULL DEFAULT NULL,
  `column_6` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_example`));
CREATE TABLE IF NOT EXISTS `bookshop`.`themes` (
  `id_themes` INT NOT NULL AUTO_INCREMENT,
  `genre` TEXT NOT NULL,
  `annotation` TINYTEXT NOT NULL,
  PRIMARY KEY (`id_themes`));
CREATE TABLE IF NOT EXISTS `bookshop`.`goods` (
  `id_goods` INT NOT NULL AUTO_INCREMENT,
  `book_name` VARCHAR(45) NOT NULL,
  `age_restrictions` INT NULL DEFAULT NULL,
  `id_editions` INT NULL DEFAULT NULL,
  `id_themes` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_goods`),
  CONSTRAINT `fk_goods_editions`
    FOREIGN KEY (`id_editions`)
    REFERENCES `bookshop`.`editions` (`id_editions`),
  CONSTRAINT `fk_goods_themes`
    FOREIGN KEY (`id_themes`)
    REFERENCES `bookshop`.`themes` (`id_themes`));
CREATE TABLE IF NOT EXISTS `bookshop`.`goods_to_authors` (
  `id_goods` INT NOT NULL,
  `id_authors` INT NOT NULL,
  PRIMARY KEY (`id_goods`, `id_authors`),
  CONSTRAINT `fk_authors_to_goods`
    FOREIGN KEY (`id_goods`)
    REFERENCES `bookshop`.`goods` (`id_goods`),
  CONSTRAINT `fk_goods_to_authors`
    FOREIGN KEY (`id_authors`)
    REFERENCES `bookshop`.`authors` (`id_author`));
    
CREATE TABLE IF NOT EXISTS `bookshop`.`goods_to_clients` (
  `id_goods` INT NOT NULL,
  `id_clients` INT NOT NULL,
  `datetime` DATETIME NOT NULL,
  PRIMARY KEY (`id_clients`, `id_goods`),
  CONSTRAINT `fk_clients_to_goods`
    FOREIGN KEY (`id_goods`)
    REFERENCES `bookshop`.`goods` (`id_goods`),
  CONSTRAINT `fk_to_clients`
    FOREIGN KEY (`id_clients`)
    REFERENCES `bookshop`.`clients` (`id_clients`));

CREATE TABLE IF NOT EXISTS `bookshop`.`goods_to_discounts` (
  `id_discounts` INT NOT NULL,
  `id_goods` INT NOT NULL,
  PRIMARY KEY (`id_discounts`, `id_goods`),
  CONSTRAINT `fk_discounts_to_goods`
    FOREIGN KEY (`id_goods`)
    REFERENCES `bookshop`.`goods` (`id_goods`),
  CONSTRAINT `fk_to_discounts`
    FOREIGN KEY (`id_discounts`)
    REFERENCES `bookshop`.`discounts` (`id_discounts`));
-- ------------------------------------------------------------Заполнение данных------------------------------------------------------------ --
/*Добавлено 1000 авторов*/
load data infile 
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\authors.csv'
into table authors
ignore 1 lines 
(author_name);
/*Добавлено 1000 пунктов выдачи*/
load data infile
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\points.csv'
into table points
fields terminated by ','
(adress,terms);
/*Добавлено 1000 клиентов*/
load data infile
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\clients.csv'
into table clients
fields terminated by ','
(client_name,contacts);
/*Добавлено 1000 клиентских карт*/
load data infile 
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\cards.csv'
into table cards 
(amount_of_discount);
/*Добавлено 1000 скидок*/
load data infile
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\discounts.csv'
into table discounts
fields terminated by ','
ignore 1 lines
(discount_name,discount_terms,validity,amount);
/*Добавлено 1000 тематик*/
load data infile 
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\themes.csv'
INTO TABLE themes
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(genre, annotation);
/*Добавлено 1000 поступлений товара*/
load data infile 
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\entrances.csv'
INTO TABLE entrances
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(entrance_date,entrance_place);
/*Добавлено 1000 издательских домов*/
load data infile 
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\publishing_houses.csv'
into table publishing_houses
fields terminated by ';'
ignore 1 lines
(publishing_house);
/*Добавлено 1000 заказов*/
load data infile
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\orders.csv'
into table orders
fields terminated by ','
ignore 1 lines
(id_clients, id_points, orderdate);
UPDATE orders SET id_cards = id_clients;
/*Добавлено 1000 изданий*/
load data infile 
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\editions.csv'
into table editions
fields terminated by ','
ignore 1 lines
(count,year_of_publishing,price,id_publishing_house,id_covertype);
/*1000 значений заказы-к-изданиям*/
load data infile 
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\editions_to_orders.csv'
into table editions_to_orders
fields terminated by ','
ignore 1 lines
(id_editions,id_orders,count_of_goods);
/*Добавлено 1000 значений издания-к-поступлению-товара*/
load data infile 
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\editions_to_entrances.csv'
into table editions_to_entrances
fields terminated by ','
ignore 1 lines
(id_editions,id_entrances,count_of_entrance);
/*Добавлено 1000 товаров*/
load data infile 
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\goods.csv'
into table goods
fields terminated by ','
ignore 1 lines
(book_name,age_restrictions,id_editions,id_themes);
/*Добавлено 1000 значений товары-к-клиентам*/
load data infile 
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\goods_to_clients.csv'
into table goods_to_clients
fields terminated by ','
ignore 1 lines
(id_goods,id_clients,`datetime`);