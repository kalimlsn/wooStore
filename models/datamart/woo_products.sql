select name as title, tags, 'null' as image ,images ,status ,description ,date_created as created_at ,date_modified as updated_at ,permalink ,variants ,attributes from {{ ref('wc_products') }}
