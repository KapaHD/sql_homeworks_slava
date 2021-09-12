--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- ������������ �����: ������� view (pages_all_products), � ������� ����� ������������ �������� ���� ���������
-- (�� ����� ���� ��������� �� ����� ��������). �����: ��� ������ �� laptop, ����� ��������, ������ ���� �������

Create view pages_all_products 
as
SELECT *, 
      CASE WHEN num % 2 = 0 THEN num/2 ELSE num/2 + 1 END AS page_num, 
      CASE WHEN total % 2 = 0 THEN total/2 ELSE total/2 + 1 END AS num_of_pages
FROM (
      SELECT *, ROW_NUMBER() OVER(ORDER BY price DESC) AS num, 
             COUNT(*)

 OVER() AS total 
      FROM Laptop
) as X;


--task2 (lesson5)
-- ������������ �����: ������� view (distribution_by_type), � ������ �������� ����� ���������� ����������� ���� ������� �� ���� ����������.
-- �����: �������������,

create view distribution_by_type

as

select maker, model, type, 100*count(*)
 over(partition by type)/count(*)
 over() as model_percent
from 
(
select maker, product.model, product.type from product inner join pc on product.model = pc.model
union
select maker, product.model, product.type from product inner join laptop on product.model = laptop.model
union
select maker, product.model, product.type from product inner join printer on product.model = printer.model
) as t


--*task3 (lesson5)
-- ������������ �����: ������� �� ���� ����������� view ������ - �������� ���������

select * from distribution_by_type
https://colab.research.google.com/drive/1dN_rS7wrYa3PAZLFdwvwCgU9D87D_KIX?hl=ru#scrollTo=UhRcsPMziV0p&uniqifier=4

--task4 (lesson5)
-- �������: ������� ����� ������� ships (ships_two_words), �� � �������� ������� ������ �������� �� ���� ����

create table ships_two_words as select * from ships where name like '% %'

select * from ships_two_words


--task5 (lesson5)
-- �������: ������� ������ ��������, � ������� class ����������� (IS NULL) � �������� ���������� � ����� "S"

select * from ships where class is null and name like 'S%'

--task6 (lesson5)
-- ������������ �����: ������� ��� �������� ������������� = 'A' 
--�� ���������� ���� ������� �� ��������� ������������� = 'C' � ��� ����� ������� (����� ������� �������). ������� model

select printer.model 
from printer 
join product
on printer.model = product.model 
where maker = 'A' and price > (
	select avg(price)
	from product  
	join printer 
	on product.model = printer.model 
	where maker = 'C'
)
union all
select model from (
select model, row_number() over (order by price) as rn 
from printer 
) a 
where rn < 4