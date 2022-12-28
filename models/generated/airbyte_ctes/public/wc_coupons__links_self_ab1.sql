{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('wc_coupons__links') }}
{{ unnest_cte(ref('wc_coupons__links'), '_links', adapter.quote('self')) }}
select
    _airbyte__links_hashid,
    {{ json_extract_scalar(unnested_column_value(adapter.quote('self')), ['href'], ['href']) }} as href,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('wc_coupons__links') }} as table_alias
-- self at wc_coupons/_links/self
{{ cross_join_unnest('_links', adapter.quote('self')) }}
where 1 = 1
and {{ adapter.quote('self') }} is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

