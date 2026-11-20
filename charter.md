# Charter: Belgium Purchasers and Sale-Price Value

## The question in plain language

In 2025, did Belgium have fewer active purchasers than the average country, while its recorded sale-price value per purchaser was above the overall average?

For CP2 Part B, test whether Belgium's higher recorded sale-price value per customer remains after adjusting for customer attributes. Use linear regression with `net_sale_value` as Y and Belgium status, age, gender, acquisition source, signup month, and days active in 2025 as X's. The model tests associations in this dataset; it does not prove causes.

We compare two measures:

- **Belgium's active-purchaser count** with the simple average number of active purchasers across the country groups in the data.
- **Belgium's recorded sale-price value per active purchaser** with the overall average across all active purchasers.

These averages are different. The country-count average gives each country equal weight. The overall sale-price average is total recorded `sale_price` divided by the total number of active purchasers, so countries with more purchasers contribute more to it.

## Who may use this and why

A market-planning manager could use this comparison to decide whether Belgium's relatively small purchaser base and higher recorded value per purchaser deserve further investigation. The result does not explain the reason for the difference or support a budget decision by itself.

As supporting Part A analysis, compare Belgian category purchaser penetration and recorded sale-price value per category purchaser with each category's all-country benchmark. Category findings remain provisional until their query is rerun and the purchaser denominator is reconciled.

## Scope

- **Dataset:** `bigquery-public-data.thelook_ecommerce`
- **Tables:** `order_items` and `users` for the country comparison and current CP2 model. The earlier category-feature CP2 draft also uses `products`; verify its schema before running that historical query.
- **Period:** January 1 through December 31, 2025, based on `order_items.created_at`.
- **Focus:** Belgium, compared with all country groups returned by the same inner join.
- **Recorded sale-price value:** Sum of `order_items.sale_price`; its currency is not confirmed.
- **Active purchaser:** A distinct matched user with at least one joined 2025 order-item row.
- **Join:** `order_items.user_id = users.id`.
- **All-item comparison:** The original country query includes all joined order-item statuses and returns. Country is the user's recorded country, not a verified shipping destination.
- **CP2 model outcome:** Sum of recorded 2025 `sale_price` for each customer, excluding items currently marked `Cancelled` or `Returned`. Keep `Shipped` and `Processing` items, and note that their statuses may change.
- **CP2 model row:** One customer with at least one item not currently marked `Cancelled` or `Returned` during 2025.
- **CP2 model predictors:** `is_belgium`, age in years, `is_male`, `traffic_source`, signup month, and days active in 2025. Signup month means the user's signup month, not purchase month. Items per customer, price per item, and category mix were examined descriptively but omitted from the supplied model because they are measured during the same period and form part of Y; age bands were explored in Part A, while the model uses age as a numeric X.

## What success looks like

- Report Belgium's active-purchaser count and recorded sale-price value per active purchaser.
- Compare its purchaser count with the simple average country count and its per-purchaser value with the overall weighted average.
- Build and check a purchaser-level 2025 model table, evaluate the linear regression, report its r2_score, and interpret coefficients and p-values without causal claims.
- Keep the interpretation descriptive. Do not claim a cause, profitability, or a business shortfall without more evidence.
- Reconcile the all-country total with the earlier CP1 output before combining results from different runs.

## Expected ending

A market-planning manager can use the findings to decide whether Belgium merits more research, but they do not support a budget decision by themselves. Part A suggests Belgium's higher value may be associated with higher-priced product categories, while the regression does not find a significant adjusted Belgium effect; this calls for follow-up rather than a causal conclusion.
