-- Calculates the within-year top-three share against all remaining country groups; see sql/README.md.
WITH country_revenue AS (
  SELECT
    u.country AS region,
    EXTRACT(YEAR FROM oi.created_at) AS year,
    SUM(oi.sale_price) AS total_revenue
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  INNER JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
    ON oi.user_id = u.id
  GROUP BY region, year
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY year
      ORDER BY total_revenue DESC, region
    ) AS revenue_rank
  FROM country_revenue
)
SELECT
  year,
  SUM(IF(revenue_rank <= 3, total_revenue, 0)) AS top_three_total,
  SUM(total_revenue) AS total_all_country_groups,
  ROUND(100 * SAFE_DIVIDE(
    SUM(IF(revenue_rank <= 3, total_revenue, 0)),
    SUM(total_revenue)
  ), 2) AS top_three_share_pct,
  ROUND(100 - 100 * SAFE_DIVIDE(
    SUM(IF(revenue_rank <= 3, total_revenue, 0)),
    SUM(total_revenue)
  ), 2) AS remaining_share_pct,
  ROUND(
    200 * SAFE_DIVIDE(
      SUM(IF(revenue_rank <= 3, total_revenue, 0)),
      SUM(total_revenue)
    ) - 100,
    2
  ) AS top_three_minus_remaining_pp
FROM ranked
WHERE year IN (2023, 2025)
GROUP BY year
ORDER BY year;
