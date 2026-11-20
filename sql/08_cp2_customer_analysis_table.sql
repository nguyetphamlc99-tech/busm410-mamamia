-- CP2 Part B: Build one 2025 purchaser row with recorded spend and category predictors; see sql/README.md.
-- This creates dataset `mamamia-busm-410.cp2` in US if it does not already exist.
CREATE SCHEMA IF NOT EXISTS `mamamia-busm-410.cp2` OPTIONS(location = 'US');

CREATE OR REPLACE TABLE `mamamia-busm-410.cp2.analysis_table` AS
WITH purchaser_items AS (
  SELECT
    u.id AS purchaser_id,
    u.country,
    p.category,
    oi.sale_price
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  INNER JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
    ON oi.user_id = u.id
  LEFT JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
    ON oi.product_id = p.id
  WHERE oi.created_at >= TIMESTAMP('2025-01-01')
    AND oi.created_at < TIMESTAMP('2026-01-01')
)
SELECT
  purchaser_id,
  country,
  SUM(sale_price) AS spend_2025,
  COUNT(*) AS order_item_rows_2025,
  COUNTIF(category IS NULL) AS order_items_without_category,
  IFNULL(LOGICAL_OR(category = 'Jeans'), FALSE) AS bought_jeans,
  IFNULL(LOGICAL_OR(category = 'Fashion Hoodies'), FALSE) AS bought_fashion_hoodies,
  IFNULL(LOGICAL_OR(category = 'Sleep & Lounge'), FALSE) AS bought_sleep_lounge,
  IFNULL(LOGICAL_OR(category = 'Tops & Tees'), FALSE) AS bought_tops_tees,
  IFNULL(LOGICAL_OR(category = 'Intimates'), FALSE) AS bought_intimates,
  IFNULL(LOGICAL_OR(category = 'Swim'), FALSE) AS bought_swim,
  IFNULL(LOGICAL_OR(category = 'Shorts'), FALSE) AS bought_shorts,
  IFNULL(LOGICAL_OR(category = 'Accessories'), FALSE) AS bought_accessories,
  IFNULL(LOGICAL_OR(category = 'Sweaters'), FALSE) AS bought_sweaters,
  IFNULL(LOGICAL_OR(category = 'Underwear'), FALSE) AS bought_underwear,
  IFNULL(LOGICAL_OR(category = 'Outerwear & Coats'), FALSE) AS bought_outerwear_coats,
  IFNULL(LOGICAL_OR(category = 'Active'), FALSE) AS bought_active,
  IFNULL(LOGICAL_OR(category = 'Dresses'), FALSE) AS bought_dresses,
  IFNULL(LOGICAL_OR(category = 'Socks'), FALSE) AS bought_socks,
  IFNULL(LOGICAL_OR(category = 'Pants'), FALSE) AS bought_pants,
  IFNULL(LOGICAL_OR(category = 'Blazers & Jackets'), FALSE) AS bought_blazers_jackets,
  IFNULL(LOGICAL_OR(category = 'Maternity'), FALSE) AS bought_maternity,
  IFNULL(LOGICAL_OR(category = 'Pants & Capris'), FALSE) AS bought_pants_capris,
  IFNULL(LOGICAL_OR(category = 'Suits & Sport Coats'), FALSE) AS bought_suits_sport_coats,
  IFNULL(LOGICAL_OR(category = 'Socks & Hosiery'), FALSE) AS bought_socks_hosiery,
  IFNULL(LOGICAL_OR(category = 'Plus'), FALSE) AS bought_plus,
  IFNULL(LOGICAL_OR(category = 'Leggings'), FALSE) AS bought_leggings,
  IFNULL(LOGICAL_OR(category = 'Skirts'), FALSE) AS bought_skirts,
  IFNULL(LOGICAL_OR(category = 'Suits'), FALSE) AS bought_suits,
  IFNULL(LOGICAL_OR(category = 'Jumpsuits & Rompers'), FALSE) AS bought_jumpsuits_rompers,
  IFNULL(LOGICAL_OR(category = 'Clothing Sets'), FALSE) AS bought_clothing_sets
FROM purchaser_items
GROUP BY purchaser_id, country;
