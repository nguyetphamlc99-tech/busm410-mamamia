-- Step 2: Summarize order-item sale price by user country and creation year. See sql/notes.md for notes.
SELECT
  u.country AS region,
  EXTRACT(YEAR FROM oi.created_at) AS year,
  SUM(oi.sale_price) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
INNER JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
  ON oi.user_id = u.id
GROUP BY 1, 2
ORDER BY year DESC, total_revenue DESC;
