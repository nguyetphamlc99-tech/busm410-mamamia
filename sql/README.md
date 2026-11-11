# SQL process

This folder contains the SQL used to check the fields, reproduce the user-country totals, and calculate the top-three concentration measure. Each query starts with a short note pointing here.

## Query sequence

### `01_data_quality_checks.sql`

Checks the key fields used by the analysis for duplicate IDs, missing IDs and join keys, blank country values, null or future creation timestamps, null or negative sale prices, and order items with no matching user. A second result shows row counts and latest creation time by year so the team can assess date coverage, especially 2026.

**Run status:** BigQuery shows both statements completed successfully. The diagnostic statement processed **7.23 MB**; the year-coverage statement processed **1.38 MB**. The year-coverage result is transcribed below. The first statement's diagnostic counts have not been shared yet, so the quality checks are not complete. Do not automatically remove duplicates, blanks, or unmatched rows; first determine what they represent.

**Year-coverage output:** The screenshot shows the latest `created_at` and row count by year:

| Year | Order-item rows | Latest `created_at` (UTC) |
|---:|---:|---|
| 2026 | 66,265 | 2026-11-14 23:48:20.880067 |
| 2025 | 39,970 | 2025-12-31 23:58:42 |
| 2024 | 27,840 | 2024-12-31 23:52:41 |
| 2023 | 19,254 | 2023-12-31 23:53:08 |
| 2022 | 13,086 | 2022-12-31 23:30:25 |
| 2021 | 8,455 | 2021-12-31 23:53:14 |
| 2020 | 4,778 | 2020-12-31 22:47:08 |
| 2019 | 1,401 | 2019-12-31 23:29:37 |

The screenshot is dated 2026-11-11, but the latest 2026 timestamp is 2026-11-14, so it appears future-dated relative to the run. Check the first statement's `future order_items.created_at` count and discuss this before filtering anything. The 2026 row is excluded from the project's year comparison because it is the current, potentially incomplete year.

### `02_country_revenue_by_year.sql`

Reproduces the team's query: inner join `order_items.user_id = users.id`, group by `users.country` and the year of `order_items.created_at`, and sum `order_items.sale_price`. One result row is one user-country group and year. No status or return filter is applied.

The team shared the output in [Google Sheets](https://docs.google.com/spreadsheets/d/1rDDExt7Uf89crvoLI5ZjTG0p1JqFMs49nnnk2eYQmJY/edit?gid=1679571377#gid=1679571377) and ran this query in BigQuery. The result screenshot shows country-year rows, including 2026; the assistant did not run the query. The job's estimated and processed bytes were not included in the screenshot.

### `03_top_three_concentration.sql`

Aggregates the country-year totals, ranks countries within each year by sale-price total, and calculates the top-three total, the total across all returned country groups, top-three share, remaining-country share, and their difference in percentage points. The calculation is:

- Top-three share = top-three country total ÷ all-country total × 100.
- Remaining-country share = 100 − top-three share.
- Difference = top-three share − remaining-country share.

The team ran the ranked query in BigQuery. Its result screenshot shows 2023 top-three share **69.91%**, remaining share **30.09%**, and difference **39.83 percentage points**; for 2025 it shows **70.41%**, **29.59%**, and **40.83 percentage points**. Totals rounded to two decimals are 796,883.74 of 1,139,791.91 in 2023 and 1,680,043.89 of 2,385,947.97 in 2025. The assistant did not run the query. Review the data-quality outputs to assess missing and unmatched records.

### `04_time_to_sell_by_category.sql`

An earlier exploratory query about elapsed days from inventory creation to sale, retained for project history. It is outside the current country revenue finding and should not be used to support the current conclusion.

## Cleaning and interpretation choices

- The current revenue query does not apply data cleaning filters. The quality-check SQL is diagnostic, not an instruction to drop rows.
- The inner join excludes order items without a matching user. The quality check reports this so the team can decide whether it affects the results.
- A blank or null user country may form a separate group in BigQuery. Keep it visible while checking completeness; do not silently remove it from the denominator.
- Duplicate `order_items.id` or `users.id` values could change totals or multiply rows in the join. Inspect any duplicates before choosing a treatment.
- Negative or null `sale_price`, null/future `created_at`, and incomplete recent-year coverage need review. The result counts from the diagnostic query have not yet been shared or recorded.
- No status or return exclusion is made, so the measure is recorded item sale price, not net revenue or profit.
- The country field is sourced from `users.country`; it is not a shipping destination.
- Use 2023 and 2025 for comparison; 2026 may be incomplete.
- Do not label the results in dollars until the dataset's currency/unit is documented.
- Google Sheets was used to view the provided output. No spreadsheet formulas were supplied; the arithmetic used for the summary is documented in `findings.md`.

## Query cost

For `01_data_quality_checks.sql`, BigQuery's job history shows 7.23 MB processed for the diagnostic statement and 1.38 MB for the year-coverage statement. These are actual processed-byte amounts shown after execution, not pre-run estimates. The editor estimates and actual bytes processed for the country revenue and concentration queries were not visible in the supplied screenshots; add them from the job details if available. A `LIMIT` does not reduce bytes scanned.
