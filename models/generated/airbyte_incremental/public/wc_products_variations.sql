{{ config(
    indexes = [{'columns':['_airbyte_unique_key'],'unique':True}],
    unique_key = "_airbyte_unique_key",
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('wc_products_variations_scd') }}
select
    _airbyte_unique_key,
    {{ adapter.quote('id') }},
    sku,
    {{ adapter.quote('name') }},
    slug,
    tags,
    price,
    _links,
    images,
    status,
    weight,
    on_sale,
    virtual,
    featured,
    shop_url,
    variable,
    downloads,
    meta_data,
    parent_id,
    permalink,
    store_url,
    tax_class,
    {{ adapter.quote('attributes') }},
    backorders,
    categories,
    dimensions,
    price_html,
    profile_id,
    sale_price,
    tax_status,
    upsell_ids,
    variations,
    backordered,
    button_text,
    description,
    purchasable,
    related_ids,
    total_sales,
    date_created,
    downloadable,
    external_url,
    manage_stock,
    rating_count,
    stock_status,
    date_modified,
    purchase_note,
    regular_price,
    average_rating,
    cross_sell_ids,
    download_limit,
    shipping_class,
    stock_quantity,
    date_on_sale_to,
    download_expiry,
    reviews_allowed,
    date_created_gmt,
    grouped_products,
    shipping_taxable,
    date_modified_gmt,
    date_on_sale_from,
    shipping_class_id,
    shipping_required,
    short_description,
    sold_individually,
    backorders_allowed,
    catalog_visibility,
    default_attributes,
    date_on_sale_to_gmt,
    date_on_sale_from_gmt,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_wc_products_variations_hashid
from {{ ref('wc_products_variations_scd') }}
-- wc_products_variations from {{ source('public', '_airbyte_raw_wc_products_variations') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

