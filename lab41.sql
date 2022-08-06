/*основная информация о книге*/
select goods.id_goods,`book_name`,authors.author_name, editions.year_of_publishing, themes.genre from `goods` 
left join `goods_to_authors` on goods.id_goods=goods_to_authors.id_goods
inner join `authors` on goods_to_authors.id_authors=authors.id_author
left join `editions` on goods.id_editions=editions.id_editions
left join `themes` on goods.id_themes=themes.id_themes;
/*проверка наличия книги в магазине*/
select goods.id_goods, `book_name`, `count_of_entrance`,`entrance_place` from `goods`
left join `editions` on goods.id_editions=editions.id_editions
left join `editions_to_entrances` on editions.id_editions=editions_to_entrances.id_editions
left join `entrances` on editions_to_entrances.id_entrances=entrances.id_entrances;
/*проверить дату поступления книги*/
select goods.id_goods, `book_name`, `count_of_entrance`,`entrance_date` from `goods`
left join `editions` on goods.id_editions=editions.id_editions
left join `editions_to_entrances` on editions.id_editions=editions_to_entrances.id_editions
left join `entrances` on editions_to_entrances.id_entrances=entrances.id_entrances;
/*проверить наличие акций*/
select goods.id_goods, `book_name`, `discount_name`, `discount_terms`,`amount` from `goods`
left join goods_to_discounts on goods.id_goods=goods_to_discounts.id_goods
left join discounts on discounts.id_discounts=goods_to_discounts.id_discounts;
/*6*/
create table if not exists `example` 
(`id_example` int not null auto_increment,
`column_1` int, 
`column_2` text,
`column_3` int, 
`column_4` datetime,
`column_5` int,
`column_6` int,
primary key (`id_example`));
insert into `example` (`column_1`, `column_2`, `column_3`,`column_4`, `column_5`, `column_6`) table `editions`;
select * from example;
/*2*/
update example set column_3=2000 where column_3=1000;
select * from example;
update example set column_4='2019-02-01 00:00:00'
where column_4='2002-02-01 00:00:00';
select * from example;
update example set column_5=250 where column_5=350;
select * from example;
update example set column_5=666 where column_5=300;
select * from example;
update example set column_2='Матовая твёрдая' where id_example=3;
select * from example;
/*3*/
delete from example where column_5=666;
delete from example where column_4='2022-02-01 00:00:00';
delete from example where column_5=1000;
select * from example;
drop table example;
/*5*/
select * from points where adress like '%90';
select * from goods where book_name not like 'g%';
select * from clients where contacts like '4%';
select * from publishing_houses where publishing_house like '_g%';
select * from authors where author_name not like 'Michael\r';
/*4*/
select distinct id_orders, id_clients from orders;
select distinct id_goods, id_clients from goods_To_clients;
select id_editions, price from editions where price=300;
select id_editions, count from editions where count=1000;
select id_editions, count, price from editions where count=1000 and price=300;
select * from cards where not amount_of_discount=5;
select * from goods where not id_themes=3;
select * from goods where id_editions=3 or age_restrictions=10;
select id_editions, year_of_publishing from editions where year_of_publishing in ('2000-01-01 00:00:00', '2002-02-01 00:00:00');
select * from editions where count in (1000,2000);
select * from editions where year_of_publishing between '2000-01-01 00:00:00' and '2010-02-01 00:00:00';
select * from entrances where entrance_date is not null;
select * from points where terms is not null;
select price as prices, year_of_publishing as publication_year from editions;
select entrance_place as adress from entrances;
/*7*/
select * from clients join orders on clients.id_clients=orders.id_clients;
select * from clients inner join orders on clients.id_clients=orders.id_clients;
select * from editions left join editions_to_orders on editions.id_editions=editions_to_orders.id_editions;
select editions.id_editions, id_orders from editions left join editions_to_orders on editions_to_orders.id_editions=editions.id_editions;
select editions.id_editions, id_orders, count_of_goods from editions left join editions_to_orders on editions.id_editions=editions_to_orders.id_editions;
select * from discounts right join goods_to_discounts on discounts.id_discounts=goods_to_discounts.id_discounts;
select * from authors full join goods_to_authors on id_author=goods_to_authors.id_authors;
select * from editions cross join goods;
select id_orders _id_clients, client_name from orders natural join clients;
select id_orders, id_clients, id_cards from orders natural join cards;
select * from orders natural join cards;
/*8*/
select `price`,`type`,sum(`count`) as sum from editions group by `price`;
select group_concat(`id_goods`) as books, `id_authors` from goods_to_authors group by `id_authors`;
select `id_editions`,`type`, min(`count`) from editions group by `type`;
select `book_name`, max(`age_restrictions`),`id_themes` from goods group by `age_restrictions` having `id_themes`=4;
select `book_name`, `id_themes`, avg(`age_restrictions`) from goods group by `book_name`;
select `id_orders`, `id_clients` from orders group by `id_clients`;
select `id_editions`, `count` from editions group by `id_editions` order by `count`;
select `id_editions`,`price` from editions group by `id_editions` order by `price`asc;
select `id_goods`, `age_restrictions` from goods group by `age_restrictions` order by `age_restrictions`asc;
select `id_entrances`,`entrance_date`,`entrance_place`from entrances group by `entrance_date` having `entrance_place`="Склад №1";
select `book_name`, `id_editions` from goods group by `book_name` having `id_editions`=3;
select `book_name`, `id_authors` from goods_to_authors, goods group by `book_name`;
select `book_name`, `id_authors` from goods_to_authors, goods where `id_authors`=3 group by `book_name`;
select `id_cards`, `amount_of_discount` from cards group by `id_cards` order by `amount_of_discount` desc;
select `discount_name`,`validity`from discounts group by `discount_name` having `validity`='2022-05-02 00:00:00';
select `id_orders`,`id_points` from orders group by `id_orders` having `id_points`<70;
select `id_editions`, `id_publishing_house` from editions group by `id_editions` having `id_publishing_house`=4;
/*9*/
select `id_goods`,`book_name` from goods union select `price`,`id_publishing_house` from editions;
select `id_goods`,`book_name` from goods union select `id_editions`,`type` from editions;
select `id_goods` from goods union select `id_editions` from editions;
select `id_editions` from editions union select `id_goods` from goods;
select `amount_of_discount` from cards union all select `amount` from discounts order by `amount_of_discount` desc;
select `book_name` from goods union select `publishing_house` from publishing_houses;
/*10*/
select `book_name`, group_concat(`id_editions`) as `edition` from goods where exists (select * from editions where id_publishing_house=4);
select group_concat(`book_name`) as books, `id_editions` from goods where exists (select * from editions where id_publishing_house=4);
select `id_editions`,`avg_price` from(select `id_editions`, avg(price) as avg_price from editions group by `id_editions`) goods;
select * from cards where amount_of_discount>(select avg(`amount_of_discount`) from cards);
select `id_editions`,`price` from editions where `price`>all(select `book_name` from goods where editions.id_editions=goods.id_editions);
select `id_discounts`,`amount` from discounts where `amount`>all(select `amount_of_discount` from cards);
/*11*/
select group_concat(`id_editions`) as edition,id_publishing_house from editions group by id_publishing_house;
select group_concat(`book_name`) as books from goods where exists (select * from goods_to_authors where id_authors=3);
select group_concat(`book_name`) as books, `id_editions` from goods where exists (select * from goods where id_editions>5);
/*12*/
with CTE_editions as (select * from editions) select * from cte_editions;
with cte_orders (`id_order`, `id_client`) as (select `id_orders`,`id_clients` from orders) select * from cte_orders;
/*13*/
select lower(`publishing_house`) as publishing_house from publishing_houses;
select *, DATE_FORMAT(entrance_date, '%d.%m%Y') as new_date from entrances;
select min(count) from editions;
select max(price) from editions;
select avg(price) from editions;

