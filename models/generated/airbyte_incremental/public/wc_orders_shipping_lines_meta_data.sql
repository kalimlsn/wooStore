{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('wc_orders_shipping_lines_meta_data_ab3') }}
select
    _airbyte_shipping_lines_hashid,
    {{ adapter.quote('id') }},
    {{ adapter.quote('key') }},
    {{ adapter.quote('value') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_meta_data_hashid
from {{ ref('wc_orders_shipping_lines_meta_data_ab3') }}
-- meta_data at wc_orders/shipping_lines/meta_data from {{ ref('wc_orders_shipping_lines') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

