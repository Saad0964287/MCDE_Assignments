/*2.1. Write a query that lists every product with its brand name, 
using production.products and production.brands.*/

select * from production.products
select * from production.brands


select 
br.brand_id,
pr.product_name,
br.brand_name
from production.brands as BR
left join production.products as PR
	on BR.brand_id  = PR.brand_id;


/*2.2. Using a LEFT JOIN, write a query that finds every store with zero staff currently assigned to it.*/

select * from sales.stores
select * from sales.staffs

select
SLST.store_id,
SLST.store_name,
SLSF.first_name + ' ' + last_name as staff_name,
SLSF.staff_id
from sales.stores as SLST
left join sales.staffs as SLSF
	on SLST.store_id = SLSF.store_id
where SLSF.staff_id is null;


/*2.3. Explain, in your own words, why the following query returns every product regardless of stock level, 
and rewrite it so that it only returns products with fewer than 5 units in stock at store 1:*/

Select 
p.product_name, 
s.quantity
from production.products AS p
LEFT JOIN production.stocks AS s
    ON p.product_id = s.product_id AND s.quantity < 5 AND s.store_id = 1
	where s.quantity is not null;


/*2.4. Write a self join on sales.staffs that lists every manager 
along with a count placeholder column showing 1 for each employee they manage 
(you will replace this with a real COUNT in Chapter 3); for now, 
just produce one row per employee-manager pair.*/


select * from sales.staffs 

select
t2.staff_id as manager_id,
t2.first_name +' '+ t1.last_name as employee_name,
t1.staff_id as employee_id,
t1.first_name +' '+ t2.last_name as manager_name
from sales.staffs as t1
inner join sales.staffs as t2
	on t1.staff_id = t2.manager_id



/*2.5. Write a three-table join across sales.orders, sales.order_items,
and production.products that lists every item in order #1, including product name and quantity.*/

select * from sales.orders
select * from sales.order_items
select * from production.products


select
t1.order_id,
t2.product_id,
t3.product_name,
t2.quantity,
t3.list_price
from sales.orders as t1
inner join sales.order_items as t2
	on t1.order_id = t2.order_id
inner join production.products as t3
	on t2.product_id = t3.product_id


/*2.6. A colleague joins orders to order_items and reports 
"we received 4,658 orders last year." 
Explain what actually went wrong with that number and 
how you would find the true order count instead.*/


select * from sales.orders
select * from sales.order_items



select 
count(order_id)
from sales.orders
where order_date = '2018-01-01' and order_date < '2019-01-01'




select 
t1.order_id, 
t2.product_id,
count(distinct t1.order_id) as total_order_last_year

from sales.orders as t1
inner join sales.order_items as t2
on t1.order_id = t2.order_id

group by t1.order_id, t2.product_id



/*2.7. Think About It: CROSS JOIN is often considered dangerous 
because it can accidentally produce millions of rows from two innocent-looking tables. 
Under what real circumstances would you deliberately want a CROSS JOIN, 
and how would you guard against using one by accident, 
for example, by forgetting an ON clause that was meant to be there?*/


/*Answer: A cross join is usefull when we want every possible combination of rows,
to avoid the accidentally use of cross join we will use inner join with the correct on condition.









