{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('wc_coupons_meta_data_ab3') }}
select
    _airbyte_wc_coupons_hashid,
    {{ adapter.quote('id') }},
    {{ adapter.quote('key') }},
    {{ adapter.quote('value') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_meta_data_hashid
from {{ ref('wc_coupons_meta_data_ab3') }}
-- meta_data at wc_coupons/meta_data from {{ ref('wc_coupons_scd') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

