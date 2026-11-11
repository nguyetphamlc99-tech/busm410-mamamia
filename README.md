# MamaMia — BUSM 410 Semester Project

## Team

- **Fun team name:** MamaMia
- **Canvas team:** Add the numeric Canvas team number
- **Team members:** Nguyet Pham and Buyka

## Dataset and project

- **BigQuery dataset:** `bigquery-public-data.thelook_ecommerce`
- **Google Cloud project ID:** `mamamia-busm-410`
- **Repository:** [busm410-mamamia](https://github.com/nguyetphamlc99-tech/busm410-mamamia)

## Problem framing

In the country-year results shared by the team, China, the United States, and Brasil generated 1,680,043.89 recorded `sale_price` units in 2025, or 70.4% of the total across the country rows shown. The benchmark is all remaining country groups, which account for 29.6%; the difference is 40.8 percentage points. The top-three share was 69.9% in 2023, so concentration changed by only 0.5 points. This is the value represented by recorded sales in the leading markets, not estimated profit, lost revenue, or a currency-confirmed dollar amount. See [findings.md](findings.md) and the [team's result sheet](https://docs.google.com/spreadsheets/d/1rDDExt7Uf89crvoLI5ZjTG0p1JqFMs49nnnk2eYQmJY/edit?gid=1679571377#gid=1679571377).

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
