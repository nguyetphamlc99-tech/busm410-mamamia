-- Compares Belgium with the 2025 country-count and overall purchaser averages; see sql/README.md.
WITH country_totals AS (
  SELECT
    u.country,
    SUM(oi.sale_price) AS recorded_sale_price,
    COUNT(DISTINCT u.id) AS active_purchasers
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  INNER JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
    ON oi.user_id = u.id
  WHERE oi.created_at >= TIMESTAMP('2025-01-01')
    AND oi.created_at < TIMESTAMP('2026-01-01')
  GROUP BY u.country
),
country_averages AS (
  SELECT
    COUNT(*) AS country_group_count,
    AVG(active_purchasers) AS average_active_purchasers_per_country,
    SAFE_DIVIDE(
      SUM(recorded_sale_price),
      SUM(active_purchasers)
    ) AS overall_sale_price_per_active_purchaser
  FROM country_totals
),
belgium AS (
  SELECT
    country,
    recorded_sale_price,
    active_purchasers,
    SAFE_DIVIDE(recorded_sale_price, active_purchasers)
      AS sale_price_per_active_purchaser
  FROM country_totals
  WHERE country = 'Belgium'
)
SELECT
  b.country,
  b.recorded_sale_price,
  b.active_purchasers,
  a.country_group_count,
  a.average_active_purchasers_per_country,
  b.active_purchasers - a.average_active_purchasers_per_country
    AS difference_from_average_country_purchasers,
  b.sale_price_per_active_purchaser,
  a.overall_sale_price_per_active_purchaser,
  b.sale_price_per_active_purchaser
    - a.overall_sale_price_per_active_purchaser
    AS difference_from_overall_sale_price_average
FROM belgium AS b
CROSS JOIN country_averages AS a;
