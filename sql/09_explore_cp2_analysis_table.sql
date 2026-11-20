-- CP2 Part A/B check: inspect label coverage and country-level spend in the purchaser table; see sql/README.md.

-- 1. Confirm the table has one usable row per purchaser and check the label.
SELECT
  COUNT(*) AS purchaser_rows,
  COUNT(DISTINCT purchaser_id) AS distinct_purchasers,
  COUNTIF(spend_2025 IS NULL) AS missing_spend_labels,
  COUNTIF(country IS NULL OR TRIM(country) = '') AS missing_country,
  COUNTIF(traffic_source IS NULL OR TRIM(traffic_source) = '') AS missing_traffic_source,
  COUNTIF(spend_2025 < 0) AS negative_spend_labels,
  MIN(spend_2025) AS minimum_spend_2025,
  APPROX_QUANTILES(spend_2025, 100)[OFFSET(50)] AS median_spend_2025,
  MAX(spend_2025) AS maximum_spend_2025,
  COUNTIF(country = 'Belgium') AS belgium_purchasers
FROM `mamamia-busm-410.cp2.analysis_table`;

-- 2. Compare purchaser count and average spend by recorded acquisition source.
SELECT
  traffic_source,
  COUNT(*) AS purchaser_count,
  AVG(spend_2025) AS average_spend_2025_per_purchaser
FROM `mamamia-busm-410.cp2.analysis_table`
GROUP BY traffic_source
ORDER BY average_spend_2025_per_purchaser DESC;

-- 3. Compare average 2025 recorded spend by country. This is descriptive, not adjusted for other features.
SELECT
  country,
  COUNT(*) AS purchaser_count,
  AVG(spend_2025) AS average_spend_2025_per_purchaser,
  AVG(order_item_rows_2025) AS average_2025_order_item_rows
FROM `mamamia-busm-410.cp2.analysis_table`
GROUP BY country
ORDER BY average_spend_2025_per_purchaser DESC;

-- 4. Check whether the Belgium-vs-other-countries contrast is represented in the training table.
SELECT
  country = 'Belgium' AS is_belgium,
  COUNT(*) AS purchaser_count,
  AVG(spend_2025) AS average_spend_2025_per_purchaser,
  AVG(order_item_rows_2025) AS average_2025_order_item_rows
FROM `mamamia-busm-410.cp2.analysis_table`
GROUP BY is_belgium
ORDER BY is_belgium DESC;
