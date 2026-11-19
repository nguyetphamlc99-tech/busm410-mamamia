-- Compares U.S. and China 2025 sales shares with their active-purchaser shares; see sql/README.md.
WITH country_totals AS (
  SELECT
    u.country,
    SUM(oi.sale_price) AS recorded_sale_price,
    COUNT(DISTINCT oi.user_id) AS active_purchasers
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  INNER JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
    ON oi.user_id = u.id
  WHERE oi.created_at >= TIMESTAMP('2025-01-01')
    AND oi.created_at < TIMESTAMP('2026-01-01')
  GROUP BY u.country
),
all_country_totals AS (
  SELECT
    SUM(recorded_sale_price) AS all_country_sale_price,
    SUM(active_purchasers) AS all_country_active_purchasers
  FROM country_totals
)
SELECT
  country AS focus_country,
  recorded_sale_price AS country_sale_price,
  all_country_sale_price,
  ROUND(100 * SAFE_DIVIDE(recorded_sale_price, all_country_sale_price), 2) AS country_sales_share_pct,
  active_purchasers AS country_active_purchasers,
  all_country_active_purchasers,
  ROUND(100 * SAFE_DIVIDE(active_purchasers, all_country_active_purchasers), 2) AS country_active_purchaser_share_pct,
  ROUND(
    100 * SAFE_DIVIDE(recorded_sale_price, all_country_sale_price)
    - 100 * SAFE_DIVIDE(active_purchasers, all_country_active_purchasers),
    2
  ) AS sales_share_minus_purchaser_share_pp,
  SAFE_DIVIDE(recorded_sale_price, active_purchasers) AS country_sale_price_per_active_purchaser,
  SAFE_DIVIDE(all_country_sale_price, all_country_active_purchasers) AS all_country_sale_price_per_active_purchaser
FROM country_totals
CROSS JOIN all_country_totals
WHERE country IN ('United States', 'China')
ORDER BY focus_country;
