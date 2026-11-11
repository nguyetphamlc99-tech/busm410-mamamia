# SQL process

This folder contains the SQL used to check the fields, reproduce the user-country totals, and calculate the top-three concentration measure. Each query starts with a short note pointing here.

## Query sequence

### `01_data_quality_checks.sql`

Checks the key fields used by the analysis for duplicate IDs, missing IDs and join keys, blank country values, null or future creation timestamps, null or negative sale prices, and order items with no matching user. A second result shows row counts and latest creation time by year so the team can assess date coverage, especially 2026.

**Status:** Written but not run by the assistant. Run it in BigQuery and record reviewed outcomes here before treating the checks as passed. Do not automatically remove duplicates, blanks, or unmatched rows; first determine what they represent.

### `02_country_revenue_by_year.sql`

Reproduces the team's query: inner join `order_items.user_id = users.id`, group by `users.country` and the year of `order_items.created_at`, and sum `order_items.sale_price`. One result row is one user-country group and year. No status or return filter is applied.

The team shared the output in [Google Sheets](https://docs.google.com/spreadsheets/d/1rDDExt7Uf89crvoLI5ZjTG0p1JqFMs49nnnk2eYQmJY/edit?gid=1679571377#gid=1679571377). The assistant has not run this query or independently confirmed its output. The BigQuery estimated bytes processed were not provided; add that estimate after checking the editor before running.

### `03_top_three_concentration.sql`

Aggregates the country-year totals, ranks countries within each year by sale-price total, and calculates the top-three total, the total across all returned country groups, top-three share, remaining-country share, and their difference in percentage points. The calculation is:

- Top-three share = top-three country total ÷ all-country total × 100.
- Remaining-country share = 100 − top-three share.
- Difference = top-three share − remaining-country share.

The findings use the rows supplied by the team to illustrate the calculation. The ranked query should be run to confirm those values and ensure that all country groups, including any null-country group, are represented.

### `04_time_to_sell_by_category.sql`

An earlier exploratory query about elapsed days from inventory creation to sale, retained for project history. It is outside the current country revenue finding and should not be used to support the current conclusion.

## Cleaning and interpretation choices

- The current revenue query does not apply data cleaning filters. The quality-check SQL is diagnostic, not an instruction to drop rows.
- The inner join excludes order items without a matching user. The quality check reports this so the team can decide whether it affects the results.
- A blank or null user country may form a separate group in BigQuery. Keep it visible while checking completeness; do not silently remove it from the denominator.
- Duplicate `order_items.id` or `users.id` values could change totals or multiply rows in the join. Inspect any duplicates before choosing a treatment.
- Negative or null `sale_price`, null/future `created_at`, and incomplete recent-year coverage need review. No outcomes are claimed until checks are run.
- No status or return exclusion is made, so the measure is recorded item sale price, not net revenue or profit.
- The country field is sourced from `users.country`; it is not a shipping destination.
- Use 2023 and 2025 for comparison; 2026 may be incomplete.
- Do not label the results in dollars until the dataset's currency/unit is documented.
- Google Sheets was used to view the provided output. No spreadsheet formulas were supplied; the arithmetic used for the summary is documented in `findings.md`.

## Query cost

The query editor's byte estimates and job details have not been provided. Add the estimate for each query before execution, and note actual bytes processed from BigQuery job details after execution. A `LIMIT` does not reduce bytes scanned.