/*модификация*/
-- топ три книги по количеству лайков
select goods.book_name, count(goods_to_clients.id_goods) as count_of_likes 
from goods 
join goods_to_clients on goods.id_goods=goods_to_clients.id_goods
group by goods.book_name
order by count_of_likes desc limit 3;
-- все книги и цены авторов
select goods_to_authors.id_authors, authors.author_name, goods.book_name, editions.price from goods_to_authors 
left join authors on goods_to_authors.id_authors=id_author 
left join goods on goods.id_goods = goods_to_authors.id_goods
left join editions on goods.id_editions=editions.id_editions;
-- стоимость заказа
select clients.client_name, goods.book_name, 
round((1-cards.amount_of_discount/100) * (sum(editions.price*(1-discounts.amount/100)*editions_to_orders.count_of_goods)), 1) as total_amount 
from clients 
inner join orders on orders.id_clients=clients.id_clients
join editions_to_orders on orders.id_orders=editions_to_orders.id_orders
join editions on editions_to_orders.id_editions=editions.id_editions
join goods on goods.id_editions=editions.id_editions
join cards on cards.id_cards=clients.id_clients
join goods_to_discounts on goods.id_goods=goods_to_discounts.id_goods
join discounts on discounts.id_discounts=goods_to_discounts.id_discounts
group by orders.id_orders;

-- lab 5
set profiling = 1;
select * from points where adress like 'Lin%';
select * from goods where book_name not like 'g%';
select * from clients where contacts like '4%';
select * from publishing_houses where publishing_house like '_g%';
select * from authors where author_name like 'Michael\r';
show profiles; 
/*ИНДЕКСЫ*/
-- 1 
create index adress on points(adress);
drop index adress on points;
-- 2
create index book_name on goods(book_name);
drop index book_name on goods; 
-- 3
create index contact on clients(contacts);
drop index contact on clients;
-- 4
CREATE INDEX publishing_house ON publishing_houses(publishing_house);
drop index publishing_house on publishing_houses;
-- 5
create index `name` on authors(author_name);
drop index `name` on authors; 

