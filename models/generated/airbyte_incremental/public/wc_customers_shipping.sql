{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('wc_customers_shipping_ab3') }}
select
    _airbyte_wc_customers_hashid,
    city,
    {{ adapter.quote('state') }},
    company,
    country,
    postcode,
    address_1,
    address_2,
    last_name,
    first_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_shipping_hashid
from {{ ref('wc_customers_shipping_ab3') }}
-- shipping at wc_customers/shipping from {{ ref('wc_customers_scd') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

