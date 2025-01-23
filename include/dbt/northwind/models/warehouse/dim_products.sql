with source as (
    select *
    from {{ ref('products') }}
)
select 
    *,
    current_timestamp() as ingestion_timestamp
from source