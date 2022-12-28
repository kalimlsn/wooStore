{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('wc_customers__links_self_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte__links_hashid',
        'href',
    ]) }} as _airbyte_self_hashid,
    tmp.*
from {{ ref('wc_customers__links_self_ab2') }} tmp
-- self at wc_customers/_links/self
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

