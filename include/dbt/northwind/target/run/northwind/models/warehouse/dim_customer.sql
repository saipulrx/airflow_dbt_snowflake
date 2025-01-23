
  create or replace   view dbt_dev.public.dim_customer
  
   as (
    with source as (
    select *
    from dbt_dev.public.customer
)
select 
    *,
    current_timestamp() as ingestion_timestamp
from source
  );

