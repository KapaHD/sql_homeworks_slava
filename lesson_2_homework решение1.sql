--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--������� 1: ������� name, class �� ��������, ���������� ����� 1920

select name, class from ships
where launched > 1920

--������� 2: ������� name, class �� ��������, ���������� ����� 1920, �� �� ������� 1942

select name, class from ships
where launched between 1920 and 1942

--������� 3: ����� ���������� �������� � ������ ������. ������� ���������� � class

select class , count(name) as ���������� from ships group by class
 
--������� 4: ��� ������� ��������, ������ ������ ������� �� ����� 16, ������� ����� � ������. (������� classes)

select class, country from classes where bore >= 16 

--������� 5: ������� �������, ����������� � ��������� � �������� ��������� (������� Outcomes, North Atlantic). �����: ship.

select ship from outcomes where result = 'sunk' and battle = 'North Atlantic'

--������� 6: ������� �������� (ship) ���������� ������������ �������

select ship from battles 
left join outcomes on battles.name = outcomes.battle 
where  date = (select max(date) from battles join outcomes on battles.name = outcomes.battle ) and result = 'sunk'

--������� 7: ������� �������� ������� (ship) � ����� (class) ���������� ������������ �������

Select a.ship, a.class from (
Select ship, class, date from Outcomes full outer join Battles on Outcomes.battle = Battles.name join Classes on Classes.class=Outcomes.ship  where result = 'sunk'
union
Select ship, Classes.class, date from Outcomes full outer join Battles on Outcomes.battle = Battles.name join Ships on Outcomes.ship = Ships.name join Classes on Classes.class=Ships.class  where result = 'sunk') as a where a.date = (select max(date) from (Select ship, class, date from Outcomes full outer join Battles on Outcomes.battle = Battles.name join Classes on Classes.class=Outcomes.ship  where result = 'sunk'
union
Select ship, Classes.class, date from Outcomes full outer join Battles on Outcomes.battle = Battles.name join Ships on Outcomes.ship = Ships.name join Classes on Classes.class=Ships.class  where result = 'sunk') as d)


--������� 8: ������� ��� ����������� �������, � ������� ������ ������ �� ����� 16, � ������� ���������. �����: ship, class

select ship, classes.class from classes 
inner join outcomes on classes.class = outcomes.ship
where bore >= 16 and result = 'sunk' 

--������� 9: ������� ��� ������ ��������, ���������� ��� (������� classes, country = 'USA'). �����: class

select class from classes where country = 'USA'

--������� 10: ������� ��� �������, ���������� ��� (������� classes & ships, country = 'USA'). �����: name, class

select name, ships.class from ships left join classes on classes.class = ships.class where country = 'USA'
