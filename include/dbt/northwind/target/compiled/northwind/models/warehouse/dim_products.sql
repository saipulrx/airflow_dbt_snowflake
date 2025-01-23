with source as (
    select *
    from dbt_dev.public.products
)
select 
    *,
    current_timestamp() as ingestion_timestamp
from source