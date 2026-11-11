# AGENTS.md — MamaMia BUSM 410

## Project facts

- **Team:** MamaMia
- **Members:** Nguyet Pham and Buyka
- **Dataset:** `bigquery-public-data.thelook_ecommerce`
- **BigQuery project ID:** `mamamia-busm-410`
- **Repository:** `nguyetphamlc99-tech/busm410-mamamia`
- **Current analysis:** Country-level concentration in order-item sale-price totals.

### Tables, columns, and grain

- `order_items`: analysis uses `id`, `user_id`, `created_at`, and `sale_price`. One source row is an order-item record; the revenue query aggregates these records by year of `created_at`.
- `users`: analysis uses `id` and `country`. The country is the user's recorded country, not confirmed shipping destination.
- Join: `order_items.user_id = users.id`.
- One output row represents one user-country group in one order-item creation year.
- Confirm exact column descriptions and types in BigQuery before relying on them. See [Other/README.md](Other/README.md).

### Gap and benchmark facts

The team ran the numbered revenue queries in BigQuery. The assistant did not run them. The result screenshots show the 2023 and 2025 top-three summary below; the rounded figures agree with [the team's Google Sheet](https://docs.google.com/spreadsheets/d/1rDDExt7Uf89crvoLI5ZjTG0p1JqFMs49nnnk2eYQmJY/edit?gid=1679571377#gid=1679571377) at the displayed precision.

| Year | Top three (China, United States, Brasil) | Total across joined country groups | Top-three share | Other-country share |
|---:|---:|---:|---:|---:|
| 2023 | 796,883.74 | 1,139,791.91 | 69.91% | 30.09% |
| 2025 | 1,680,043.89 | 2,385,947.97 | 70.41% | 29.59% |

The peer benchmark is all other country groups returned by the query in the same year. In 2025 the top-three share exceeds the remaining-country share by 40.83 percentage points. The top-three share increased by 0.50 percentage points from 2023 to 2025. The BigQuery results confirm these totals at two-decimal precision; the diagnostic check results still need review before data quality is considered verified.

### Cleaning and interpretation rules

- Use `sale_price` as recorded in the source. Do not call the result dollars until the currency/unit is confirmed in dataset documentation.
- The current query includes every joined order-item row; it has no status or return filter. Describe the metric as summed recorded order-item `sale_price`, not net revenue or profit.
- The query uses an inner join. Check unmatched `user_id` values and country blanks before interpreting totals.
- Both data-quality statements ran successfully (7.23 MB and 1.38 MB processed). The year-coverage result shows 66,265 rows in 2026 and a latest timestamp of 2026-11-14 23:48:20 UTC; the screenshot is dated 2026-11-11, so this timestamp appears future-dated. The first statement's diagnostic counts still need review. Do not claim the data passed all checks or filter the timestamp without investigation.
- Do not remove or deduplicate records without reviewing what the records represent and documenting the rule.
- Omit 2026 from the comparison because it may be a partial year.
- Treat the analysis as descriptive. It does not establish why revenue is concentrated or quantify a financial loss.

## Before starting substantial work

1. Read `README.md`, `charter.md`, `Other/audit_protocol.md`, and the latest entries in `Other/audit_log.md`.
2. Remind the team to run `git pull` before local edits.
3. Explain the goal and proposed change. Keep changes small and reviewable.
4. Confirm the work fits the project and checkpoint.
5. Ask before changing IAM, deleting data, publishing results, or running a query that may incur significant cost.

## BigQuery and SQL

- Use BigQuery Standard SQL and read source tables only.
- Confirm schema in BigQuery. Do not assume undocumented fields or meanings.
- Explain each query's purpose, row grain, columns, and expected output before use.
- Ask the team for BigQuery's estimated bytes before a potentially costly query; record estimates in `sql/README.md`.
- Select only the columns needed. `LIMIT` does not reduce bytes scanned.
- Never use destructive SQL unless explicitly authorized.
- Do not describe a query as run, tested, or verified unless it was actually run and checked.
- Save numbered queries as `sql/NN_short_name.sql`. Each starts with a short comment linking to `sql/README.md`.

## Sources and findings

- Support data claims with documentation and reproducible SQL/results.
- Distinguish facts from assumptions and inference.
- Separate descriptive findings from causal claims.
- Do not invent results, quality-check outcomes, sources, or team contributions.
- Do not add credentials, keys, tokens, service-account files, or private data.

## Audit protocol and log

- Treat `Other/audit_protocol.md` as a draft until the team reviews and agrees to it.
- Use `Other/audit_log.md` only for meaningful human checks of agent work.
- Do not log routine approvals, the agent's own checks, or checks of human work.
- Before an entry, read the log, find the next unused number, and show the proposed category and wording to the team. Add only after approval.
- Never invent checks, results, dates, or sources.

## Git and collaboration

- The team runs commits, merges, and pushes from a local checkout. Check for teammate changes before replacing work.
- Keep changes within this repository.

## Wrap up

Check formatting, links, paths, and SQL syntax when possible. Summarize what changed, what was checked, and what still needs team input. If a query could not be run, say so.
