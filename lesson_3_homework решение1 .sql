--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������. �������: ����� � ����� ����������� ��������.

select count(*) from classes full outer join ships on classes.class = ships.class
full outer join outcomes on ships.name = outcomes.ship where result = 'sunk' group by classes.class

--task2
--�������: ��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� ����� ������.
-- ���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������ �� ���� �������� ����� ������. �������: �����, ���.

select ships.class, min(launched) from ships group by ships.class 

--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� � �� ����� 3 �������� � ���� ������, ������� ��� ������ � ����� ����������� ��������.

select a.class, a.num from (select classes.class, count(ship) as num from outcomes inner join ships on outcomes.ship = ships.name inner join classes on classes.class = ships.class
where result = 'sunk'
group by classes.class ) a where a.num >= 3 

--task4
--�������: ������� �������� ��������, ������� ���������� ����� ������ ����� ���� �������� ������ �� ������������� (������ ������� �� ������� Outcomes).

select name, max(numguns),  displacement from classes inner join ships on classes.class = ships.class group by displacement, name 
union 
select ship, max(numguns),  displacement from classes inner join outcomes on classes.class = outcomes.ship group by displacement, ship 

--task5
--������������ �����: ������� �������������� ���������, ������� ���������� �� � ���������� ������� RAM � � ����� ������� ����������� ����� ���� ��,
-- ������� ���������� ����� RAM. �������: Maker

select distinct maker from product inner join pc on product.model = pc.model
where maker in (select distinct maker from product inner join printer on product.model = printer.model)
and pc.model in (select model from pc where ram = (select min(ram) from pc ) and speed = (select max(speed) from pc where ram = (select min(ram) from pc )))


