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

## Belgium category results

The category results below are transcribed from the BigQuery screenshot and the team's [category sheet](https://docs.google.com/spreadsheets/d/1jXNwfXJ5pRDnpHl_6pYGra9pCK5BWavyb9ZEVs8Khlg/edit?usp=sharing). They have not yet been reproduced by a query in this repository. Values are rounded to the precision visible in the screenshot.

**Belgium buyers** is the number of Belgian purchasers shown for a category. **Category penetration** is the screenshot's percentage of Belgium purchasers who bought from that category. These percentages overlap because one purchaser can buy multiple categories. **Belgium sale-price per buyer** divides recorded category `sale_price` by Belgian category buyers. The all-country benchmark divides that category's recorded sale-price total across all countries by its distinct all-country category buyers; it includes Belgium and is purchaser-weighted, not an average of country-level averages. Difference is Belgium's value minus the all-country category benchmark.

| Category | Belgium buyers | Belgium penetration | Belgium item rows | Belgium recorded sale-price value | Belgium sale-price per buyer | All-country category buyers | All-country sale-price per buyer | Difference |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Jeans | 41 | 13.85% | 42 | 3,750.63 | 91.48 | 2,635 | 102.66 | -11.18 |
| Fashion Hoodies | 34 | 11.49% | 37 | 1,966.87 | 57.85 | 2,469 | 54.67 | +3.18 |
| Sleep & Lounge | 33 | 11.15% | 35 | 1,887.43 | 57.19 | 2,319 | 50.62 | +6.58 |
| Tops & Tees | 32 | 10.81% | 32 | 1,328.27 | 41.51 | 2,498 | 43.85 | -2.34 |
| Intimates | 30 | 10.14% | 34 | 1,312.22 | 43.74 | 2,669 | 37.87 | +5.87 |
| Swim | 29 | 9.80% | 30 | 1,358.40 | 46.84 | 2,239 | 58.97 | -12.13 |
| Shorts | 28 | 9.46% | 29 | 1,446.74 | 51.67 | 2,265 | 47.63 | +4.04 |
| Accessories | 25 | 8.45% | 26 | 672.94 | 26.92 | 1,993 | 46.72 | -19.81 |
| Sweaters | 25 | 8.45% | 25 | 2,100.98 | 84.04 | 2,340 | 77.69 | +6.35 |
| Underwear | 24 | 8.11% | 25 | 596.99 | 24.87 | 1,495 | 28.44 | -3.56 |
| Outerwear & Coats | 22 | 7.43% | 24 | 4,321.52 | 196.43 | 1,961 | 150.92 | +45.52 |
| Active | 21 | 7.09% | 21 | 857.71 | 40.84 | 1,787 | 51.52 | -10.68 |
| Dresses | 16 | 5.41% | 17 | 1,559.48 | 97.47 | 1,164 | 89.09 | +8.37 |
| Socks | 16 | 5.41% | 18 | 393.57 | 24.60 | 1,248 | 21.34 | +3.26 |
| Pants | 15 | 5.07% | 16 | 1,101.42 | 73.43 | 1,444 | 63.75 | +9.67 |
| Blazers & Jackets | 13 | 4.39% | 14 | 1,743.54 | 134.12 | 666 | 90.76 | +43.36 |
| Maternity | 12 | 4.05% | 12 | 466.97 | 38.91 | 1,072 | 54.38 | -15.46 |
| Pants & Capris | 12 | 4.05% | 12 | 602.82 | 50.24 | 725 | 55.61 | -5.37 |
| Suits & Sport Coats | 11 | 3.72% | 12 | 1,844.69 | 167.70 | 1,059 | 130.70 | +37.00 |
| Socks & Hosiery | 10 | 3.38% | 10 | 117.70 | 11.77 | 843 | 16.79 | -5.02 |
| Plus | 9 | 3.04% | 9 | 331.42 | 36.82 | 914 | 37.93 | -1.11 |
| Leggings | 8 | 2.70% | 8 | 224.42 | 28.05 | 666 | 28.47 | -0.42 |
| Skirts | 2 | 0.68% | 2 | 131.97 | 65.99 | 464 | 54.01 | +11.97 |
| Suits | 2 | 0.68% | 2 | 266.63 | 133.32 | 226 | 109.28 | +24.03 |
| Jumpsuits & Rompers | 1 | 0.34% | 1 | 139.00 | 139.00 | 173 | 55.32 | +83.68 |
| Clothing Sets | 0 | 0.00% | 0 | 0.00 | — | 53 | 82.74 | — |

Jeans has the most Belgian category purchasers (41; 13.85% of the implied denominator), followed by Fashion Hoodies (34; 11.49%) and Sleep & Lounge (33; 11.15%). Among categories with at least 10 Belgian buyers, the largest positive differences are Outerwear & Coats (+45.52), Blazers & Jackets (+43.36), and Suits & Sport Coats (+37.00). The largest negative differences are Accessories (-19.81), Maternity (-15.46), and Swim (-12.13). Jumpsuits & Rompers has the largest positive difference (+83.68), but only one Belgian buyer, so it is especially unstable as a comparison.

The screenshot's category percentages imply about **296** Belgian purchasers (for example, 41 / 13.85%), while the country result above reports **286**. Check the percentage denominator and query filters in BigQuery before treating the penetration figures as final. The category values themselves are descriptive and do not show why purchasing patterns differ.

## CP2 model status

The CP2 model is designed to test whether country, recorded acquisition source (`traffic_source`), and category-purchase indicators are associated with a purchaser's total recorded 2025 spend. Its Y is `spend_2025`; its X's are country, acquisition source, and one yes/no flag per product category. The table, exploration, training, evaluation, and drivers queries are in `sql/08` through `sql/12`; the draft card is [`model/model_card.md`](model/model_card.md). These queries have not been run in BigQuery, so there are no model metrics or statistically significant drivers to report yet.
