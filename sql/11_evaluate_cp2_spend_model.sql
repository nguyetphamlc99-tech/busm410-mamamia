-- CP2 Part B: Evaluate the linear regression on BigQuery ML's held-out rows; see sql/README.md.
SELECT *
FROM ML.EVALUATE(MODEL `mamamia-busm-410.cp2.spend_model`);
