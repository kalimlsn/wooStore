{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('wc_orders_scd') }}
select
    _airbyte_wc_orders_hashid,
    {{ json_extract_scalar('tax_lines', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('tax_lines', ['label'], ['label']) }} as {{ adapter.quote('label') }},
    {{ json_extract_scalar('tax_lines', ['rate_id'], ['rate_id']) }} as rate_id,
    {{ json_extract_scalar('tax_lines', ['compound'], ['compound']) }} as compound,
    {{ json_extract('table_alias', 'tax_lines', ['meta_data']) }} as meta_data,
    {{ json_extract_scalar('tax_lines', ['rate_code'], ['rate_code']) }} as rate_code,
    {{ json_extract_scalar('tax_lines', ['tax_total'], ['tax_total']) }} as tax_total,
    {{ json_extract_scalar('tax_lines', ['shipping_tax_total'], ['shipping_tax_total']) }} as shipping_tax_total,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('wc_orders_scd') }} as table_alias
-- tax_lines at wc_orders/tax_lines
where 1 = 1
and tax_lines is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

