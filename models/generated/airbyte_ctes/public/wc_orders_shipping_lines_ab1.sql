{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('wc_orders_scd') }}
{{ unnest_cte(ref('wc_orders_scd'), 'wc_orders', 'shipping_lines') }}
select
    _airbyte_wc_orders_hashid,
    {{ json_extract_scalar(unnested_column_value('shipping_lines'), ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract('', unnested_column_value('shipping_lines'), ['taxes']) }} as taxes,
    {{ json_extract_scalar(unnested_column_value('shipping_lines'), ['total'], ['total']) }} as total,
    {{ json_extract('', unnested_column_value('shipping_lines'), ['meta_data']) }} as meta_data,
    {{ json_extract_scalar(unnested_column_value('shipping_lines'), ['method_id'], ['method_id']) }} as method_id,
    {{ json_extract_scalar(unnested_column_value('shipping_lines'), ['total_tax'], ['total_tax']) }} as total_tax,
    {{ json_extract_scalar(unnested_column_value('shipping_lines'), ['method_title'], ['method_title']) }} as method_title,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('wc_orders_scd') }} as table_alias
-- shipping_lines at wc_orders/shipping_lines
{{ cross_join_unnest('wc_orders', 'shipping_lines') }}
where 1 = 1
and shipping_lines is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

