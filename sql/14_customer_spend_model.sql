-- Trains and evaluates the customer-level inference model and returns its weights; see sql/README.md.
CREATE OR REPLACE MODEL `mamamia-busm-410.busm410.customer_spend_model`
OPTIONS (
  model_type = 'linear_reg',
  input_label_cols = ['net_sale_value'],
  calculate_p_values = TRUE,
  category_encoding_method = 'DUMMY_ENCODING',
  l1_reg = 0,
  max_iterations = 50,
  early_stop = FALSE
) AS
SELECT
  net_sale_value,
  is_belgium,
  age,
  is_male,
  traffic_source,
  CAST(signup_month AS STRING) AS signup_month,
  days_active_in_2025
FROM `mamamia-busm-410.busm410.customer_spend_2025`;

-- Report card
SELECT * FROM ML.EVALUATE(MODEL `mamamia-busm-410.busm410.customer_spend_model`);

-- Drivers (weights and p-values)
SELECT * FROM ML.ADVANCED_WEIGHTS(MODEL `mamamia-busm-410.busm410.customer_spend_model`);
