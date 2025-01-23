
  create or replace   view dbt_dev.public.mart_sum_price_by_product
  
   as (
    with source as (
    select 
    p.product_name,
    sum(fs.quantity * fs.unit_price) sum_price
    from dbt_dev.public.fact_sales fs
    inner join dbt_dev.public.products p
    on fs.product_id = p.id
    where fs.quantity > 99
    group by p.product_name
)

select 
    *
from source
  );

