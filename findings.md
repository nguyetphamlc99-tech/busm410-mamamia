# Findings: Country Revenue Concentration

## 1. The gap

In the country-year results supplied by the team, China, the United States, and Brasil together account for 69.9% of recorded order-item `sale_price` in 2023 and 70.4% in 2025. The top-three share rose by only 0.5 percentage points across those comparison years. One result row is one user-country group per order-item creation year.

The 2026 results are not used because the year may be incomplete. The totals below are sums of the rows shared by the team and need confirmation against the full query output.

| Year | China | United States | Brasil | Top-three total | Total across rows shown | Top-three share | Other countries | Difference |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 2023 | 377,455.2802 | 264,197.7703 | 155,230.6902 | 796,883.7407 | 1,139,791.91095353 | 69.9% | 30.1% | 39.8 pp |
| 2025 | 786,711.9108 | 546,520.5305 | 346,811.4504 | 1,680,043.8917 | 2,385,947.9724193 | 70.4% | 29.6% | 40.8 pp |

## 2. The benchmark

The benchmark is the combined total for all other country groups in the same year. It is an in-dataset peer comparison, not an industry target. In 2025, the leading three countries represent 70.4% of the supplied total, compared with 29.6% for all other country groups, a 40.8 percentage-point difference. In 2023, the corresponding difference was 39.8 points.

This shows a persistent concentration in the same three countries. It does not explain why that pattern exists. Country refers to the user's country in the `users` table.

## 3. Value

The 2025 value represented by the top-three group is **1,680,043.8917 recorded `sale_price` units**:

`786,711.9108 + 546,520.5305 + 346,811.4504 = 1,680,043.8917`

As a share of all country rows supplied for 2025:

`1,680,043.8917 / 2,385,947.9724193 × 100 = 70.4%`

This measures the amount of recorded sale price associated with the three leading user countries. It is not profit, lost revenue, or an estimated financial benefit from changing strategy. The dataset's currency/unit has not yet been confirmed, so the figures are not labeled as dollars.

**Result source:** [Team's Google Sheets output](https://docs.google.com/spreadsheets/d/1rDDExt7Uf89crvoLI5ZjTG0p1JqFMs49nnnk2eYQmJY/edit?gid=1679571377#gid=1679571377). Reproduction query: [`sql/02_country_revenue_by_year.sql`](sql/02_country_revenue_by_year.sql). The share calculation is in [`sql/03_top_three_concentration.sql`](sql/03_top_three_concentration.sql).

## 4. Chart

![Gap chart](visuals/gap_chart.png)

## Limits and next checks

- Team-supplied values have not been independently rerun in BigQuery by the assistant.
- Confirm all country groups are included in the sheet and query output; the denominator above is the sum of rows provided.
- Run [`sql/01_data_quality_checks.sql`](sql/01_data_quality_checks.sql) and review duplicate IDs, blank countries, unmatched users, missing or future timestamps, negative prices, and year coverage.
- The query sums `sale_price` without filtering order-item status or returns, so call this a recorded order-item sale-price total, not net revenue or profit.
- Confirm the unit/currency before describing these values as money.
