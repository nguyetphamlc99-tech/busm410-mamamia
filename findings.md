# Findings: U.S. and China Sales Contribution

## 1. The question

In 2025, did the United States or China account for a much bigger share of recorded item-sale value than of active purchasers?

The team ran the corrected two-country query [`sql/05_us_china_sales_vs_purchaser_share_2025.sql`](sql/05_us_china_sales_vs_purchaser_share_2025.sql) in BigQuery. It returns one row for each focus country with recorded sale-price total, share of all-country sale-price value, active-purchaser count and share, difference between the two shares, and recorded sale-price per active purchaser.

| Measure | United States | China | All-country reference |
|---|---:|---:|---:|
| Sum of item `sale_price` values (currency not confirmed) | 529,094.11 | 795,315.45 | 2,353,813.65 total |
| Share of all-country item-sale value | 22.48% | 33.79% | 100% |
| Active purchasers | 5,336 | 7,910 | 23,508* total |
| Share of all-country active purchasers | About 22.70% | About 33.65% | 100% |
| Sale-value share minus purchaser share | About −0.22 percentage points | About +0.14 percentage points | 0 percentage points |
| Item-sale value per active purchaser | About 99.16 units | About 100.55 units | About 100.13 units average |

\*The all-country active-purchaser count of 23,508 was visible in the matching U.S.-only run; the latest screenshot clipped that denominator column. The shares, differences, and all-country average above use that count and are rounded. The latest screenshot shows the country-specific sales-share column, so the earlier issue where the U.S. share repeated on the China row is resolved.

## 2. What the numbers mean

The percentages use the sum of item `sale_price` values. They are **not** percentages of the number of transactions. China's item-sale-value share is about 0.14 percentage points above its purchaser share. The U.S. share is about 0.22 points below. Those differences are small, so this result does not show a clear mismatch between each country's share of value and its share of purchasers.

The all-country average is total recorded item-sale value divided by all active purchasers. It is about 100.13 units per purchaser. China is about 0.42 units above this average; the U.S. is about 0.97 units below it. This average is weighted by the number of purchasers in each country; it is not the simple average of country averages. The currency is not confirmed, so these figures should not be called dollars.

## 3. Who could use this and why

A marketing or market-planning manager could use this comparison to decide whether more research into purchaser numbers or spending patterns is needed. These results alone do not establish a business problem or support a budget change: the data has no profit, marketing cost, market potential, or target country mix.

## 4. Earlier CP1 context

In the earlier CP1 results, China and the United States were two of the three highest-sale-price countries in 2025:

| Earlier CP1 result | China | United States |
|---|---:|---:|
| Recorded sale-price total, 2025 | 786,711.91 units | 546,520.53 units |

The same CP1 summary reported a 2025 all-country total of **2,385,947.97 units**, compared with **2,353,813.65 units** in the current query 05 run. These totals do not reconcile. Rerun queries 02 and 03 with the same date filter and source state before combining the older CP1 results with this comparison.

The CP1 top-three summary found that China, the United States, and Brasil together accounted for 70.41% of recorded sale-price value in 2025, versus 29.59% for all remaining country groups. Their share was 69.91% in 2023. This concentration result motivated the current comparison; it does not establish a business problem.

**Source:** The team ran [`sql/02_country_revenue_by_year.sql`](sql/02_country_revenue_by_year.sql) and [`sql/03_top_three_concentration.sql`](sql/03_top_three_concentration.sql) in BigQuery. The result screenshots and [team Google Sheets output](https://docs.google.com/spreadsheets/d/1rDDExt7Uf89crvoLI5ZjTG0p1JqFMs49nnnk2eYQmJY/edit?gid=1679571377#gid=1679571377) agree at the displayed precision. The assistant did not run those queries.

## 5. Chart

The existing chart visualizes the earlier top-three comparison, not the focused U.S.–China comparison.

![Earlier CP1 top-three concentration chart](visuals/gap_chart.png)

## Limits and next checks

- The latest query 05 output is visible and the U.S.–China comparison is calculated. Record actual processed bytes if available in BigQuery job details.
- Rerun queries 02 and 03 for 2025 and reconcile their all-country total with query 05.
- The query includes joined order-item rows without filtering item status or returns. Interpret `sale_price` as recorded item sale-price value, not net revenue or profit.
- Country comes from `users.country`, not verified shipping destination. The inner join excludes unmatched users; the existing data-quality result reported zero unmatched users and blank/null countries, but the team should confirm the checks remain appropriate.
- The source diagnostic reported 1,582 future-dated `created_at` values. The focused query restricts the period to the completed 2025 calendar year; investigate the future timestamps before applying other filters.
- Confirm the `sale_price` unit/currency before describing values as dollars.
- CP2 modeling still needs a deliberate outcome and pre-outcome predictors. Customer-level recorded spend may be a candidate outcome, but it would not directly explain market risk or prove causation.
