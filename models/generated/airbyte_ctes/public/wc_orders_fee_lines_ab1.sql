{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('wc_orders_scd') }}
{{ unnest_cte(ref('wc_orders_scd'), 'wc_orders', 'fee_lines') }}
select
    _airbyte_wc_orders_hashid,
    {{ json_extract_scalar(unnested_column_value('fee_lines'), ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar(unnested_column_value('fee_lines'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract('', unnested_column_value('fee_lines'), ['taxes']) }} as taxes,
    {{ json_extract_scalar(unnested_column_value('fee_lines'), ['total'], ['total']) }} as total,
    {{ json_extract('', unnested_column_value('fee_lines'), ['meta_data']) }} as meta_data,
    {{ json_extract_scalar(unnested_column_value('fee_lines'), ['tax_class'], ['tax_class']) }} as tax_class,
    {{ json_extract_scalar(unnested_column_value('fee_lines'), ['total_tax'], ['total_tax']) }} as total_tax,
    {{ json_extract_scalar(unnested_column_value('fee_lines'), ['tax_status'], ['tax_status']) }} as tax_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('wc_orders_scd') }} as table_alias
-- fee_lines at wc_orders/fee_lines
{{ cross_join_unnest('wc_orders', 'fee_lines') }}
where 1 = 1
and fee_lines is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

