/*
=======================================================================
this script gives category wise report of the sales data like:
  * total customers by country
  * total customers by gender
  * avg product cost in each category
  * total revenue of each category 
  * total spending of each customer
  * sale volume from each country
=======================================================================
*/  
select country, count(*) total_customer from gold.dim_customer 
group by country
order by count(*) desc;
select gender, count(*) total_customer from gold.dim_customer 
group by gender
order by count(*) desc;


select category, avg(product_cost) Avg_product_cost from gold.dim_products
group by Category order by avg(product_cost) DESC ;



select pr.category, sum(sls.sales_amount) total_revenue
from gold.fact_sales sls 
left join  gold.dim_products pr 
on sls.product_key= pr.product_key
group by pr.Category
;

select c.customer_key , c.first_name,c.last_name,sum(f.sales_amount) as total_spending
from gold.fact_sales f left join
gold.dim_customer c on f.customer_key =c.customer_key
group by c.customer_key , c.first_name,c.last_name order by sum(f.sales_amount) DESC;

select c.country,sum(f.quantity) as sale_volume
from gold.fact_sales f left join
gold.dim_customer c on f.customer_key =c.customer_key
group by c.country order by sum(f.quantity) DESC;
