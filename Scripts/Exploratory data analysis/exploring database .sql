/*
exploring tables , columns and dimensions of our database before performing analysis
*/

SELECT * from information_schema.tables

select * from INFORMATION_SCHEMA.columns
where table_name='dim_customer';
to see the column names of only customer dimensions
exploring dimensions:
select distinct country from gold.dim_customer;
select distinct country from gold.dim_customer;
select distinct category, subcategory , product_name from gold.dim_products
 order by 1,2,3;
