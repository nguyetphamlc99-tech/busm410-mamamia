-- Diagnostic checks for fields used in the current analysis; see sql/README.md before interpreting results.
WITH checks AS (
  SELECT 'duplicate order_items.id' AS check_name, COUNT(*) AS observed_count
  FROM (
    SELECT id
    FROM `bigquery-public-data.thelook_ecommerce.order_items`
    GROUP BY id
    HAVING COUNT(*) > 1
  )
  UNION ALL
  SELECT 'null order_items.id', COUNTIF(id IS NULL)
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  UNION ALL
  SELECT 'null order_items.user_id', COUNTIF(user_id IS NULL)
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  UNION ALL
  SELECT 'null order_items.created_at', COUNTIF(created_at IS NULL)
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  UNION ALL
  SELECT 'future order_items.created_at', COUNTIF(created_at > CURRENT_TIMESTAMP())
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  UNION ALL
  SELECT 'null or negative order_items.sale_price',
         COUNTIF(sale_price IS NULL OR sale_price < 0)
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  UNION ALL
  SELECT 'duplicate users.id', COUNT(*)
  FROM (
    SELECT id
    FROM `bigquery-public-data.thelook_ecommerce.users`
    GROUP BY id
    HAVING COUNT(*) > 1
  )
  UNION ALL
  SELECT 'null users.id', COUNTIF(id IS NULL)
  FROM `bigquery-public-data.thelook_ecommerce.users`
  UNION ALL
  SELECT 'blank or null users.country', COUNTIF(country IS NULL OR TRIM(country) = '')
  FROM `bigquery-public-data.thelook_ecommerce.users`
  UNION ALL
  SELECT 'order_items with unmatched user_id', COUNTIF(u.id IS NULL)
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  LEFT JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
    ON oi.user_id = u.id
)
SELECT check_name, observed_count
FROM checks
ORDER BY check_name;

-- Review row counts and the most recent creation date by year, especially for a partial final year.
SELECT
  EXTRACT(YEAR FROM created_at) AS year,
  COUNT(*) AS order_item_rows,
  MAX(created_at) AS latest_created_at
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY year
ORDER BY year DESC;
