# MamaMia — BUSM 410 Semester Project

## Team

- **Team name:** MamaMia
- **Team members:** Nguyet Pham and Buyka

## Dataset and project

- **BigQuery source:** `bigquery-public-data.thelook_ecommerce`
- **Google Cloud project ID:** `mamamia-busm-410`
- **Repository:** [busm410-mamamia](https://github.com/nguyetphamlc99-tech/busm410-mamamia)

## Project question

In 2025, did Belgium have fewer active purchasers than the average country, while its recorded sale-price value per purchaser was above the overall average?

The results show 286 active purchasers in Belgium, compared with a simple average of 1,959 purchasers per country. Belgium's recorded sale-price value per active purchaser was about 110.13 units, compared with an overall average of about 100.13. That is about 10% above the overall average. These figures describe the data; they do not explain the reason or prove that growing Belgium's purchaser base would be profitable.

The simple average purchaser count gives each country equal weight. The overall sale-price value per purchaser is calculated across all active purchasers, so countries with more purchasers contribute more to it. The `sale_price` currency has not been confirmed.

## Explore the work

| File | What it contains |
|---|---|
| [charter.md](charter.md) | Belgium question, scope, and intended use |
| [findings.md](findings.md) | Belgium results, comparison averages, and limitations |
| [sql/README.md](sql/README.md) | Query descriptions, run notes, and cleaning choices |
| [sql/01_data_quality_checks.sql](sql/01_data_quality_checks.sql) | Data-quality checks for the source fields |
| [sql/02_country_revenue_by_year.sql](sql/02_country_revenue_by_year.sql) | Earlier country-year totals retained for context |
| [sql/03_top_three_concentration.sql](sql/03_top_three_concentration.sql) | Earlier country concentration analysis |
| [sql/04_time_to_sell_by_category.sql](sql/04_time_to_sell_by_category.sql) | Earlier exploratory query retained for history |
| [sql/06_belgium_vs_country_averages_2025.sql](sql/06_belgium_vs_country_averages_2025.sql) | Compares Belgium with the country-count and all-purchaser averages |
| [Other/README.md](Other/README.md) | Dataset documentation links and table notes |
| [Other/thelook_revenue_erd.dbml](Other/thelook_revenue_erd.dbml) | Source for the table relationship diagram |
| [Other/table_diagram.pdf](Other/table_diagram.pdf) | Printable table relationship diagram |
| [Other/table_diagram.png](Other/table_diagram.png) | Diagram of tables and join |
| [Other/audit_protocol.md](Other/audit_protocol.md) | Draft process for reviewing AI-assisted work |
| [Other/audit_log.md](Other/audit_log.md) | Human audit records, added after team approval |

## Important limits

The analysis sums `order_items.sale_price` for matched users with an order item in 2025. It does not filter returns or canceled items. The measure is recorded item-sale value, not a transaction count, confirmed dollars, net revenue, or profit. The analysis is descriptive and does not establish why countries differ.
