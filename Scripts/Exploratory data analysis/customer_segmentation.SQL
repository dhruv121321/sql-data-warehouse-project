-- group the data based on specific range . helps understand correlation between two measures

-- [measure] by [measure]

-- segment products into cost range and count how many products fall into each segment
with product_segmentation as (
select product_key,
product_name,
product_cost,
case when product_cost <100 then 'below 100'
when product_cost between 100 and 500 then '100-500'
when product_cost between 500 and 1000 then '500-1000'
else 'above 1000'
end product_segment
from gold.dim_products)
select product_segment, count(product_key) total_products from product_segmentation
group by product_segment order by total_products desc;
-- group customer into 3 segments:
-- vip: at least 12 month lifespan and 5000+ spent
-- regular: 12 month lifespan and spent 5000 or less
-- new: lifespan less than 12 month
with customer_behavior as(
select customer_key , datediff(month,min(order_date), max(order_date)) lifespan
, sum(sales_amount) money_spent

from gold.fact_sales group by customer_key 
)
select
case when lifespan>=12 and money_spent>5000 then 'VIP'
when lifespan>=12 and money_spent<=5000 then 'Regular'
else 'New'
end Customer_segment, 
count(customer_key) total_customers

from customer_behavior group by
case when lifespan>=12 and money_spent>5000 then 'VIP'
when lifespan>=12 and money_spent<=5000 then 'Regular'
else 'New'
end
-- could have used subquery here , its fine
;
