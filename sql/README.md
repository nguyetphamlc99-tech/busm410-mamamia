# SQL process

The current analysis compares Belgium with averages calculated from all country groups for 2025. The earlier queries are retained as project history; their results are not part of the current finding. Each query starts with a short note pointing here.

## Current query

### `06_belgium_vs_country_averages_2025.sql`

Returns one row for Belgium. It reports Belgium's recorded sale-price total, active-purchaser count, sale-price value per active purchaser, the average purchaser count across all country groups, and the overall sale-price value per active purchaser.

The two averages use different calculations:

- **Average active purchasers per country:** the simple average of the active-purchaser counts for the country groups.
- **Overall sale-price value per active purchaser:** the total recorded sale-price value across all country groups divided by all active purchasers. This is weighted by purchaser count.

The team's screenshot from the prior all-country version shows 12 country groups. Belgium has **286** active purchasers and about **110.13** recorded sale-price units per purchaser, the highest country average shown. This is about **10.00** units (**10.0%**) above the overall average of **100.13**. The average country purchaser count is **1,959**, making Belgium **1,673** purchasers (**85.4%**) below that reference. The query was then changed to return Belgium only and add the country-count average; those changes have not yet been run in BigQuery.

### `07_belgium_category_purchasers_2025.sql`

Draft category query for the table transcribed in [`findings.md`](../findings.md). It reports Belgian distinct category purchasers and their share of all Belgian purchasers, Belgian category order-item rows and recorded sale-price total, per-buyer sale-price values, all-country category purchasers, and the Belgium-minus-all-country benchmark difference. The all-country metric is the total for a category divided by that category's distinct buyers, includes Belgium, and is not an average of country-level averages. Product fields should be confirmed before running; this query has not been run by the assistant.

## CP2 model queries

### `08_cp2_customer_analysis_table.sql`

Creates `mamamia-busm-410.cp2` in the US if needed and builds one row per matched purchaser with at least one 2025 order item. Y is `spend_2025`, the purchaser's summed 2025 recorded `sale_price`. X's are recorded country and yes/no flags for purchase in each category. It inner-joins users and left-joins products, so unmatched product rows remain in the spend outcome but have no category flag. Confirm `order_items.product_id`, `products.id`, and `products.category` before running. Category flags and Y cover the same year, so category coefficients are associations and not causal effects.

### `09_explore_cp2_analysis_table.sql`

Returns three outputs: row-grain and label checks, average spend by country, and Belgium versus non-Belgium purchaser counts and averages. Compare this count with prior query results before training.

### `10_train_cp2_spend_model.sql`

Trains BigQuery ML linear regression with `spend_2025` as Y and country/category indicators as X's. It requests p-values with dummy encoding and keeps `max_iterations = 50` and `early_stop = FALSE`. It leaves `data_split_method` at BigQuery ML's default.

### `11_evaluate_cp2_spend_model.sql` and `12_cp2_spend_model_drivers.sql`

Query 11 returns `ML.EVALUATE` results, including `r2_score`. Query 12 returns `ML.ADVANCED_WEIGHTS` coefficients and p-values. Fill in the [model card](../model/model_card.md) only from actual BigQuery results.

**Run status:** The BigQuery connector is disabled by the workspace administrator, so queries 08–12 have not been run in this session. Confirm schema, review estimated bytes in BigQuery, then record the actual row count, evaluation, and weights after running. No CP2 metrics have been filled in or inferred.

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
- CP2 query 08 uses the same user join and a left product join for category flags.
- The query does not filter item status or returns. Describe `sale_price` as recorded item-sale value, not net revenue or profit.
- Country is taken from `users.country`; it is not a verified shipping destination.
- Keep blank country groups visible when checking the denominator. Do not silently exclude groups.
- Do not label values as dollars until the source currency/unit is confirmed.
- Treat the comparison as descriptive. It does not establish why countries differ or prove that a business action would be profitable.

## Query cost

BigQuery job history showed **7.23 MB** processed for the diagnostic statement and **1.38 MB** for the year-coverage statement. An earlier two-country comparison showed an estimated **5.87 MB** scan. No byte estimate or processed-byte result is available yet for the Belgium-focused version of query 06. A `LIMIT` does not reduce bytes scanned.
