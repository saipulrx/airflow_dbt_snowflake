
  create or replace   view dbt_dev.public.mart_top_customer_buy
  
   as (
    with count as (
    select 
    concat(c.first_name,'',c.last_name) customer_name,
    count(fp.quantity) as total_quantity
    from fact_purchase_order fp
    inner join customer c
    on fp.customer_id = c.id
    group by concat(c.first_name,'',c.last_name)
)
select 
    customer_name, 
    total_quantity
from count
where total_quantity > 10
  );

