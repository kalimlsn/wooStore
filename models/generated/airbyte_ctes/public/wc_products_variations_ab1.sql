{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_wc_products_variations') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['sku'], ['sku']) }} as sku,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['slug'], ['slug']) }} as slug,
    {{ json_extract('table_alias', '_airbyte_data', ['tags'], ['tags']) }} as tags,
    {{ json_extract_scalar('_airbyte_data', ['price'], ['price']) }} as price,
    {{ json_extract('table_alias', '_airbyte_data', ['_links']) }} as _links,
    {{ json_extract('table_alias', '_airbyte_data', ['images'], ['images']) }} as images,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['weight'], ['weight']) }} as weight,
    {{ json_extract_scalar('_airbyte_data', ['on_sale'], ['on_sale']) }} as on_sale,
    {{ json_extract_scalar('_airbyte_data', ['virtual'], ['virtual']) }} as virtual,
    {{ json_extract_scalar('_airbyte_data', ['featured'], ['featured']) }} as featured,
    {{ json_extract_scalar('_airbyte_data', ['shop_url'], ['shop_url']) }} as shop_url,
    {{ json_extract_scalar('_airbyte_data', ['variable'], ['variable']) }} as variable,
    {{ json_extract_scalar('_airbyte_data', ['downloads'], ['downloads']) }} as downloads,
    {{ json_extract('table_alias', '_airbyte_data', ['meta_data']) }} as meta_data,
    {{ json_extract_scalar('_airbyte_data', ['parent_id'], ['parent_id']) }} as parent_id,
    {{ json_extract_scalar('_airbyte_data', ['permalink'], ['permalink']) }} as permalink,
    {{ json_extract_scalar('_airbyte_data', ['tax_class'], ['tax_class']) }} as tax_class,
    {{ json_extract('table_alias', '_airbyte_data', ['attributes'], ['attributes']) }} as {{ adapter.quote('attributes') }},
    {{ json_extract_scalar('_airbyte_data', ['backorders'], ['backorders']) }} as backorders,
    {{ json_extract('table_alias', '_airbyte_data', ['categories'], ['categories']) }} as categories,
    {{ json_extract('table_alias', '_airbyte_data', ['dimensions'], ['dimensions']) }} as dimensions,
    {{ json_extract_scalar('_airbyte_data', ['price_html'], ['price_html']) }} as price_html,
    {{ json_extract_scalar('_airbyte_data', ['sale_price'], ['sale_price']) }} as sale_price,
    {{ json_extract_scalar('_airbyte_data', ['tax_status'], ['tax_status']) }} as tax_status,
    {{ json_extract('table_alias', '_airbyte_data', ['upsell_ids'], ['upsell_ids']) }} as upsell_ids,
    {{ json_extract('table_alias', '_airbyte_data', ['variations'], ['variations']) }} as variations,
    {{ json_extract_scalar('_airbyte_data', ['backordered'], ['backordered']) }} as backordered,
    {{ json_extract_scalar('_airbyte_data', ['button_text'], ['button_text']) }} as button_text,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['purchasable'], ['purchasable']) }} as purchasable,
    {{ json_extract('table_alias', '_airbyte_data', ['related_ids'], ['related_ids']) }} as related_ids,
    {{ json_extract_scalar('_airbyte_data', ['total_sales'], ['total_sales']) }} as total_sales,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['downloadable'], ['downloadable']) }} as downloadable,
    {{ json_extract_scalar('_airbyte_data', ['external_url'], ['external_url']) }} as external_url,
    {{ json_extract_scalar('_airbyte_data', ['manage_stock'], ['manage_stock']) }} as manage_stock,
    {{ json_extract_scalar('_airbyte_data', ['rating_count'], ['rating_count']) }} as rating_count,
    {{ json_extract_scalar('_airbyte_data', ['stock_status'], ['stock_status']) }} as stock_status,
    {{ json_extract_scalar('_airbyte_data', ['date_modified'], ['date_modified']) }} as date_modified,
    {{ json_extract_scalar('_airbyte_data', ['purchase_note'], ['purchase_note']) }} as purchase_note,
    {{ json_extract_scalar('_airbyte_data', ['regular_price'], ['regular_price']) }} as regular_price,
    {{ json_extract_scalar('_airbyte_data', ['average_rating'], ['average_rating']) }} as average_rating,
    {{ json_extract('table_alias', '_airbyte_data', ['cross_sell_ids'], ['cross_sell_ids']) }} as cross_sell_ids,
    {{ json_extract_scalar('_airbyte_data', ['download_limit'], ['download_limit']) }} as download_limit,
    {{ json_extract_scalar('_airbyte_data', ['shipping_class'], ['shipping_class']) }} as shipping_class,
    {{ json_extract_scalar('_airbyte_data', ['stock_quantity'], ['stock_quantity']) }} as stock_quantity,
    {{ json_extract_scalar('_airbyte_data', ['date_on_sale_to'], ['date_on_sale_to']) }} as date_on_sale_to,
    {{ json_extract_scalar('_airbyte_data', ['download_expiry'], ['download_expiry']) }} as download_expiry,
    {{ json_extract_scalar('_airbyte_data', ['reviews_allowed'], ['reviews_allowed']) }} as reviews_allowed,
    {{ json_extract_scalar('_airbyte_data', ['date_created_gmt'], ['date_created_gmt']) }} as date_created_gmt,
    {{ json_extract('table_alias', '_airbyte_data', ['grouped_products'], ['grouped_products']) }} as grouped_products,
    {{ json_extract_scalar('_airbyte_data', ['shipping_taxable'], ['shipping_taxable']) }} as shipping_taxable,
    {{ json_extract_scalar('_airbyte_data', ['date_modified_gmt'], ['date_modified_gmt']) }} as date_modified_gmt,
    {{ json_extract_scalar('_airbyte_data', ['date_on_sale_from'], ['date_on_sale_from']) }} as date_on_sale_from,
    {{ json_extract_scalar('_airbyte_data', ['shipping_class_id'], ['shipping_class_id']) }} as shipping_class_id,
    {{ json_extract_scalar('_airbyte_data', ['shipping_required'], ['shipping_required']) }} as shipping_required,
    {{ json_extract_scalar('_airbyte_data', ['short_description'], ['short_description']) }} as short_description,
    {{ json_extract_scalar('_airbyte_data', ['sold_individually'], ['sold_individually']) }} as sold_individually,
    {{ json_extract_scalar('_airbyte_data', ['backorders_allowed'], ['backorders_allowed']) }} as backorders_allowed,
    {{ json_extract_scalar('_airbyte_data', ['catalog_visibility'], ['catalog_visibility']) }} as catalog_visibility,
    {{ json_extract('table_alias', '_airbyte_data', ['default_attributes'], ['default_attributes']) }} as default_attributes,
    {{ json_extract_scalar('_airbyte_data', ['date_on_sale_to_gmt'], ['date_on_sale_to_gmt']) }} as date_on_sale_to_gmt,
    {{ json_extract_scalar('_airbyte_data', ['date_on_sale_from_gmt'], ['date_on_sale_from_gmt']) }} as date_on_sale_from_gmt,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_wc_products_variations') }} as table_alias
-- wc_products_variations
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

