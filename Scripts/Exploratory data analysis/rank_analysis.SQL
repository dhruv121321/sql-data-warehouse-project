/*
======================================================
this script ranks different dimension like:
* best 5 performing products
* worst 5 performing products
* best 5 performing subcategories
* worst 5 performing subcategories
* customer with most orders
* least orders customers
======================================================

*/
-- best 5 performing products
select top 5 p.product_name,sum( f.sales_amount) total_revenue
from gold.dim_products p
left join gold.fact_sales f on p.product_key=f.product_key
group by p.product_name order by sum( f.sales_amount)  desc;

-- worst 5 performing products
select top 5 p.product_name,sum( f.sales_amount) total_revenue
from gold.fact_sales f
left join gold.dim_products p on p.product_key=f.product_key
group by p.product_name order by sum( f.sales_amount) ;


-- best 5 performing subcategories
select top 5 p.Subcategory,sum( f.sales_amount) total_revenue
from gold.dim_products p
left join gold.fact_sales f on p.product_key=f.product_key
group by p.Subcategory order by sum( f.sales_amount)  desc;

-- worst 5 performing subcategories
select top 5 p.Subcategory,sum( f.sales_amount) total_revenue
from gold.fact_sales f
left join gold.dim_products p on p.product_key=f.product_key
group by p.Subcategory order by sum( f.sales_amount) ;

-- using window functions:
select * from (select p.product_name,sum(f.sales_amount) total_revenue,
ROW_NUMBER() over(order by sum(f.sales_amount) DESC) rank_product
from gold.fact_sales f
left join gold.dim_products p 
on f.product_key=p.product_key
group by p.product_name)t where rank_product<=5;

-- customer with most orders
select top 10 c.customer_key, c.first_name,c.last_name,
count(DISTINCT f.order_number) order_count from gold.fact_sales f left join
gold.dim_customer c on c.customer_key=f.customer_key
group by c.customer_key, c.first_name,c.last_name order by order_count DESC;

-- least orders customers
select top 10 c.customer_key, c.first_name,c.last_name,
count(DISTINCT f.order_number) order_count from gold.fact_sales f left join
gold.dim_customer c on c.customer_key=f.customer_key
group by c.customer_key, c.first_name,c.last_name order by order_count ;

