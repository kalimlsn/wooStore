{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('wc_orders_shipping_lines_taxes_ab3') }}
select
    _airbyte_shipping_lines_hashid,
    {{ adapter.quote('id') }},
    {{ adapter.quote('label') }},
    rate_id,
    compound,
    meta_data,
    rate_code,
    tax_total,
    shipping_tax_total,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_taxes_hashid
from {{ ref('wc_orders_shipping_lines_taxes_ab3') }}
-- taxes at wc_orders/shipping_lines/taxes from {{ ref('wc_orders_shipping_lines') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

