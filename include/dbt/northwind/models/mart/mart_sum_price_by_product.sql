with source as (
    select 
    p.product_name,
    sum(fs.quantity * fs.unit_price) sum_price
    from {{ ref('fact_sales') }} fs
    inner join {{ ref('products') }} p
    on fs.product_id = p.id
    where fs.quantity > 99
    group by p.product_name
)

select 
    *
from source

