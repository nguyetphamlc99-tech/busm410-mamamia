-- CP2 Part B: Train a linear regression for 2025 purchaser spend; see sql/README.md.
CREATE OR REPLACE MODEL `mamamia-busm-410.cp2.spend_model`
OPTIONS (
  model_type = 'linear_reg',
  input_label_cols = ['spend_2025'],
  calculate_p_values = TRUE,
  category_encoding_method = 'DUMMY_ENCODING',
  max_iterations = 50,
  early_stop = FALSE
) AS
SELECT
  spend_2025,
  country,
  traffic_source,
  bought_jeans,
  bought_fashion_hoodies,
  bought_sleep_lounge,
  bought_tops_tees,
  bought_intimates,
  bought_swim,
  bought_shorts,
  bought_accessories,
  bought_sweaters,
  bought_underwear,
  bought_outerwear_coats,
  bought_active,
  bought_dresses,
  bought_socks,
  bought_pants,
  bought_blazers_jackets,
  bought_maternity,
  bought_pants_capris,
  bought_suits_sport_coats,
  bought_socks_hosiery,
  bought_plus,
  bought_leggings,
  bought_skirts,
  bought_suits,
  bought_jumpsuits_rompers,
  bought_clothing_sets
FROM `mamamia-busm-410.cp2.analysis_table`;
