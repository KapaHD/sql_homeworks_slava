--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type

select pc.model, maker, type from product inner join pc on product.model = pc.model 
union
select printer.model, maker, printer.type from product inner join printer on product.model = printer.model 
union
select laptop.model, maker, type from product inner join laptop on product.model = laptop.model 

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"

select *,
case
 	when price > (select avg(price) from pc)
	then 1
	else 0
	end column1
 from printer

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)
	
select * from outcomes full join ships on ships.name = outcomes.ship 
where class is null
	
--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.

select name from battles 
where extract(year from battles.date) not in (select launched from ships)

--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select * from outcomes inner join ships on outcomes.ship = ships.name
where class = 'Kongo'


--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag

create view all_products_flag_300 as 

	select laptop.price, laptop.model, case when price > 300 then 1 else 0 end as flag from laptop
	union 
	select printer.price, printer.model, case when price > 300 then 1 else 0 end as flag from printer 
	union 
	select pc.price, pc.model, case when price > 300 then 1 else 0 end as flag from pc 
	

--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag

create view all_products_flag_avg_price as 	

select laptop.price, laptop.model, case when price > (select avg(price) from laptop) then 1 else 0 end as flag from laptop
union
select printer.price, printer.model, case when price > (select avg(price) from printer) then 1 else 0 end as flag from printer
union
select pc.price, pc.model, case when price > (select avg(price) from pc) then 1 else 0 end as flag from pc

	
--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model

select * from printer inner join product on printer.model = product.model 
where maker = 'A' and price > (select avg(price) from printer inner join product on printer.model = product.model where maker in ('D', 'C') )

--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)

select avg(a.price) from 
(
select product.model, price from product  
inner join printer on product.model = printer.model where maker = 'A'
union
select product.model, price from product
inner join pc on pc.model = product.model where maker = 'A'
union 
select product.model, price from product
inner join laptop on laptop.model = product.model where maker = 'A'
) as a

--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count

create view count_products_by_makers as 

select a.maker,sum(a.count) from
(
select maker, count(type)  from product inner join laptop on  product.model = laptop.model group by maker
union
select maker, count(type)  from product inner join pc on  product.model = pc.model group by maker
union
select maker, count(printer.type)  from product inner join printer on  product.model = printer.model group by maker
) as a group by  maker

select * from count_products_by_makers

--*task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'

select * from printer inner join product on printer.model = product.model where maker <> 'D'
CREATE TABLE printer_updated as select code, printer.model, color, printer.type, price from printer inner join product on printer.model = product.model where maker <> 'D'

select * from printer_updated

--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)

create view printer_updated_with_makers as select  code, printer_updated.model, color, printer_updated.type, price, maker from printer_updated 
inner join product on printer_updated.model = product.model 

select * from printer_updated_with_makers

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). 
--Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)





--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)





--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag:
-- если количество орудий больше или равно 9 - то 1, иначе 0

create table classes_with_flag  as select *, case
	when numGuns >= 9
	then 1
	else 0
	end as Flag 
from classes
select * from classes_with_flag


--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)


--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".


select count(*) from (select * from ships where name like 'О%' or name like 'M%') as a


--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.

select count(*) from (select * from ships where name like '% %') as a


--*task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)



