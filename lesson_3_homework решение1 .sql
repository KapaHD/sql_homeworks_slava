--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.

select count(*) from classes full outer join ships on classes.class = ships.class
full outer join outcomes on ships.name = outcomes.ship where result = 'sunk' group by classes.class

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса.
-- Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.

select ships.class, min(launched) from ships group by ships.class 

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.

select a.class, a.num from (select classes.class, count(ship) as num from outcomes inner join ships on outcomes.ship = ships.name inner join classes on classes.class = ships.class
where result = 'sunk'
group by classes.class ) a where a.num >= 3 

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).

select name, max(numguns),  displacement from classes inner join ships on classes.class = ships.class group by displacement, name 
union 
select ship, max(numguns),  displacement from classes inner join outcomes on classes.class = outcomes.ship group by displacement, ship 

--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК,
-- имеющих наименьший объем RAM. Вывести: Maker

select distinct maker from product inner join pc on product.model = pc.model
where maker in (select distinct maker from product inner join printer on product.model = printer.model)
and pc.model in (select model from pc where ram = (select min(ram) from pc ) and speed = (select max(speed) from pc where ram = (select min(ram) from pc )))


