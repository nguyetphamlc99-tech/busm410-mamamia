# Charter: Country Revenue Concentration

## Project question

How concentrated is recorded order-item revenue across customer countries, and did the share from the three highest-revenue countries change from 2023 to 2025?

## The gap

In the country-year results supplied by the team, China, the United States, and Brasil together account for about 70% of the recorded revenue in both comparison years. Their share changed only slightly, from 69.9% in 2023 to 70.4% in 2025.

| Year | China | United States | Brasil | Top-three total | Total of country rows shared | Top-three share |
|---:|---:|---:|---:|---:|---:|---:|
| 2023 | 377,455.28 | 264,197.77 | 155,230.69 | 796,883.74 | 1,139,791.91 | 69.9% |
| 2025 | 786,711.91 | 546,520.53 | 346,811.45 | 1,680,043.89 | 2,385,947.97 | 70.4% |

China's recorded revenue was about 240,191.38 higher than the United States in 2025. The absolute difference was larger than in 2023, but the relative lead was similar: China was about 43% above the United States in both years. The results show revenue concentration; they do not explain its cause.

## Measure and unit of analysis

The source tables are `bigquery-public-data.thelook_ecommerce.order_items` and `bigquery-public-data.thelook_ecommerce.users`. The query joins each order-item row to its user by `user_id = id`, groups by `users.country` and the year of `order_items.created_at`, and sums `order_items.sale_price`.

One result row represents one user country in one order-item creation year. The country is the user's recorded country, not necessarily the item's shipping or delivery destination.

## Comparison

The three highest-revenue countries are compared with the remaining countries in the supplied results. This is an internal comparison, not an industry benchmark or target. No target revenue share was provided.

## Potential value

The results show that a large share of recorded order-item revenue is associated with three user countries. This can guide a follow-up question about whether that concentration comes from more customers, more orders, or higher spending per customer. The current query does not measure profit, customer counts, order counts, or the reason for the differences, so it does not establish which countries are more successful or where the team should invest.

## Limits and next checks

- The totals and shares above were calculated from the country rows supplied by the team. Confirm the results include every country group, including any blank or null country group.
- The query sums `sale_price` without filtering order-item status or returns. Describe it as the sum of recorded order-item sale prices, not net revenue or profit.
- The query uses the user's country, not shipping destination.
- 2026 may be an incomplete year, so this comparison uses 2023 and 2025.
- Before calling the values dollars, confirm the unit/currency for `sale_price` in the dataset documentation.
- To explain the concentration, a follow-up analysis should compare order counts and customer counts by country before drawing conclusions.
