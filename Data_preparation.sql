/* Data Preparation 
Merge all 3 tables Orders_2023, Orders_2024, and Orders_2025 into one view vw_full_orders, with customer and product information included.
Besides, calculate the following metrics:
revenue = if revenue is null, then use price * quantity
gross_profit = revenue - cogs
gross_margin = gross_profit / revenue
*/

create view vw_full_orders as
with full_orders as (
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
join orders_2023 o on c.customerid= o.customerid
join products p on o.productid= p.productid

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
join orders_2024 o on c.customerid= o.customerid
join products p on o.productid= p.productid

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
join orders_2025 o on c.customerid= o.customerid
join products p on o.productid= p.productid
) 

select  customerid, 
	    region, 
        customerjoindate, 
        orderid, 
        orderdate, 
        productid, 
        productname, 
        productcategory, 
        price, 
        quantity, 
        base_cost, 
        coalesce(revenue,price * quantity) as revenue, 
        cogs,
        coalesce(revenue,price * quantity) - cogs as gross_profit,
        (coalesce(revenue,price * quantity) - cogs ) / coalesce(revenue,price * quantity)  as gross_margin
from full_orders
