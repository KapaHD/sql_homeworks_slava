--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--Задание 1: Вывести name, class по кораблям, выпущенным после 1920

select name, class from ships
where launched > 1920

--Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942

select name, class from ships
where launched between 1920 and 1942

--Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class

select class , count(name) as Количество from ships group by class
 
--Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)

select class, country from classes where bore >= 16 

--Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.

select ship from outcomes where result = 'sunk' and battle = 'North Atlantic'

--Задание 6: Вывести название (ship) последнего потопленного корабля

select ship from battles 
left join outcomes on battles.name = outcomes.battle 
where  date = (select max(date) from battles join outcomes on battles.name = outcomes.battle ) and result = 'sunk'

--Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля

Select a.ship, a.class from (
Select ship, class, date from Outcomes full outer join Battles on Outcomes.battle = Battles.name join Classes on Classes.class=Outcomes.ship  where result = 'sunk'
union
Select ship, Classes.class, date from Outcomes full outer join Battles on Outcomes.battle = Battles.name join Ships on Outcomes.ship = Ships.name join Classes on Classes.class=Ships.class  where result = 'sunk') as a where a.date = (select max(date) from (Select ship, class, date from Outcomes full outer join Battles on Outcomes.battle = Battles.name join Classes on Classes.class=Outcomes.ship  where result = 'sunk'
union
Select ship, Classes.class, date from Outcomes full outer join Battles on Outcomes.battle = Battles.name join Ships on Outcomes.ship = Ships.name join Classes on Classes.class=Ships.class  where result = 'sunk') as d)


--Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class

select ship, classes.class from classes 
inner join outcomes on classes.class = outcomes.ship
where bore >= 16 and result = 'sunk' 

--Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class

select class from classes where country = 'USA'

--Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class

select name, ships.class from ships left join classes on classes.class = ships.class where country = 'USA'
