# Findings: Country Revenue Concentration

## 1. The gap

BigQuery query results show China, the United States, and Brasil together account for 69.91% of recorded order-item `sale_price` in 2023 and 70.41% in 2025. The top-three share rose by 0.50 percentage points. One result row is one user-country group per order-item creation year.

The 2026 results are not used because the year may be incomplete. The concentration query returned the comparison summary below. Totals are rounded to two decimals; the result screenshots and the team's spreadsheet agree at this precision.

| Year | China | United States | Brasil | Top-three total | Total across rows shown | Top-three share | Other countries | Difference |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 2023 | 377,455.2802 | 264,197.7703 | 155,230.6902 | 796,883.74 | 1,139,791.91 | 69.91% | 30.09% | 39.83 pp |
| 2025 | 786,711.9108 | 546,520.5305 | 346,811.4504 | 1,680,043.89 | 2,385,947.97 | 70.41% | 29.59% | 40.83 pp |

## 2. The benchmark

The benchmark is the combined total for all other country groups returned by the query in the same year. It is an in-dataset peer comparison, not an industry target. In 2025, the leading three countries represent 70.41% of the total, compared with 29.59% for all other groups, a 40.83 percentage-point difference. In 2023, the corresponding difference was 39.83 points.

This shows a persistent concentration in the same three countries. It does not explain why that pattern exists. Country refers to the user's country in the `users` table.

## 3. Value

The 2025 value represented by the top-three group is **1,680,043.89 recorded `sale_price` units**, based on the BigQuery concentration query. Its share of the query's total is:

`1,680,043.89 ÷ 2,385,947.97 × 100 = 70.41%`

This measures the amount of recorded sale price associated with the three leading user countries. It is not profit, lost revenue, or an estimated financial benefit from changing strategy. The dataset's currency/unit has not yet been confirmed, so the figures are not labeled as dollars.

**Result source:** The team ran [`sql/03_top_three_concentration.sql`](sql/03_top_three_concentration.sql) in BigQuery; the result screenshot shows 2023 and 2025 output. The country totals are also available in the [team's Google Sheets output](https://docs.google.com/spreadsheets/d/1rDDExt7Uf89crvoLI5ZjTG0p1JqFMs49nnnk2eYQmJY/edit?gid=1679571377#gid=1679571377). The source country-year query is [`sql/02_country_revenue_by_year.sql`](sql/02_country_revenue_by_year.sql).

## 4. Chart

![Gap chart](visuals/gap_chart.png)

## Limits and next checks

- The team ran the concentration query; the assistant did not execute it. BigQuery screenshots confirm the summary results shown above.
- The concentration query includes country groups returned by the inner join, including a null-country group if present. Review the data-quality results to understand missing and unmatched records.
- The year-coverage result shows 66,265 order-item rows in 2026 and a latest timestamp of 2026-11-14 23:48:20 UTC, later than the screenshot date of 2026-11-11. Review the first diagnostic result for the future-timestamp count before deciding what to do. Duplicate IDs, blank countries, unmatched users, null or negative values, and the future timestamp still need interpretation.
- The query sums `sale_price` without filtering order-item status or returns, so call this a recorded order-item sale-price total, not net revenue or profit.
- Confirm the unit/currency before describing these values as money.
