{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('wc_products_variations__links_ab1') }}
select
    _airbyte_wc_products_variations_hashid,
    {{ adapter.quote('self') }},
    collection,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('wc_products_variations__links_ab1') }}
-- _links at wc_products_variations/_links
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

