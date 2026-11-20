-- Compares Belgium's 2025 category purchaser and sale-price metrics with each category's all-country benchmark; see sql/README.md.
-- Confirm products.id, products.category, and order_items.product_id in BigQuery before running.
WITH purchasers_2025 AS (
  SELECT
    u.country,
    u.id AS purchaser_id
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  INNER JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
    ON oi.user_id = u.id
  WHERE oi.created_at >= TIMESTAMP('2025-01-01')
    AND oi.created_at < TIMESTAMP('2026-01-01')
),
order_item_categories AS (
  SELECT
    u.country,
    u.id AS purchaser_id,
    p.category,
    oi.id AS order_item_id,
    oi.sale_price
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  INNER JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
    ON oi.user_id = u.id
  INNER JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
    ON oi.product_id = p.id
  WHERE oi.created_at >= TIMESTAMP('2025-01-01')
    AND oi.created_at < TIMESTAMP('2026-01-01')
),
country_purchasers AS (
  SELECT
    country,
    COUNT(DISTINCT purchaser_id) AS active_purchasers
  FROM purchasers_2025
  GROUP BY country
),
belgium_total AS (
  SELECT active_purchasers AS belgium_active_purchasers
  FROM country_purchasers
  WHERE country = 'Belgium'
),
category_metrics AS (
  SELECT
    category,
    COUNT(DISTINCT IF(country = 'Belgium', purchaser_id, NULL))
      AS belgium_category_purchasers,
    COUNTIF(country = 'Belgium') AS belgium_order_item_rows,
    SUM(IF(country = 'Belgium', sale_price, 0))
      AS belgium_recorded_sale_price,
    COUNT(DISTINCT purchaser_id) AS all_country_category_purchasers,
    SUM(sale_price) AS all_country_recorded_sale_price
  FROM order_item_categories
  GROUP BY category
)
SELECT
  c.category,
  c.belgium_category_purchasers,
  SAFE_DIVIDE(c.belgium_category_purchasers, b.belgium_active_purchasers)
    * 100 AS belgium_category_purchaser_pct,
  c.belgium_order_item_rows,
  c.belgium_recorded_sale_price,
  SAFE_DIVIDE(c.belgium_recorded_sale_price, c.belgium_category_purchasers)
    AS belgium_sale_price_per_category_purchaser,
  c.all_country_category_purchasers,
  SAFE_DIVIDE(c.all_country_recorded_sale_price,
              c.all_country_category_purchasers)
    AS all_country_sale_price_per_category_purchaser,
  SAFE_DIVIDE(c.belgium_recorded_sale_price, c.belgium_category_purchasers)
    - SAFE_DIVIDE(c.all_country_recorded_sale_price,
                  c.all_country_category_purchasers)
    AS difference_from_all_country_category_benchmark,
  b.belgium_active_purchasers
FROM category_metrics AS c
CROSS JOIN belgium_total AS b
ORDER BY c.category;
