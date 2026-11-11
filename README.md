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

BigQuery results show China, the United States, and Brasil generated 1,680,043.89 recorded `sale_price` units in 2025, or 70.41% of the total across country groups returned by the query. The peer benchmark is all remaining country groups, with 29.59%; the difference is 40.83 percentage points. In 2023 the shares were 69.91% and 30.09%, so the top-three share increased by 0.50 points. These results match the team's [Google Sheets output](https://docs.google.com/spreadsheets/d/1rDDExt7Uf89crvoLI5ZjTG0p1JqFMs49nnnk2eYQmJY/edit?gid=1679571377#gid=1679571377) at the displayed precision. This is recorded sale-price value, not estimated profit, lost revenue, or a currency-confirmed dollar amount. See [findings.md](findings.md).

## Explore the work

| File | What it contains |
|---|---|
| [AGENTS.md](AGENTS.md) | Project facts and instructions for AI-assisted work |
| [charter.md](charter.md) | Project question, decision, scope, and success criteria |
| [findings.md](findings.md) | Measured gap, peer benchmark, value, and chart |
| [sql/README.md](sql/README.md) | Query process, cleaning decisions, and interpretation |
| [sql/01_data_quality_checks.sql](sql/01_data_quality_checks.sql) | Data-quality checks for fields used in the analysis |
| [sql/02_country_revenue_by_year.sql](sql/02_country_revenue_by_year.sql) | Reproduces country-year sale-price totals |
| [sql/03_top_three_concentration.sql](sql/03_top_three_concentration.sql) | Calculates top-three share and peer comparison |
| [sql/04_time_to_sell_by_category.sql](sql/04_time_to_sell_by_category.sql) | Earlier exploratory query retained for context |
| [visuals/gap_chart.png](visuals/gap_chart.png) | 2023 and 2025 revenue-share comparison |
| [Other/README.md](Other/README.md) | Dataset documentation links and table notes |
| [Other/thelook_revenue_erd.dbml](Other/thelook_revenue_erd.dbml) | Source for the table relationship diagram |
| [Other/table_diagram.png](Other/table_diagram.png) | Diagram of tables and join |
| [Other/audit_protocol.md](Other/audit_protocol.md) | Draft process for reviewing AI-assisted work |
| [Other/audit_log.md](Other/audit_log.md) | Human audit records; entries are added after team approval |
| [.agents/skills/project-audit/SKILL.md](.agents/skills/project-audit/SKILL.md) | Project-specific audit instructions |

## BigQuery access screenshot

[View the IAM access screenshot](iam-access.png)
