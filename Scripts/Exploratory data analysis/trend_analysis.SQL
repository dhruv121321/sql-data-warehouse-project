--sales trend analysis by year and by month

select  year(order_date) year,month(order_date) month ,sum(sales_amount) sale_amount
 ,count(distinct customer_key) total_customers,
 sum(quantity) total_quantity
 from gold.fact_sales 
 where order_date is not null 
 group by year(order_date), month(order_date)
 order by year(order_date), month(order_date) desc;

 -- we can achieve same result using date trunc, without making 
 -- separate column for year and month

 select  datetrunc(month,order_date) order_date ,sum(sales_amount) sale_amount
 ,count(distinct customer_key) total_customers,
 sum(quantity) total_quantity
 from gold.fact_sales 
 where order_date is not null 
 group by datetrunc(month,order_date)
 order by datetrunc(month,order_date) desc;
