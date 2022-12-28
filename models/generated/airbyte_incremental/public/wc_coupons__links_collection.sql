{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('wc_coupons__links_collection_ab3') }}
select
    _airbyte__links_hashid,
    href,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_collection_hashid
from {{ ref('wc_coupons__links_collection_ab3') }}
-- collection at wc_coupons/_links/collection from {{ ref('wc_coupons__links') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

