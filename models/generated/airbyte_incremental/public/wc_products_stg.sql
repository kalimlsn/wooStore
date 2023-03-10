{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('wc_products_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'sku',
        adapter.quote('name'),
        'slug',
        object_to_string('tags'),
        'price',
        '_links',
        object_to_string('images'),
        'status',
        'weight',
        boolean_to_string('on_sale'),
        'virtual',
        boolean_to_string('featured'),
        boolean_to_string('shop_url'),
        'variable',
        'downloads',
        'meta_data',
        'parent_id',
        'permalink',
        'store_url',
        'tax_class',
        object_to_string(adapter.quote('attributes')),
        'backorders',
        object_to_string('categories'),
        object_to_string('dimensions'),
        'price_html',
        'profile_id',
        'sale_price',
        'tax_status',
        object_to_string('upsell_ids'),
        object_to_string('variations'),
        boolean_to_string('backordered'),
        'button_text',
        'description',
        boolean_to_string('purchasable'),
        object_to_string('related_ids'),
        'total_sales',
        'date_created',
        'downloadable',
        'external_url',
        boolean_to_string('manage_stock'),
        'rating_count',
        'stock_status',
        'date_modified',
        'purchase_note',
        'regular_price',
        'average_rating',
        object_to_string('cross_sell_ids'),
        'download_limit',
        'shipping_class',
        'stock_quantity',
        'date_on_sale_to',
        'download_expiry',
        boolean_to_string('reviews_allowed'),
        'date_created_gmt',
        object_to_string('grouped_products'),
        boolean_to_string('shipping_taxable'),
        'date_modified_gmt',
        'date_on_sale_from',
        boolean_to_string('shipping_class_id'),
        boolean_to_string('shipping_required'),
        'short_description',
        boolean_to_string('sold_individually'),
        boolean_to_string('backorders_allowed'),
        'catalog_visibility',
        object_to_string('default_attributes'),
        'date_on_sale_to_gmt',
        'date_on_sale_from_gmt',
    ]) }} as _airbyte_wc_products_hashid,
    tmp.*
from {{ ref('wc_products_ab2') }} tmp
-- wc_products
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

