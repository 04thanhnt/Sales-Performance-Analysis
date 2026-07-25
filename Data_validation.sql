select
    c.customerid,
    c.region,
    c.customerjoindate,
    o.orderid,
    o.orderdate,
    o.revenue,
    o.quantity,
    o.cogs,
    p.productid,
    p.productname,
    p.productcategory,
    p.price,
    p.base_cost
into #full_orders
from customers c
join orders_2023 o
    on c.customerid = o.customerid
join products p
    on o.productid = p.productid

union all

select
    c.customerid,
    c.region,
    c.customerjoindate,
    o.orderid,
    o.orderdate,
    o.revenue,
    o.quantity,
    o.cogs,
    p.productid,
    p.productname,
    p.productcategory,
    p.price,
    p.base_cost
from customers c
join orders_2024 o
    on c.customerid = o.customerid
join products p
    on o.productid = p.productid

union all

select
    c.customerid,
    c.region,
    c.customerjoindate,
    o.orderid,
    o.orderdate,
    o.revenue,
    o.quantity,
    o.cogs,
    p.productid,
    p.productname,
    p.productcategory,
    p.price,
    p.base_cost
from customers c
join orders_2025 o
    on c.customerid = o.customerid
join products p
    on o.productid = p.productid;

-- 1/ Check if data has any null values or not
select
    sum(case when customerid IS NULL then 1 else 0 end) as null_customerid,
    sum(case when revenue IS NULL then 1 else 0 end) as null_revenue
from #full_orders
--> There are 41 null values for 'Revenue', it will be modified by revenue = price * quantity

-- 2/ Check duplicate orders
select
    orderid,
    count(*) AS cnt
from #full_orders
group by orderid
having count(*) > 1

--> No duplicate orders

-- 3/ Check if exists any negative values
select *
from #full_orders
where quantity <= 0
   or revenue < 0
   or cogs < 0
   or price < 0
   or base_cost < 0
 --> No negative values

-- 4/Check if exists any productid has more than 1 name
select
    productid,
    count(distinct productname) as cnt
from #full_orders
group by productid
having count (distinct productname) > 1
--> No id has more than 1 product

-- 5/ Check if revenue actually equals to price * quantity
select
    count(*) as inconsistent_rows
from #full_orders
where abs(revenue - price * quantity) > 0.01

--After checking, this temp table can be dropped
drop table #full_orders