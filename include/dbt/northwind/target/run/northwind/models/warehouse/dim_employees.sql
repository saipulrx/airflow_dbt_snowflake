
  create or replace   view dbt_dev.public.dim_employees
  
   as (
    with source as (
    select * from dbt_dev.public.employees
)
select 
    *,
    current_timestamp() as ingestion_timestamp
from source
  );

