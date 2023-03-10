{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('wc_products_variations_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast(sku as {{ dbt_utils.type_string() }}) as sku,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    cast(tags as {{ type_json() }}) as tags,
    cast(price as {{ dbt_utils.type_string() }}) as price,
    _links,
    cast(images as {{ type_json() }}) as images,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(weight as {{ dbt_utils.type_string() }}) as weight,
    {{ cast_to_boolean('on_sale') }} as on_sale,
    cast(virtual as {{ dbt_utils.type_string() }}) as virtual,
    {{ cast_to_boolean('featured') }} as featured,
    cast(shop_url as {{ dbt_utils.type_string() }}) as shop_url,
    cast(variable as {{ dbt_utils.type_string() }}) as variable,
    cast(downloads as {{ dbt_utils.type_string() }}) as downloads,
    meta_data,
    cast(parent_id as {{ dbt_utils.type_bigint() }}) as parent_id,
    cast(permalink as {{ dbt_utils.type_string() }}) as permalink,
    cast(store_url as {{ dbt_utils.type_string() }}) as store_url,
    cast(tax_class as {{ dbt_utils.type_string() }}) as tax_class,
    cast({{ adapter.quote('attributes') }} as {{ type_json() }}) as {{ adapter.quote('attributes') }},
    cast(backorders as {{ dbt_utils.type_string() }}) as backorders,
    cast(categories as {{ type_json() }}) as categories,
    cast(dimensions as {{ type_json() }}) as dimensions,
    cast(price_html as {{ dbt_utils.type_string() }}) as price_html,
    cast(profile_id as {{ dbt_utils.type_string() }}) as profile_id,
    cast(sale_price as {{ dbt_utils.type_string() }}) as sale_price,
    cast(tax_status as {{ dbt_utils.type_string() }}) as tax_status,
    cast(upsell_ids as {{ type_json() }}) as upsell_ids,
    cast(variations as {{ type_json() }}) as variations,
    {{ cast_to_boolean('backordered') }} as backordered,
    cast(button_text as {{ dbt_utils.type_string() }}) as button_text,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    {{ cast_to_boolean('purchasable') }} as purchasable,
    cast(related_ids as {{ type_json() }}) as related_ids,
    cast(total_sales as {{ dbt_utils.type_string() }}) as total_sales,
    cast(date_created as {{ dbt_utils.type_string() }}) as date_created,
    cast(downloadable as {{ dbt_utils.type_string() }}) as downloadable,
    cast(external_url as {{ dbt_utils.type_string() }}) as external_url,
    {{ cast_to_boolean('manage_stock') }} as manage_stock,
    cast(rating_count as {{ dbt_utils.type_bigint() }}) as rating_count,
    cast(stock_status as {{ dbt_utils.type_string() }}) as stock_status,
    cast(date_modified as {{ dbt_utils.type_string() }}) as date_modified,
    cast(purchase_note as {{ dbt_utils.type_string() }}) as purchase_note,
    cast(regular_price as {{ dbt_utils.type_string() }}) as regular_price,
    cast(average_rating as {{ dbt_utils.type_string() }}) as average_rating,
    cast(cross_sell_ids as {{ type_json() }}) as cross_sell_ids,
    cast(download_limit as {{ dbt_utils.type_string() }}) as download_limit,
    cast(shipping_class as {{ dbt_utils.type_string() }}) as shipping_class,
    cast(stock_quantity as {{ dbt_utils.type_string() }}) as stock_quantity,
    cast(date_on_sale_to as {{ dbt_utils.type_string() }}) as date_on_sale_to,
    cast(download_expiry as {{ dbt_utils.type_string() }}) as download_expiry,
    {{ cast_to_boolean('reviews_allowed') }} as reviews_allowed,
    cast(date_created_gmt as {{ dbt_utils.type_string() }}) as date_created_gmt,
    cast(grouped_products as {{ type_json() }}) as grouped_products,
    {{ cast_to_boolean('shipping_taxable') }} as shipping_taxable,
    cast(date_modified_gmt as {{ dbt_utils.type_string() }}) as date_modified_gmt,
    cast(date_on_sale_from as {{ dbt_utils.type_string() }}) as date_on_sale_from,
    {{ cast_to_boolean('shipping_class_id') }} as shipping_class_id,
    {{ cast_to_boolean('shipping_required') }} as shipping_required,
    cast(short_description as {{ dbt_utils.type_string() }}) as short_description,
    {{ cast_to_boolean('sold_individually') }} as sold_individually,
    {{ cast_to_boolean('backorders_allowed') }} as backorders_allowed,
    cast(catalog_visibility as {{ dbt_utils.type_string() }}) as catalog_visibility,
    cast(default_attributes as {{ type_json() }}) as default_attributes,
    cast(date_on_sale_to_gmt as {{ dbt_utils.type_string() }}) as date_on_sale_to_gmt,
    cast(date_on_sale_from_gmt as {{ dbt_utils.type_string() }}) as date_on_sale_from_gmt,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('wc_products_variations_ab1') }}
-- wc_products_variations
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

