{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('wc_orders_fee_lines_taxes') }}
select
    _airbyte_taxes_hashid,
    {{ json_extract_scalar('meta_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('meta_data', ['key'], ['key']) }} as {{ adapter.quote('key') }},
    {{ json_extract('table_alias', 'meta_data', ['value'], ['value']) }} as {{ adapter.quote('value') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('wc_orders_fee_lines_taxes') }} as table_alias
-- meta_data at wc_orders/fee_lines/taxes/meta_data
where 1 = 1
and meta_data is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

