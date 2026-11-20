# MamaMia — BUSM 410 Semester Project

## Team

- **Fun team name:** MamaMia
- **Canvas team:** ManaMia
- **Team members:** Nguyet Pham and Buyka

## Dataset and project

- **BigQuery dataset:** `bigquery-public-data.thelook_ecommerce`
- **Google Cloud project ID:** `mamamia-busm-410`
- **Repository:** [busm410-mamamia](https://github.com/nguyetphamlc99-tech/busm410-mamamia)

## Problem framing

### The question

In 2025, did the United States or China account for a much bigger share of recorded item-sale value than of the people who bought something?

We compare each country's share of the summed `sale_price` values with its share of active purchasers. We also compare each country's sale-price value per active purchaser with the average across all countries. An active purchaser is a user with at least one 2025 order item. These values come from item prices, **not from counting transactions**, and the currency for `sale_price` has not been confirmed.

### What we found so far

China accounts for 33.79% of recorded item-sale value and about 33.65% of active purchasers. The United States accounts for 22.48% of item-sale value and about 22.70% of active purchasers. Average recorded item-sale value per active purchaser is about 100.55 units in China, 99.16 in the U.S., and 100.13 across all countries. The country averages are close to the overall average, and the share differences are small. This comparison does **not** show a clear mismatch or a proven business problem. It may help a market-planning manager decide whether more research is needed; it does not justify changing a budget by itself.

An additional all-country comparison found Poland lowest among the 12 countries shown, at about 72.19 recorded sale-price units per active purchaser versus the overall average of about 100.13. Poland is about 27.94 units (27.9%) below that average, based on 45 active purchasers. This is a descriptive result, not proof of a cause or business problem. See [`sql/11_country_sale_price_per_active_purchaser_2025.sql`](sql/11_country_sale_price_per_active_purchaser_2025.sql).

The total item-sale value in this run does not match the earlier CP1 total, so the result is still provisional. See [findings.md](findings.md) for details.

## Explore the work

| File | What it contains |
|---|---|
| [AGENTS.md](AGENTS.md) | Project facts and instructions for AI-assisted work |
| [charter.md](charter.md) | Project question, decision, scope, and success criteria |
| [findings.md](findings.md) | Focused U.S.–China comparison, preliminary U.S. result, CP1 context, and limits |
| [sql/README.md](sql/README.md) | Query process, cleaning decisions, and interpretation |
| [sql/01_data_quality_checks.sql](sql/01_data_quality_checks.sql) | Data-quality checks for fields used in the analysis |
| [sql/02_country_revenue_by_year.sql](sql/02_country_revenue_by_year.sql) | Reproduces country-year sale-price totals |
| [sql/03_top_three_concentration.sql](sql/03_top_three_concentration.sql) | Calculates top-three share and peer comparison |
| [sql/04_time_to_sell_by_category.sql](sql/04_time_to_sell_by_category.sql) | Earlier exploratory query retained for context |
| [sql/05_us_china_sales_vs_purchaser_share_2025.sql](sql/05_us_china_sales_vs_purchaser_share_2025.sql) | Compares U.S. and China sales shares with their active-purchaser shares in 2025 |
| [sql/11_country_sale_price_per_active_purchaser_2025.sql](sql/11_country_sale_price_per_active_purchaser_2025.sql) | Compares each country's sale-price value per active purchaser with the all-country average |
| [visuals/gap_chart.png](visuals/gap_chart.png) | Earlier 2023 and 2025 top-three concentration comparison |
| [Other/README.md](Other/README.md) | Dataset documentation links and table notes |
| [Other/thelook_revenue_erd.dbml](Other/thelook_revenue_erd.dbml) | Source for the table relationship diagram |
| [Other/table_diagram.pdf](Other/table_diagram.pdf) | Printable table relationship diagram |
| [Other/table_diagram.png](Other/table_diagram.png) | Diagram of tables and join |
| [Other/audit_protocol.md](Other/audit_protocol.md) | Draft process for reviewing AI-assisted work |
| [Other/audit_log.md](Other/audit_log.md) | Human audit records; entries are added after team approval |
| [.agents/skills/project-audit/SKILL.md](.agents/skills/project-audit/SKILL.md) | Project-specific audit instructions |

## BigQuery access screenshot

[View the IAM access screenshot](iam-access.png)
