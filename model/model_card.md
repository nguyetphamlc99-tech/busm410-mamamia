# Model Card: Belgium Purchaser Spend, 2025

**Status: Draft — BigQuery model and result fields still need to be run and filled in.** Do not submit this card with blank results.

## What the model asks

Among purchasers with at least one 2025 order item, which recorded country and product categories are associated with higher total recorded sale-price value in 2025?

| | |
|---|---|
| **Y (outcome)** | `spend_2025`: one purchaser's sum of recorded `order_items.sale_price` for 2025; a number. |
| **Model** | BigQuery ML linear regression ([training SQL](../sql/10_train_cp2_spend_model.sql)). |
| **X's (features)** | User country and yes/no indicators for whether the purchaser bought each product category during 2025. |
| **Analysis table** | One row per purchaser with a matched order item in 2025 ([table SQL](../sql/08_cp2_customer_analysis_table.sql)). |
| **Training/test split** | BigQuery ML's default split. Fill in the actual row count and whether a held-out set was used after running the table and model. The course guide says tables with fewer than 500 rows have no held-out rows. |

The category indicators and outcome come from the same year. Their model associations do not show that buying a category causes higher spend; category item values are part of total spend by definition. Country is the main adjusted comparison of interest, with the category indicators held steady.

## Part A: Looking at the data

The descriptive category results are transcribed in [findings.md](../findings.md). Before modeling, run [the analysis-table checks](../sql/09_explore_cp2_analysis_table.sql) and confirm one row per purchaser, nonmissing spend labels, and the count of Belgium purchasers. The category screenshot's percentages imply about 296 Belgian purchasers, while the earlier country result reports 286; reconcile this before finalizing the penetration numbers.

## Report card: does it predict well?

Run [the evaluation query](../sql/11_evaluate_cp2_spend_model.sql) and fill in the held-out `r2_score`.

| Measure | Your number | What it means |
|---|---:|---|
| r2_score | Pending BigQuery run | 0 means no better than always guessing the test rows' average spend; closer to 1 means more variation explained. |

> Our r2_score is [number], so the model explains [a lot / a little] of the ups and downs in recorded 2025 sale-price value per purchaser.

An association can still be useful for inference when the r2_score is weak. Describe prediction quality honestly.

## Drivers: which X's have a real association?

Run [the driver query](../sql/12_cp2_spend_model_drivers.sql). Paste the non-intercept rows and fill in the signs, p-values, and readings. A p-value below 0.05 is evidence of an association in this model, not proof of cause. For categorical features, skip comparison rows with a zero weight and `NaN` p-value. Write `p < 0.0001` when BigQuery displays `0.0`.

| Feature | Coefficient | p-value | Reading |
|---|---:|---:|---|
| Country category weights (report Belgium against the comparison country shown by BigQuery) | Pending BigQuery run | Pending BigQuery run | Pending |
| One row for each product-category indicator returned | Pending BigQuery run | Pending BigQuery run | Pending |

Expand the table to one row per returned weight. Identify the omitted zero-weight/NaN category as the comparison group. For the two strongest associations, complete after reading the output:

- **[Feature]** has a [positive/negative] coefficient and p-value [number], so holding the other X's steady, [interpret the association with spend_2025].
- **[Feature]** has a [positive/negative] coefficient and p-value [number], so holding the other X's steady, [interpret the association with spend_2025].

## Expected ending

The charter says this work helps a market-planning manager decide whether Belgium merits further research; it does not support a budget decision on its own. After reviewing Part A and the model, keep or revise that ending and add one sentence on what the data taught the team.

## Limits and run status

- The model has not been run in BigQuery from this session. BigQuery is unavailable here because its connector is disabled by the workspace administrator.
- The table SQL assumes `order_items.product_id = products.id` and `products.category`; confirm those fields in BigQuery before running.
- `sale_price` currency is unconfirmed. The outcome is summed recorded order-item sale price, not confirmed dollars, net revenue, or profit.
- The query does not filter canceled items or returns. Country is the user's recorded country, not a verified shipping destination.
- The comparison is descriptive and does not establish why a purchaser spends more or whether a business action would be profitable.
