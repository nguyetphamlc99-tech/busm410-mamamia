# Findings: Belgium Purchasers and Sale-Price Value, 2025

## The question

Does Belgium have a smaller active-purchaser base than the typical country in this dataset, while showing higher recorded sale-price value per purchaser than the overall average?

## What the result shows

The team's BigQuery screenshot shows results for 12 country groups. Belgium had 286 active purchasers and the highest recorded sale-price value per active purchaser in the results.

| Measure | Belgium | Comparison average | Difference |
|---|---:|---:|---:|
| Active purchasers | 286 | 1,959 per country | 1,673 fewer (85.4% below) |
| Recorded sale-price value per active purchaser | About 110.13 units | About 100.13 units per purchaser overall | About 10.00 units higher (10.0% above) |
| Recorded sale-price total | About 31,497.54 units | — | — |

The two averages have different meanings:

- **1,959 active purchasers per country** is the simple average of the 12 country-level purchaser counts. It is pulled upward by the largest countries, so it is a reference point, not a target.
- **100.13 sale-price units per active purchaser** is the overall total recorded sale-price value divided by all 23,508 active purchasers. It is weighted by purchaser count and includes Belgium.

Belgium's 286 active purchasers are about 1.22% of all active purchasers. The pattern is worth examining: Belgium has a small purchaser base by the country-count average, but higher recorded sale-price value per purchaser than the overall average. This does not show why, prove a growth opportunity, or establish that expanding the purchaser base would be profitable.

The currency of `sale_price` is not confirmed. The measure sums recorded order-item sale prices and does not remove returns or canceled items, so it should not be described as confirmed dollars, net revenue, or profit.

## Reproduction

The country-by-country result came from a query the team ran in BigQuery. The updated Belgium-focused query is [`sql/06_belgium_vs_country_averages_2025.sql`](sql/06_belgium_vs_country_averages_2025.sql). It returns Belgium's values alongside both comparison averages. The added country-count-average columns have not yet been rerun in BigQuery.

The latest all-country sale-price total shown was 2,353,813.65 units. This differs from the earlier CP1 total, so reconcile the source query totals before combining results across runs.

## Who may use this and why

A market-planning manager could use this result to decide whether Belgium merits more research. The data does not include marketing cost, profit, market potential, or a growth target, so it cannot support a budget decision on its own.
