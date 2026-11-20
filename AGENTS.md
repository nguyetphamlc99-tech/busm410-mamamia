# AGENTS.md — MamaMia BUSM 410

## Project facts

- **Team:** MamaMia
- **Members:** Nguyet Pham and Buyka
- **Dataset:** `bigquery-public-data.thelook_ecommerce`
- **BigQuery project ID:** `mamamia-busm-410`
- **Repository:** `nguyetphamlc99-tech/busm410-mamamia`
- **Current analysis:** Compare Belgium's 2025 active-purchaser count with the average country count, and its recorded sale-price value per purchaser with the overall purchaser-weighted average. CP2 additionally explores country/category associations with purchaser-level recorded spend; its model has not yet been run.

### Tables, columns, and grain

- `order_items`: analysis uses `id`, `user_id`, `created_at`, and `sale_price`. One source row is an order-item record.
- `users`: country analysis uses `id` and `country`; CP2 also uses `traffic_source` as the recorded acquisition channel. Country is the user's recorded country, not a confirmed shipping destination.
- CP2 analysis assumes `order_items.product_id = products.id` and `products.category`; confirm these fields in BigQuery before running query 08.
- Join: `order_items.user_id = users.id`.
- Current query grain: one row for Belgium, compared with averages calculated from all joined country groups.
- CP2 model-table grain: one row per purchaser with a matched 2025 order item. Model Y is 2025 recorded spend; X's are country, acquisition source, and category purchase flags.
- Confirm exact column descriptions and types in BigQuery before relying on them. See [Other/README.md](Other/README.md).

### Current result and prior CP1 context

The team's BigQuery screenshot shows 12 country groups. Belgium has 286 active purchasers, the highest recorded sale-price value per active purchaser in the displayed results (about 110.13 units), and total recorded sale-price value of about 31,497.54 units. The overall purchaser-weighted average is about 100.13 units per active purchaser. The simple average purchaser count across the 12 country groups is 1,959. See [findings.md](findings.md).

The latest all-country sale-price total is 2,353,813.65 units, which differs from an earlier CP1 output. Rerun queries 02 and 03 under the same date filter and source state before combining those totals.

### Cleaning and interpretation rules

- Use `sale_price` as recorded in the source. Do not call the result dollars until the currency/unit is confirmed in dataset documentation.
- The country and focused queries include every joined order-item row; they have no status or return filter. Describe the metric as summed recorded order-item `sale_price`, not net revenue or profit.
- The query uses an inner join. Check unmatched `user_id` values and country blanks before interpreting totals.
- Both data-quality statements ran successfully (7.23 MB and 1.38 MB processed). The year-coverage result shows 66,265 rows in 2026 and a latest timestamp of 2026-11-14 23:48:20 UTC; the screenshot is dated 2026-11-11, so this timestamp appears future-dated. The diagnostic output shows 1,582 future `created_at` values and zero for the other nine checks. Investigate the future timestamps; do not filter them automatically.
- Do not remove or deduplicate records without reviewing what the records represent and documenting the rule.
- Use the completed 2025 calendar year for the focused comparison. Omit 2026 from annual comparisons because it may be partial.
- Treat the analysis as descriptive. It does not establish why countries differ or quantify a financial loss.

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
