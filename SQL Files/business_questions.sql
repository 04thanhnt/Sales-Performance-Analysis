-- 1/ Find out number of orders, unique products, customers, and product categories
select count(orderid) as no_of_orders,
	   count(distinct productname) as no_of_products,
	   count(distinct customerid) as no_of_customers,
	   count(distinct productcategory) as no_of_product_categories
from vw_full_orders

--2/ Find out the unique products and their categories and theirs prices in the full_orders dataset
select productname,
	   productcategory, 
	   price
from vw_full_orders
group by productname, productcategory,price
order by price desc

--3/Average price, revenue of products,number of orders in each product category during the period of 2023-2025
select productcategory, 
       avg(price) average_price, 
	   avg(revenue) average_revenue,
	   count(orderid) as no_of_orders
from vw_full_orders
group by productcategory
order by avg(price) desc

--4/ Orders in each year per region, with revenue and gross profit calculated
select year(orderdate) as order_year, 
	   region, 
	   count(orderid) as no_of_orders,
	   count(orderid)/ count(distinct month(orderdate)) as avg_no_of_orders_per_month,
	   sum(revenue) as total_revenue,
	   sum(revenue)/ count(distinct month(orderdate)) as avg_revenue_per_month,
	   sum(gross_profit) as total_gross_profit,
	   sum(gross_profit)/ count(distinct month(orderdate)) as avg_gross_profit_per_month
from vw_full_orders
group by year(orderdate),region
order by region,count(orderid)/ count(distinct month(orderdate)) desc

--5/which products are sold the most (top 3) for each region during the period of Jan 2023- Nov 2025 and how many units for each of those products
select order_year, 
	   region,
	   productname, 
	   productcategory, 
	   total_quantity
from (
		select year(orderdate) as order_year, 
			   region, 
			   productname, 
			   productcategory,
			   sum(quantity) as total_quantity,
			   row_number() over(partition by region order by sum(quantity) desc ) as ranking
		from vw_full_orders
		group by year(orderdate), region, productname, productcategory
		) t
where ranking <=3

--6/ The number of customers in each region during the period of Jan 2023- Nov 2025 and their contribution to the total revenue
select region, 
	   count(distinct customerid) as no_of_customers,
	   sum(revenue) as total_revenue,
	   round(sum(revenue)/(select sum(revenue) from vw_full_orders),2) as revenue_contribution
from vw_full_orders
group by region

--7/Revenue contribution of each bought products
select productid, 
	   productname,
	   productcategory, 
	   sum(revenue) as total_revenue, 
	   sum(revenue)/(select sum(revenue) from vw_full_orders) as revenue_contribution
from vw_full_orders
group by productid, productname, productcategory
order by sum(revenue) desc

-- 8/ Find out the number of orders, number of customers, and total revenue for each month during the period of Jan 2023- Nov 2025 to see which month has the most revenue
select year(orderdate) as order_year,
	   datename(month,orderdate) as order_month,
	   count(distinct orderid) as no_of_orders,
	   count(distinct customerid) as no_of_customers,
	   sum(revenue) as total_revenue
from vw_full_orders
group by year(orderdate), datename(month,orderdate)
order by sum(revenue) desc

--9/ Customers who have generated revenue the most(top 3) in each region during the period of Jan 2023- Nov 2025 and how many  products  for each of those customers 
select order_year, region, customerid, total_quantity, total_revenue
from (
		select year(orderdate) as order_year, 
			   region, 
			   customerid,
			   sum(quantity) as total_quantity,
			   sum(revenue) as total_revenue,
			   row_number() over(partition by region order by sum(revenue) desc ) as ranking
		from vw_full_orders
		group by year(orderdate), region, customerid
		) t
where ranking <=3
order by region, total_revenue desc

--10/ Analyze MoM growth in revenue, gross profit and gross margin  for each region during the period of Jan 2023- Nov 2025
select year(orderdate) as order_year, 
	   month(orderdate) as order_month, 
	   region,
	   sum(revenue) as total_revenue,
	   sum(gross_profit) as total_gross_profit,
	   round(sum(gross_profit)/sum(revenue),2) as gross_margin,
	   sum(revenue) - lag(sum(revenue)) over(partition by region order by year(orderdate), month(orderdate)) as revenue_MoM_growth,
	   sum(gross_profit) - lag(sum(gross_profit)) over(partition by region order by year(orderdate), month(orderdate)) as gross_profit_MoM_growth,
	   round((sum(gross_profit)/sum(revenue)) - (lag(sum(gross_profit)/sum(revenue)) over(partition by region order by year(orderdate), month(orderdate))),2) as gross_margin_MoM_growth
from vw_full_orders
group by year(orderdate), month(orderdate), region
order by region , year(orderdate), month(orderdate) asc

--11/ Top customers contributed to the revenue
select top 10 customerid, 
	   sum(revenue) as total_revenue , 
	   sum(quantity) as total_quantity
from vw_full_orders
group by customerid
order  by sum(revenue) desc

--12/ Top products contributed to the revenue
select top 10 productid,
	   productname,
	   sum(revenue) as total_revenue,
	   sum(quantity) as total_quantity
from vw_full_orders
group by productid,productname
order by sum(revenue) desc

--13/ Running Revenue
select order_year, 
	   order_month, 
	   region, 
	   total_revenue, 
	   sum(total_revenue) over(partition by region order by order_year, order_month) as running_revenue
from (
		select year(orderdate) as order_year, 
			   month(orderdate) as order_month, 
			   region,
			   sum(revenue) as total_revenue
		from vw_full_orders
		group by year(orderdate), month(orderdate), region
		) t
group by order_year, order_month, region, total_revenue

--14/Pareto analysis by products
/*with product_sales as
(
    select
        productname,
		productcategory,
        sum(revenue) as total_revenue
    from vw_full_orders
    group by productname,productcategory
)

select
    productname, 
	productcategory,
    total_revenue,
    sum(total_revenue) over (order by total_revenue desc) as cumulative_revenue,
    round(100.0 * sum(total_revenue) over (order by total_revenue desc) / sum(total_revenue) over(),2) as cumulative_percentage
from product_sales
order by total_revenue desc;
--> To generate 80% of the revenue, there are at least 11 products that need to be sold.*/