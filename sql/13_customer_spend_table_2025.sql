-- Builds one row per customer for the 2025 status-filtered comparison; see sql/README.md.
-- Y is recorded sale_price excluding items currently Cancelled or Returned.
CREATE OR REPLACE TABLE `mamamia-busm-410.busm410.customer_spend_2025` AS
WITH spend AS (
  SELECT
    user_id,
    SUM(IF(status NOT IN ('Cancelled','Returned'), sale_price, 0)) AS net_sale_value,
    COUNTIF(status NOT IN ('Cancelled','Returned'))                 AS kept_items
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE created_at >= TIMESTAMP('2025-01-01')
    AND created_at <  TIMESTAMP('2026-01-01')
  GROUP BY user_id
)
SELECT
  u.id                                              AS user_id,
  COALESCE(u.country, 'Unknown')                    AS country,
  IF(u.country = 'Belgium', 1, 0)                   AS is_belgium,
  COALESCE(u.age, 0)                                AS age,
  IF(u.age IS NULL, 1, 0)                           AS age_missing,
  CASE
    WHEN u.age < 18 THEN '1. under 18'
    WHEN u.age < 25 THEN '2. 18-24'
    WHEN u.age < 35 THEN '3. 25-34'
    WHEN u.age < 45 THEN '4. 35-44'
    WHEN u.age < 55 THEN '5. 45-54'
    WHEN u.age < 65 THEN '6. 55-64'
    ELSE                 '7. 65+'
  END                                               AS age_band,
  IF(u.gender = 'M', 1, 0)                          AS is_male,
  COALESCE(u.traffic_source, 'Unknown')             AS traffic_source,
  DATE(u.created_at)                                AS signup_date,
  EXTRACT(MONTH FROM u.created_at)                  AS signup_month,
  IF(u.created_at >= TIMESTAMP('2025-01-01'), 1, 0) AS signed_up_in_2025,
  DATE_DIFF(DATE '2025-12-31',
            GREATEST(DATE(u.created_at), DATE '2025-01-01'), DAY) + 1 AS days_active_in_2025,
  ROUND(s.net_sale_value, 2)                        AS net_sale_value
FROM spend AS s
JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
  ON s.user_id = u.id
WHERE s.kept_items >= 1;
