# Audit protocol — draft for team review

**Status:** Draft, not yet approved by the team. Please review and agree before treating this as the established process.

## How we work with the agent

- State the project question and expected deliverable before asking for analysis or edits.
- Ask the agent to explain the source, query logic, row grain, assumptions, and interpretation in plain language.
- Review the query and BigQuery's estimated bytes before running it. Record the estimate and job result in `sql/README.md`.
- Run the SQL in BigQuery and compare its output with the values in `findings.md`. Ask the agent to reconcile any mismatch.
- Check that data claims match source documentation and query output; distinguish observed facts from assumptions and causal explanations.
- Run the data-quality checks and decide together how to handle issues before any filtering or deduplication.
- Review file links, chart labels, arithmetic, and the difference between sale-price totals and profit or net revenue.
- Ask the agent to show any proposed audit-log entry and category. Add it only after a team member approves it.
- Keep credentials and private records out of the public repository.

## Decisions and limitations

- The country revenue analysis is descriptive. Do not infer a cause or financial benefit without additional evidence.
- The country field represents the user's country in the source table.
- Results remain provisional until the team reruns the queries, validates year coverage and country groups, and confirms the unit of `sale_price`.
