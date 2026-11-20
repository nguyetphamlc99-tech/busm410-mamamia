-- Compares each country's 2025 sale-price value per active purchaser with the all-country average; see sql/README.md.
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
overall_average AS (
  SELECT
    SAFE_DIVIDE(
      SUM(recorded_sale_price),
      SUM(active_purchasers)
    ) AS all_country_average
  FROM country_totals
),
average_country_purchasers AS (
  SELECT
    AVG(active_purchasers) AS average_active_purchasers_per_country
  FROM country_totals
)
SELECT
  c.country,
  c.recorded_sale_price,
  c.active_purchasers,
  p.average_active_purchasers_per_country,
  c.active_purchasers - p.average_active_purchasers_per_country
    AS difference_from_average_country_purchasers,
  SAFE_DIVIDE(c.recorded_sale_price, c.active_purchasers)
    AS sale_price_per_active_purchaser,
  a.all_country_average,
  SAFE_DIVIDE(c.recorded_sale_price, c.active_purchasers)
    - a.all_country_average AS difference_from_all_country_average
FROM country_totals AS c
CROSS JOIN overall_average AS a
CROSS JOIN average_country_purchasers AS p
ORDER BY sale_price_per_active_purchaser DESC;