/*Процедуры*/
drop procedure if exists MyProcWithPar1;
DELIMITER $$
CREATE PROCEDURE MyProcWithPar1()
BEGIN
select goods_to_authors.id_authors, authors.author_name, goods.book_name from goods_to_authors 
left join authors on goods_to_authors.id_authors=id_author 
left join goods on goods.id_goods = goods_to_authors.id_goods
left join editions on goods.id_editions=editions.id_editions;
END$$
DELIMITER ;
CALL  MyProcWithPar1();

drop procedure if exists MyProcWithPar2;
DELIMITER $$
create procedure MyProcWithPar2(discount int, card int)
begin
insert into discounts(amount) 
values (discount);
insert into cards(amount_of_discound)
values (card);
end$$
DELIMITER ;
call MyProcWithPar2(discounts,cards);

drop procedure if exists MyProcWithPar3;
DELIMITER $$
create procedure MyProcWithPar3()
begin
select goods_to_authors.id_authors, authors.author_name, goods.book_name, editions.price from goods_to_authors 
left join authors on goods_to_authors.id_authors=id_author 
left join goods on goods.id_goods = goods_to_authors.id_goods
left join editions on goods.id_editions=editions.id_editions;
 end$$
 DELIMITER ;
call MyProcWithPar3();

/*представления*/
-- 1
create view v_order as
SELECT *
FROM `orders`
WHERE orderdate > '2021-10-03 16:05:58';
select * from v_order;
drop view v_order;
-- 2 
create view v_client as 
select * from `clients`
where client_name like 'Potter Piper';
select * from v_client;
drop view v_client;
-- 3
create view v_books as
select goods_to_authors.id_authors, authors.author_name, goods.book_name from goods_to_authors 
left join authors on goods_to_authors.id_authors=id_author 
left join goods on goods.id_goods = goods_to_authors.id_goods
left join editions on goods.id_editions=editions.id_editions;
select * from v_books;
drop view v_books;
/*триггер*/
CREATE TRIGGER new_edition
AFTER UPDATE ON editions
FOR EACH ROW 
INSERT INTO editions(price)
VALUE(1000);
drop trigger new_edition;

/*Функции*/
-- 1
delimiter $$
create function MyFunc1(
param1 int,
param2 int,
param3 datetime,
param4 datetime) 
returns int
deterministic
begin
declare result int;
select count(*)
into result
from `discounts`
where amount between param1 and param2
and validity between param3 and param4;
return result;
end $$
delimiter ;
select MyFunc1(10,15, '2022-02-02 00:00::00','2022-06-23 00:00:00');
drop function MyFunc1;
-- 2
delimiter $$
create function MyFunc2(
discount int,
card int)
returns int
deterministic
begin
declare result int;
set result = discount + card;
return result;
end$$
delimiter ;
select MyFunc2(5,15);
drop function MyFunc2;
-- 3
delimiter $$
create function MyFunc3(
StartValue int)
returns int
deterministic
begin
declare income int;
set income = 0;
label1: while income<=10 do
set income = income + StartValue;
end while label1;
return income;
end$$
delimiter ;
select MyFunc3(5);
drop function MyFunc3;
/*Модификация*/
-- Ускорить запрос по выводу всех изданий в диапазоне цен и лет заданного типа составным индексом
select * from editions
where price between 1000 and 2000
and 
year_of_publishing between '2021-01-01 00:00:00' and '2022-01-01 00:00:00';
create index pricedate on editions(price,year_of_publishing);
drop index pricedate on editions;
-- Триггер после добавления заказа удалить все книги из избранного которые есть в заказе
CREATE TRIGGER new_good
AFTER UPDATE ON orders 
FOR EACH ROW 
DELETE FROM goods_to_clients
where new.id_clients=goods_to_clients.id_clients
and new.id_orders=editions_to_orders.id_orders
and editions.id_editions=goods.id_editions
and goods.id_goods=goods_to_clients.id_goods;
drop trigger new_good;
insert into orders (id_clients) values (1);
select * from orders where id_clients = 1;
insert into editions_to_orders(id_editions,id_orders) values (706,16234);
select * from goods_to_clients where id_clients = 1;
-- Функция на вход айди клиента и промежуток дат а возвращается суммарное количество купленных книг за время 
delimiter $$
create function MyFunc4(
IdClient int,
OrderDate1 datetime,
OrderDate2 datetime)
returns int
deterministic
begin
declare result int;
select count(editions_to_orders.id_editions) into result
from editions_to_orders
right join orders on editions_to_orders.id_orders = orders.id_orders
right join clients on orders.id_clients=clients.id_clients
where orderdate between OrderDate1 and OrderDate2
and IdClient=orders.id_clients;
return result;
end$$
delimiter ;
select MyFunc4(11,'2022-06-01 00:00:00','2022-06-23 00:00:00');
drop function MyFunc4;