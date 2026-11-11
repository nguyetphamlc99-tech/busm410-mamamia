-- Step 1: Compare average days to sell by category and inventory creation year. See sql/notes.md for notes.
SELECT
  product_category,
  EXTRACT(YEAR FROM created_at) AS year,
  ROUND(AVG(TIMESTAMP_DIFF(sold_at, created_at, DAY)), 2) AS avg_days_to_sell,
  COUNT(*) AS total_items_sold
FROM `bigquery-public-data.thelook_ecommerce.inventory_items`
WHERE
  product_category IN ('Swimwear', 'Outerwear', 'Dresses', 'Accessories')
  AND sold_at IS NOT NULL
  AND EXTRACT(YEAR FROM created_at) BETWEEN 2023 AND 2026
GROUP BY 1, 2
ORDER BY product_category ASC, year DESC;
