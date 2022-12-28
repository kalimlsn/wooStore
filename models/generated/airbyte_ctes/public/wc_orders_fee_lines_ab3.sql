{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('wc_orders_fee_lines_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_wc_orders_hashid',
        adapter.quote('id'),
        adapter.quote('name'),
        'taxes',
        'total',
        'meta_data',
        'tax_class',
        'total_tax',
        'tax_status',
    ]) }} as _airbyte_fee_lines_hashid,
    tmp.*
from {{ ref('wc_orders_fee_lines_ab2') }} tmp
-- fee_lines at wc_orders/fee_lines
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

