-- help in understanding wheather bussiness is growing or declining over time
-- calculate the total sales each month and thr running total of sales over time
select order_date, 
total_sales,
sum(total_sales) over(partition by order_date order by order_date) as running_total_sales,
avg(total_sales) over(partition by order_date order by order_date) as moving_average
from( 
select 
datetrunc(month,order_date) order_date,
sum(sales_amount) total_sales
from gold.fact_sales where order_date is not null
group by  datetrunc(month,order_date)
)t;

-- by year
select order_date, 
total_sales,
sum(total_sales) over( order by order_date) as running_total_sales,
avg(total_sales) over(partition by order_date order by order_date) as average_total_sales
from( 
select 
datetrunc(year,order_date) order_date,
sum(sales_amount) total_sales
from gold.fact_sales where order_date is not null
group by  datetrunc(year,order_date)
)t;
