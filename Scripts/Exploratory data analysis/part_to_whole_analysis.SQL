-- ([measure]/total[measure])*100 by [dimension]
-- which category contribute most to the overall sales?


with category_sales as (
select p.category,
sum(cast(f.sales_amount as float)) total_sales
from gold.fact_sales f
left join gold.dim_products p
on f.product_key=p.product_key 
group by p.category)

select category,
total_sales,
concat(round(((total_sales/sum(total_sales) over())*100),3),'%') category_contribution
from category_sales order by round(((total_sales/sum(total_sales) over())*100),3) desc ;
