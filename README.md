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

The focused question compares the United States and China in 2025: each country's share of recorded order-item sale-price value, its share of active purchasers, and recorded sale-price value per active purchaser. The corrected query shows China at 33.79% of sales and 7,910 active purchasers; the U.S. at 22.48% and 5,336 purchasers. These shares are close to the countries' shares of active purchasers, so the comparison does not show a substantial mismatch. The all-country sales total differs from the earlier CP1 result and needs reconciliation before finalizing. See [findings.md](findings.md).

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
