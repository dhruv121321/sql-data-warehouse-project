/*
============================================================
This script give sthe statistical report of the data.
it shows aggregated result:
 * total sales
 * total quantity
 * average price
 * Total orders
 * total products
 * total customers
 * total customers that ordered
=============================================================
*/

select 'Total Sales' as measure_name,sum(sales_amount) measure_value from gold.fact_sales
union all
select 'Total Quantity',count(quantity) from gold.fact_sales
union all
select 'Average Price' ,avg(price) from gold.fact_sales union all
select 'total orders', count(distinct order_number)from gold.fact_sales
union all
select  'total products ',count(distinct product_name) from
gold.dim_products
union all
select 'total_customers',count(customer_key) from gold.dim_customer
union all
-- customer that has placed orders
select 'customers that ordered',count(distinct customer_key) from gold.fact_sales;
