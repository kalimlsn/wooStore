{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('wc_orders_shipping_lines_taxes_meta_data_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_taxes_hashid',
        adapter.quote('id'),
        adapter.quote('key'),
        object_to_string(adapter.quote('value')),
    ]) }} as _airbyte_meta_data_hashid,
    tmp.*
from {{ ref('wc_orders_shipping_lines_taxes_meta_data_ab2') }} tmp
-- meta_data at wc_orders/shipping_lines/taxes/meta_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

