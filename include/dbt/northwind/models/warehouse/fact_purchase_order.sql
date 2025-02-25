{{ config(
    partition_by={
      "field": "creation_date",
      "data_type": "date"
    }
)}}
with source as(
    select
        c.id as customer_id,
        e.id as employee_id,
        pod.purchase_order_id,
        pod.product_id,
        pod.quantity,
        pod.unit_cost,
        pod.date_received,
        pod.posted_to_inventory,
        pod.inventory_id,
        po.supplier_id,
        po.created_by,
        po.submitted_date,
        date(po.creation_date) as creation_date,
        po.status_id,
        po.expected_date,
        po.shipping_fee,
        po.taxes,
        po.payment_date,
        po.payment_amount,
        po.payment_method,
        po.notes,
        po.approved_by,
        po.approved_date,
        po.submitted_by,
        current_timestamp() as insertion_timestamp
    from {{ ref('purchase_orders') }} po
    left join {{ ref('purchase_order_details') }} pod
    on pod.purchase_order_id = po.id
    left join {{ ref('products') }} p
    on p.id = pod.product_id
    left join {{ ref('order_details') }} od
    on od.product_id = p.id
    left join {{ ref('orders') }} o
    on o.id = od.order_id
    left join {{ ref('employees') }} e
    on e.id = po.created_by
    left join {{ ref('customer') }} c
    on c.id = o.customer_id
    where o.customer_id is not null
)
select * 
from source