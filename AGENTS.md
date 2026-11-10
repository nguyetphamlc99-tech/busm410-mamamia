# AGENTS.md — MamaMia BUSM 410

## Project

- Team: MamaMia
- Team members: Nguyet Pham and Buyka
- Dataset: `thelook_ecommerce`
- BigQuery project ID: `mamamia-busm-410`
- Repository: `nguyetphamlc99-tech/busm410-mamamia`

The instructor example uses a different dataset and project. Follow its review process, but do not copy its dataset details, findings, or calculations into this project.

## Before starting substantial work

1. Read `README.md`, `charter.md`, `audit_protocol.md`, and the latest entries in `audit_log.md`.
2. Remind the team to run `git pull` before applying changes.
3. Explain the goal and proposed change in plain language. Keep changes small and reviewable.
4. Confirm the work fits the team's project and checkpoint.
5. Ask before changing IAM, deleting data, publishing results, or running a query that may incur significant cost.

## BigQuery and SQL

- Use BigQuery Standard SQL and read source tables only.
- Confirm table and column names in BigQuery before suggesting them. Do not assume a schema for `thelook_ecommerce`.
- Start with a query draft. Explain what one row represents, which columns are needed, and how the query answers the question. Let the team review the draft before saving or running it.
- Ask the team to provide the BigQuery editor's estimated scan before running the query. Record the estimate in `sql/notes.md`.
- Select only the columns needed. `LIMIT` does not reduce bytes scanned.
- Never use destructive SQL unless the team explicitly authorizes it.
- Do not describe a query as tested or its results as verified unless it was actually run and checked.
- Save approved queries as `sql/NN_short_name.sql`. Each SQL file gets a one-line header; put purpose, estimated cost, results, and decisions in `sql/notes.md`.

## Sources and findings

- Support data claims with a source document and page, or with reproducible SQL and its results.
- Say when a statement is an inference or assumption rather than a documented fact.
- Separate descriptive findings from causal claims.
- Do not invent results, data-quality issues, citations, assumptions, or team contributions.
- Do not add credentials, API keys, service-account files, tokens, or private customer data to the repository.

## Audit protocol and log

- Use `audit_protocol.md` as the team's process for checking AI-assisted work.
- If a new practice would improve the protocol, propose one short addition and get the team's agreement before editing it.
- Use `audit_log.md` only to record meaningful human checks of the agent's work, such as catching an error, verifying a claim, or changing the analysis after review.
- Do not log routine approvals, the agent's own checks, or checks of human work.
- Before adding an entry, read earlier entries, find the next unused number, and show the proposed category and wording to the team. Add it only after approval. Never invent checks, results, dates, or sources.

## Git and collaboration

- The team runs every commit, merge, and push. Suggest when to commit and provide commands when useful.
- Check for teammate changes before replacing or removing their work.
- Keep changes within this repository. Do not change unrelated repositories or cloud resources.

## Wrap up

After making an approved change, check formatting, links, paths, and SQL syntax when possible. Summarize the files changed, what was checked, and what still needs team input. If a query could not be run, say so.
