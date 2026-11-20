# Model Card: Customer Sale-Price Value, 2025

**Status: Completed using the team's supplied BigQuery results.** The SQL is in [query 13](../sql/13_customer_spend_table_2025.sql) and [query 14](../sql/14_customer_spend_model.sql). These results were not independently rerun in this editing session.

## Purpose

The model asks how customer attributes relate to a customer's recorded 2025 sale-price value while holding the other X's steady, and whether Belgium's higher value per customer remains after adjustment. It supports inference about associations. It does not establish causes.

## Data and definitions

- **Dataset:** `bigquery-public-data.thelook_ecommerce`
- **Outcome table:** `mamamia-busm-410.busm410.customer_spend_2025`
- **Row grain:** One customer with at least one 2025 item that was not cancelled or returned.
- **Rows:** 18,040 customers, including 219 from Belgium.
- **Y:** `net_sale_value`, the sum of 2025 recorded `sale_price` for items whose current status is not `Cancelled` or `Returned`.
- **X's:** `is_belgium`, age in years, `is_male`, `traffic_source`, signup month, and `days_active_in_2025`. Signup month is the customer's account creation month, not purchase month; the model uses age in years rather than the age bands explored in Part A.
- **Status rule:** The full 2025 calendar year is complete. Items marked `Shipped` or `Processing` remain included because the recorded sale price is set when the order item is placed. The team reports about half of 2025 items (19,635 of 39,044) were in those statuses. A stricter rule excluding customers with any open item left 5,483 customers, including 63 in Belgium, so that version was not used.
- **Held-out data:** The supplied model card reports 18,040 rows, above the course's 500-row threshold, so BigQuery held back evaluation rows under its default split.

The name `net_sale_value` is the SQL column name. It is not confirmed net revenue or profit: the data's currency is unknown, and items still marked `Shipped` or `Processing` might later be cancelled or returned. The table excludes items currently marked cancelled or returned, but it cannot guarantee final realized sales.

## Part A checks and patterns

The supplied checks report no blanks, ages from 12 through 70, no future or impossible dates, and no zero or negative Y values. Review the data and detailed group comparisons in [findings.md](../findings.md).

The model leaves item counts, average item price, and product category out of X because those are components of the same-year Y. Including them could make the model appear to explain the outcome using information that is part of its construction. This means the model cannot test whether product mix explains Belgium's higher recorded price; that remains a Part A hypothesis.

## Model

BigQuery ML `linear_reg` model: `mamamia-busm-410.busm410.customer_spend_model`. It uses `calculate_p_values = TRUE`, dummy encoding, `L1_REG = 0`, `max_iterations = 50`, and `early_stop = FALSE`. BigQuery ML's default data split is used.

## Report card

| Measure | Result | Meaning |
|---|---:|---|
| `r2_score` | 0.0004 | The model explains about 0.04% of the variation in test-set customer sale-price value. |
| Mean absolute error | About 70.5 units | Typical absolute prediction error, in unconfirmed sale-price units. |

Our `r2_score` is 0.0004, so the model explains almost none of the ups and downs in customer sale-price value. It is not ready to predict individual customer spend for a business decision, but it can still be used for inference.

## Drivers

The supplied `ML.ADVANCED_WEIGHTS` summary reports these non-intercept results. Categorical coefficients compare each category with BigQuery's omitted reference category.

| X or category | Coefficient | p-value | Reading |
|---|---:|---:|---|
| Belgium (`is_belgium`) | +11.65 | 0.1316 | Could be chance after adjustment |
| Age (per year) | +0.012 | 0.8124 | Could be chance |
| Male (vs. female) | +9.87 | <0.0001 | Association with higher value |
| Traffic source: Organic (vs. Search) | −2.48 | 0.3024 | Could be chance |
| Traffic source: Facebook (vs. Search) | +10.78 | 0.0041 | Association with higher value |
| Traffic source: Email (vs. Search) | +6.24 | 0.1208 | Could be chance |
| Traffic source: Display (vs. Search) | −3.13 | 0.4793 | Could be chance |
| Signup-month categories (vs. May) | −6.55 to +3.98 | 0.12 to 0.87 | No month category is reported significant |
| Days active in 2025 (per day) | +0.027 | 0.0354 | Small association; borderline at the 0.05 cutoff |

The two strongest reported associations by p-value are:

- **`is_male`** has a positive coefficient and a p-value below 0.0001, so holding the other X's steady, male customers have about 9.9 more recorded sale-price units than female customers in this model.
- **Facebook acquisition** has a positive coefficient and a p-value of 0.0041, so holding the other X's steady, Facebook-acquired customers have about 10.8 more recorded sale-price units than Search-acquired customers in this model.

A real link does not prove that an X causes Y. The Belgium coefficient is positive, but its p-value is 0.1316; the model does not find a statistically significant adjusted Belgium difference with this sample.

The supplied summary gives the combined coefficient and p-value ranges for signup-month categories rather than each month row. Run query 14 and add the individual month weights if the assignment requires a separate row for every dummy category.

## Belgium comparison and interpretation

After excluding items currently marked cancelled or returned, Belgium has 219 customers and an average recorded sale-price value of 104.44 units. The other countries have 17,821 customers and average 96.44 units, a raw difference of +8.00. After adjustment for the model's X's, the Belgium coefficient is +11.65 units (p = 0.1316; standard error 7.73). The adjusted difference is not statistically distinguishable from chance in these results.

## Expected ending

A market-planning manager can use these findings to decide whether Belgium merits more research, but they do not support a budget decision by themselves. Part A suggests Belgium's higher value may be associated with a greater share of higher-priced outerwear and formal categories, while the regression does not find a significant adjusted Belgium effect; that pattern deserves follow-up, not a causal conclusion.

## Limits and provenance

- The coefficient and evaluation values above were transcribed from the user-supplied `Belgium.zip`; they were not independently rerun here.
- The supplied model card reports the checks and row counts above; keep the BigQuery result screenshots or export with the team's project evidence.
- `sale_price` currency is unconfirmed. Do not label these units dollars, net revenue, or profit.
- The model does not include what customers bought, item counts, or average prices, so it cannot explain the Part A product-mix pattern.
- The analysis is descriptive and does not establish that gender, acquisition source, signup month, or customer activity caused the spending differences.
