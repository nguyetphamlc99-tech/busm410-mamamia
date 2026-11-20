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

We compare each country's share of the summed `sale_price` values with its share of active purchasers. An active purchaser is a user with at least one 2025 order item. The sales share comes from item-price values, **not from counting transactions**. The currency for `sale_price` has not been confirmed.

### What we found so far

China accounts for 33.79% of recorded item-sale value and about 33.65% of active purchasers. The United States accounts for 22.48% of item-sale value and about 22.70% of active purchasers. The differences are small, so this comparison does **not** show a clear mismatch or a proven business problem. The result may help a market-planning manager decide whether more research is needed; it does not justify changing a budget by itself.

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
