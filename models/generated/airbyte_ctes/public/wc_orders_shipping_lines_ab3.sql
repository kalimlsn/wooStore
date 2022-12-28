{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('wc_orders_shipping_lines_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_wc_orders_hashid',
        adapter.quote('id'),
        'taxes',
        'total',
        'meta_data',
        'method_id',
        'total_tax',
        'method_title',
    ]) }} as _airbyte_shipping_lines_hashid,
    tmp.*
from {{ ref('wc_orders_shipping_lines_ab2') }} tmp
-- shipping_lines at wc_orders/shipping_lines
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

