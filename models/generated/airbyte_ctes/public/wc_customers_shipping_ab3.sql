{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('wc_customers_shipping_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_wc_customers_hashid',
        'city',
        adapter.quote('state'),
        'company',
        'country',
        'postcode',
        'address_1',
        'address_2',
        'last_name',
        'first_name',
    ]) }} as _airbyte_shipping_hashid,
    tmp.*
from {{ ref('wc_customers_shipping_ab2') }} tmp
-- shipping at wc_customers/shipping
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

