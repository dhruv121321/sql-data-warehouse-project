/*
analysing:
        oldest and latest orders
        birth date and age of oldest and youngest customers

*/
select min(order_date) min_order_date,
      max(order_date) max_order_date,
      datediff(year,min(order_date),
      max(order_date)) order_range_year
from gold.fact_sales;

select min(birth_date) oldest_customer_birth_date,
datediff(year,min(birth_date),getdate()) oldest_customer_age
,
max(birth_date) youngest_customer_birth_date ,
datediff(year,max(birth_date),getdate()) youngest_customer_age
from gold.dim_customer
; 
