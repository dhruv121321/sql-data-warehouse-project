--current[measure]- target[measure]
-- mom analysis, yoy analysis
/* 
analyse the yearly performance of products by comparing their sales to both
the average sales performance of the product and the previous year's sales
*/

with yearly_product_sales as(
select year(f.order_date) order_year,p.product_name,
sum(f.sales_amount) total_sales
from gold.fact_sales f 
left join gold.dim_products p 
on p.product_key=f.product_key where f.order_date is not null
group by year(f.order_date),p.product_name)

select order_year, 
product_name, 
total_sales,
avg(total_sales) over(partition by product_name) as avg_sales,
total_sales-avg(total_sales) over(partition by product_name) avg_diff,
case when total_sales-avg(total_sales) over(partition by product_name)<0
then 'Below Average'
when total_sales-avg(total_sales) over(partition by product_name) >0 then
'Above Average'
else 'average'
end 'avg change',
coalesce(lag(total_sales) over(partition by product_name order by order_year),0) py_sales
,
total_sales-coalesce(lag(total_sales) over(partition by product_name order by order_year),0)  Yoy


from 
yearly_product_sales 
order by product_name, order_year;
