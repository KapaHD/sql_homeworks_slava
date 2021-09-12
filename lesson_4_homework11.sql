--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). �������: model, maker, type

select pc.model, maker, type from product inner join pc on product.model = pc.model 
union
select printer.model, maker, printer.type from product inner join printer on product.model = printer.model 
union
select laptop.model, maker, type from product inner join laptop on product.model = laptop.model 

--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, � ���� ���� ����� ������� PC - "1", � ��������� - "0"

select *,
case
 	when price > (select avg(price) from pc)
	then 1
	else 0
	end column1
 from printer

--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)
	
select * from outcomes full join ships on ships.name = outcomes.ship 
where class is null
	
--task16 (lesson3)
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.

select name from battles 
where extract(year from battles.date) not in (select launched from ships)

--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.

select * from outcomes inner join ships on outcomes.ship = ships.name
where class = 'Kongo'


--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag

create view all_products_flag_300 as 

	select laptop.price, laptop.model, case when price > 300 then 1 else 0 end as flag from laptop
	union 
	select printer.price, printer.model, case when price > 300 then 1 else 0 end as flag from printer 
	union 
	select pc.price, pc.model, case when price > 300 then 1 else 0 end as flag from pc 
	

--task2  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag

create view all_products_flag_avg_price as 	

select laptop.price, laptop.model, case when price > (select avg(price) from laptop) then 1 else 0 end as flag from laptop
union
select printer.price, printer.model, case when price > (select avg(price) from printer) then 1 else 0 end as flag from printer
union
select pc.price, pc.model, case when price > (select avg(price) from pc) then 1 else 0 end as flag from pc

	
--task3  (lesson4)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model

select * from printer inner join product on printer.model = product.model 
where maker = 'A' and price > (select avg(price) from printer inner join product on printer.model = product.model where maker in ('D', 'C') )

--task5 (lesson4)
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)

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
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. �� view: maker, count

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
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)

--task8 (lesson4)
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'

select * from printer inner join product on printer.model = product.model where maker <> 'D'
CREATE TABLE printer_updated as select code, printer.model, color, printer.type, price from printer inner join product on printer.model = product.model where maker <> 'D'

select * from printer_updated

--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� �������� ������������� (�������� printer_updated_with_makers)

create view printer_updated_with_makers as select  code, printer_updated.model, color, printer_updated.type, price, maker from printer_updated 
inner join product on printer_updated.model = product.model 

select * from printer_updated_with_makers

--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes). 
--�� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)





--task11 (lesson4)
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)





--task12 (lesson4)
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag:
-- ���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0

create table classes_with_flag  as select *, case
	when numGuns >= 9
	then 1
	else 0
	end as Flag 
from classes
select * from classes_with_flag


--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)


--task14 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".


select count(*) from (select * from ships where name like '�%' or name like 'M%') as a


--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.




--*task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)



