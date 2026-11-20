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

The original all-item comparison shows 286 active purchasers in Belgium, versus a simple average of 1,959 per country, and about 110.13 recorded sale-price units per purchaser versus 100.13 overall. A later customer-level comparison excludes items currently marked `Cancelled` or `Returned`: Belgium averages 104.44 units across 219 customers, compared with 96.44 units across 17,821 customers elsewhere. The team-supplied regression has an `r2_score` of 0.0004; it finds positive adjusted associations for male customers and Facebook acquisition, while the Belgium coefficient is not statistically significant. See [findings.md](findings.md) and the [model card](model/model_card.md) for definitions, limitations, and provenance.

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
| [sql/07_belgium_category_purchasers_2025.sql](sql/07_belgium_category_purchasers_2025.sql) | Draft category comparison query for Belgium and all-country category benchmarks |
| [sql/08_cp2_customer_analysis_table.sql](sql/08_cp2_customer_analysis_table.sql)–[sql/12_cp2_spend_model_drivers.sql](sql/12_cp2_spend_model_drivers.sql) | Earlier CP2 model draft, retained for history; it uses same-year category features and is superseded |
| [sql/13_customer_spend_table_2025.sql](sql/13_customer_spend_table_2025.sql) | Builds the 2025 customer-level table excluding currently cancelled or returned items |
| [sql/14_customer_spend_model.sql](sql/14_customer_spend_model.sql) | Trains, evaluates, and returns weights for the customer-level linear model |
| [model/model_card.md](model/model_card.md) | Customer-level model definition, supplied results, drivers, and limits |
| [Other/README.md](Other/README.md) | Dataset documentation links and table notes |
| [Other/thelook_revenue_erd.dbml](Other/thelook_revenue_erd.dbml) | Source for the table relationship diagram |
| [Other/table_diagram.pdf](Other/table_diagram.pdf) | Printable table relationship diagram |
| [Other/table_diagram.png](Other/table_diagram.png) | Diagram of tables and join |
| [Other/audit_protocol.md](Other/audit_protocol.md) | Draft process for reviewing AI-assisted work |
| [Other/audit_log.md](Other/audit_log.md) | Human audit records, added after team approval |

## Important limits

The original country comparison includes every matched 2025 order item, without filtering status. The later customer-level model excludes items currently marked `Cancelled` or `Returned`, but retains `Shipped` and `Processing` items; those statuses could still change. `sale_price` is recorded item-sale value in an unconfirmed currency, not confirmed dollars, net revenue, or profit. The model results were supplied by the team and were not independently rerun during this edit. The analysis is descriptive and does not establish why countries differ.
