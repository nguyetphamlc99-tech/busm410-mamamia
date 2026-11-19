# Charter: U.S. and China Sales Contribution

## The question

In 2025, how did the United States and China differ in recorded order-item sale-price contribution relative to each country's share of active purchasers?

The comparison is:

- **Country sales share:** 2025 `sale_price` from order items joined to users in that country, divided by 2025 `sale_price` across all joined user-country groups.
- **Country active-purchaser share:** distinct users in that country with at least one joined 2025 order item, divided by distinct active users across all joined user-country groups.
- **Share gap:** each country's sales share minus its active-purchaser share, in percentage points.

If a country's share gap is positive, that country accounts for a larger share of recorded sales than of active purchasers; if negative, its sales share is smaller. A zero or near-zero gap means the shares are similar. The query also compares recorded sale-price value per active purchaser. These are internal comparisons, not targets or industry benchmarks.

## The decision this supports

The intended stakeholder is a marketing or market-planning manager deciding whether to investigate customer-base size or spend patterns in two leading markets. The comparison can show whether sales contributions are proportional to the active-purchaser bases in the United States and China. It cannot establish profitability, market risk, or whether budget should change.

## Scope

- **Dataset:** `bigquery-public-data.thelook_ecommerce`
- **Tables:** `order_items` and `users`
- **Period:** January 1 through December 31, 2025, based on `order_items.created_at`.
- **Focus countries:** `United States` and `China`, as recorded in `users.country`.
- **Sales measure:** Sum of `order_items.sale_price`; this is recorded item sale-price value, not confirmed dollars, net revenue, or profit.
- **Active purchaser:** A distinct matched `users.id` with at least one joined order-item row in 2025.
- **Comparison group:** All user-country groups returned by the same inner join; the all-country denominators include both focus countries.
- **Join:** `order_items.user_id = users.id`.
- The query does not filter item status or returns. It measures recorded sale-price value associated with the user's recorded country, not verified shipping destination.

## What success looks like

- Report sales share, active-purchaser share, share gap, and recorded sale-price per active purchaser for both countries from one query run.
- Check that both countries' figures use the same 2025 period and joined population.
- Reconcile the focused query's all-country sales total with the earlier CP1 output before finalizing the comparison.
- Treat any difference as descriptive. Do not call it a business shortfall or recommend budget changes without a target and evidence about costs, profit, or market potential.
