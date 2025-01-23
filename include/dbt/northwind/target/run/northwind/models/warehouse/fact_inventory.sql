
  create or replace   view dbt_dev.public.fact_inventory
  
   as (
    
with source as (
    select
        id as inventory_id,
        transaction_type,
        date(transaction_created_date) as transaction_created_date,
        transaction_modified_date,
        product_id,
        quantity,
        purchase_order_id,
        customer_order_id,
        comments,
        current_timestamp() as insertion_timestamp,
    from dbt_dev.public.inventory_transactions
)
select * 
from source
  );

