# AGENTS.md — MamaMia BUSM 410

## Project purpose
This repository contains the MamaMia team semester project for BUSM 410. The team uses Google BigQuery to analyze the public `thelook_ecommerce` dataset, document data quality checks, build analysis, and communicate findings.

## Project context
- Team: MamaMia
- Team members: Thi Pham and Buyka
- Google Cloud / BigQuery project ID: `mamamia-busm-410`
- Source dataset: `thelook_ecommerce`
- Repository: `busm410-mamamia`

## Instructions for AI coding agents
1. Read `README.md`, `charter.md`, `audit_protocol.md`, and `audit_log.md` before making substantial changes.
2. Keep work within this repository. Do not change unrelated projects, repositories, cloud resources, or access permissions.
3. Explain planned changes in simple, clear English. Prefer small, reviewable edits over large rewrites.
4. Do not invent query results, findings, team contributions, data-quality issues, or citations. Clearly label examples and assumptions.
5. Never commit credentials, API keys, service-account JSON, tokens, private customer data, or other secrets. Do not expose sensitive information in logs.
6. Ask before running queries that may incur significant BigQuery costs, changing IAM, deleting data, or publishing results.
7. Use BigQuery Standard SQL. Prefer explicit column names, meaningful aliases, readable formatting, and comments explaining non-obvious logic.
8. For exploratory queries, limit rows when practical and avoid `SELECT *` on large tables. Use fully qualified table names when necessary.
9. Treat source tables as read-only unless a task explicitly authorizes modifications. Do not use destructive SQL without approval.
10. Validate queries and calculations where access is available. If execution is unavailable, state that SQL was not run.
11. Keep markdown concise and student-friendly; preserve the team's existing structure and assignment requirements.
12. Do not overwrite a teammate's work without checking existing changes.

## Repository structure
- `README.md`: overview, team, dataset, and setup
- `charter.md`: project scope and goals
- `audit_protocol.md`: planned quality checks
- `audit_log.md`: results and history of checks
- `sql/`: saved BigQuery SQL queries
- `model/`: analysis and model notes or results
- `visuals/`: charts and visual explanations
- `iam-access.png`: existing access screenshot; avoid exposing additional account details

## Expected workflow
1. Understand the request and inspect relevant existing files.
2. Propose a brief plan for any substantial change.
3. Implement only the requested changes.
4. Check formatting, SQL syntax, paths, and links.
5. Summarize which files changed, what was verified, and what remains to be done.

## Documentation and analysis standards
- Document data source, query purpose, filters, date ranges, and important assumptions.
- For data-quality checks, record the test, SQL used, observed result, interpretation, and follow-up in `audit_log.md`.
- Distinguish descriptive findings from causal claims.
- Include reproducible SQL or clear calculation steps for reported metrics.
- Do not present unexecuted SQL as verified output.

## Collaboration
- Respect the contributions of both team members.
- Prefer descriptive commit messages such as `Add order quality checks`.
- Keep screenshots, charts, and documentation named clearly.
- Ask for clarification when instructions conflict with the course assignment or existing project decisions.
