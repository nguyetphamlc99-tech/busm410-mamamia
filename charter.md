# Charter: Do Sales Contributions Match Purchaser Counts?

## The question in plain language

In 2025, did the United States or China contribute a much larger share of recorded item-sale value than its share of active purchasers?

We answer this by comparing two percentages for each country:

- **Share of recorded item-sale value:** that country's sum of `sale_price` divided by the sum for all countries.
- **Share of active purchasers:** the number of users in that country who made at least one 2025 purchase, divided by the number of active purchasers across all countries.
- **Difference:** item-sale-value share minus active-purchaser share, in percentage points.

If the difference is positive, the country's share of item-sale value is higher than its share of purchasers. If it is negative, the value share is lower. A difference near zero means the shares are about the same. We also compare each country's item-sale value per active purchaser with the overall average: total item-sale value across all countries divided by all active purchasers. This is a weighted average across purchasers, not an average of country averages. These comparisons are not targets or industry benchmarks.

**Important:** `sale_price` is summed from order-item rows. This measures recorded item-sale value, not the number of transactions. The currency is not confirmed, and the query does not remove returns or canceled items.

## Who may use this and why

A marketing or market-planning manager could use the comparison to decide whether to look more closely at purchaser numbers or spending patterns in these two markets. The current figures do not prove a problem or support a budget change. The data does not include profit, marketing costs, market potential, or a target country mix.

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

- Report sales share, active-purchaser share, share gap, and sale-price value per active purchaser for the U.S. and China, alongside the all-country average.
- Check that both countries' figures use the same 2025 period and joined population.
- Reconcile the focused query's all-country sales total with the earlier CP1 output before finalizing the comparison.
- Treat any difference as descriptive. Do not call it a business shortfall or recommend budget changes without a target and evidence about costs, profit, or market potential.
