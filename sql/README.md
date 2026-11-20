# SQL process

The repository contains the original all-item country comparison, a later status-filtered customer comparison, and earlier draft queries. Queries 13–14 support the current CP2 model results. Queries 08–12 are an earlier model draft with a different outcome and same-year category features; they are retained for project history and are superseded.

## Current query

### `06_belgium_vs_country_averages_2025.sql`

Returns one row for Belgium. It reports Belgium's recorded sale-price total, active-purchaser count, sale-price value per active purchaser, the average purchaser count across all country groups, and the overall sale-price value per active purchaser.

The two averages use different calculations:

- **Average active purchasers per country:** the simple average of the active-purchaser counts for the country groups.
- **Overall sale-price value per active purchaser:** the total recorded sale-price value across all country groups divided by all active purchasers. This is weighted by purchaser count.

The team's screenshot from the prior all-country version shows 12 country groups. Belgium has **286** active purchasers and about **110.13** recorded sale-price units per purchaser, the highest country average shown. This is about **10.00** units (**10.0%**) above the overall average of **100.13**. The average country purchaser count is **1,959**, making Belgium **1,673** purchasers (**85.4%**) below that reference. The query was then changed to return Belgium only and add the country-count average; those changes have not yet been run in BigQuery.

### `07_belgium_category_purchasers_2025.sql`

Draft category query for the table transcribed in [`findings.md`](../findings.md). It reports Belgian distinct category purchasers and their share of all Belgian purchasers, Belgian category order-item rows and recorded sale-price total, per-buyer sale-price values, all-country category purchasers, and the Belgium-minus-all-country benchmark difference. The all-country metric is the total for a category divided by that category's distinct buyers, includes Belgium, and is not an average of country-level averages. Product fields should be confirmed before running; this query has not been run by the assistant.

## Earlier CP2 draft queries (superseded)

Queries 08–12 build and train a purchaser spend model that uses same-year category purchases as predictors. They do not match the current model card and should not be used for the current submission. They have not been run in this session.

### `08_cp2_customer_analysis_table.sql`

Creates `mamamia-busm-410.cp2` in the US if needed and builds one row per matched purchaser with at least one 2025 order item. Y is `spend_2025`, the purchaser's summed 2025 recorded `sale_price`. X's are recorded country, acquisition `traffic_source`, and yes/no flags for purchase in each category. It inner-joins users and left-joins products, so unmatched product rows remain in the spend outcome but have no category flag. Confirm `order_items.product_id`, `products.id`, and `products.category` before running. Category flags and Y cover the same year, so category coefficients are associations and not causal effects.

### `09_explore_cp2_analysis_table.sql`

Returns four outputs: row-grain and label checks (including missing acquisition source), average spend by acquisition source, average spend by country, and Belgium versus non-Belgium purchaser counts and averages. Compare this count with prior query results before training.

### `10_train_cp2_spend_model.sql`

Trains BigQuery ML linear regression with `spend_2025` as Y and country, acquisition-source, and category indicators as X's. It requests p-values with dummy encoding and keeps `max_iterations = 50` and `early_stop = FALSE`. It leaves `data_split_method` at BigQuery ML's default.

### `11_evaluate_cp2_spend_model.sql` and `12_cp2_spend_model_drivers.sql`

Query 11 returns `ML.EVALUATE` results, including `r2_score`. Query 12 returns `ML.ADVANCED_WEIGHTS` coefficients and p-values. Fill in the [model card](../model/model_card.md) only from actual BigQuery results.

## Current customer-model queries

### `13_customer_spend_table_2025.sql`

Creates `mamamia-busm-410.busm410.customer_spend_2025`, with one row per customer who has at least one 2025 order item whose current status is not `Cancelled` or `Returned`. Y is `net_sale_value`, the sum of the remaining recorded item `sale_price`. The table also derives `is_belgium`, age and age band, `is_male`, traffic source, signup month, and days active during 2025. The customer table's `CREATE OR REPLACE TABLE` statement replaces that named table when run.

The status filter retains `Shipped` and `Processing` items. Their current status could still change, so interpret Y as status-filtered recorded item value, not confirmed realized revenue.

### `14_customer_spend_model.sql`

Trains BigQuery ML linear regression model `mamamia-busm-410.busm410.customer_spend_model`. Y is `net_sale_value`; X's are Belgium indicator, age, male indicator, traffic source, signup month, and days active in 2025. The file also runs `ML.EVALUATE` and `ML.ADVANCED_WEIGHTS`. It sets p-values, dummy encoding, `L1_REG = 0`, 50 iterations, and no early stopping, and uses BigQuery ML's default data split.

**Supplied run results:** The user-provided `Belgium.zip` reports 18,040 rows (219 Belgium customers), an `r2_score` of 0.0004, MAE about 70.5 units, a Belgium coefficient of +11.65 (p = 0.1316), a male coefficient of +9.87 (p < 0.0001), and Facebook versus Search of +10.78 (p = 0.0041). These values were not independently rerun in this editing session. The card notes that individual signup-month coefficient rows were not included in the supplied summary.

## Earlier queries kept for history

### `01_data_quality_checks.sql`

Checks for duplicate IDs, missing IDs and join keys, blank countries, null or future timestamps, null or negative sale prices, and order items without a matching user. A second result shows row counts and latest creation time by year.

**Run status:** Both statements completed successfully. The diagnostic statement processed **7.23 MB** and the year-coverage statement processed **1.38 MB**. The checks found **1,582** future `order_items.created_at` values; the other nine checks returned zero. The year-coverage result showed **39,970** order-item rows in 2025. Do not automatically remove or filter records; investigate what they represent first.

### `02_country_revenue_by_year.sql`

Earlier country-year totals from the joined source tables. Each output row represents a country group and creation year. It sums recorded item `sale_price` and does not filter status or returns.

### `03_top_three_concentration.sql`

Earlier country-concentration analysis, retained as historical work and not used for the current Belgium finding.

### `04_time_to_sell_by_category.sql`

Earlier exploratory query about elapsed days from inventory creation to sale. It is outside the current analysis.

### `05_us_china_sales_vs_purchaser_share_2025.sql`

Legacy two-country comparison query, retained for project history only. Its results are not included in the current README, charter, or findings.

## Cleaning and interpretation

- The current query uses 2025 order-item rows joined to `users` by `order_items.user_id = users.id`.
- The original country query does not filter item status or returns. Query 13 excludes currently `Cancelled` and `Returned` items but includes `Shipped` and `Processing` items. Describe `sale_price` as recorded item-sale value, not confirmed revenue or profit.
- Country is taken from `users.country`; it is not a verified shipping destination.
- Keep blank country groups visible when checking the denominator. Do not silently exclude groups.
- Do not label values as dollars until the source currency/unit is confirmed.
- Treat the comparison as descriptive. It does not establish why countries differ or prove that a business action would be profitable.

## Query cost

BigQuery job history showed **7.23 MB** processed for the diagnostic statement and **1.38 MB** for the year-coverage statement. An earlier two-country comparison showed an estimated **5.87 MB** scan. No byte estimate or processed-byte result is available in this repository for queries 13–14. A `LIMIT` does not reduce bytes scanned.
