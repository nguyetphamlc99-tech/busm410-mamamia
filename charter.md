# Charter: Country Revenue Concentration

## The question

How much of the recorded order-item sale-price total comes from the three highest-revenue user countries, and how does that compare with the remaining countries in 2023 and 2025?

## The decision this supports

This analysis helps a project or marketing manager decide whether to investigate customer, order, and spending patterns in the highest-revenue user countries before making market-planning decisions. The current results describe concentration; they do not support reallocating a budget on their own.

## Scope

- **Dataset:** `bigquery-public-data.thelook_ecommerce`
- **Tables:** `order_items` and `users`
- **Years compared:** 2023 and 2025. 2026 is excluded because it may be incomplete.
- **Measure:** Sum of `order_items.sale_price`, grouped by `users.country` and the year of `order_items.created_at`.
- **Benchmark:** The combined sale-price total for all other country groups in each same year.
- **Join:** `order_items.user_id = users.id`.
- **One result row:** One user-country group per order-item creation year. This is not one order or one customer.
- The query does not filter item statuses or returns and uses an inner join. It therefore measures recorded sale-price totals for joined order items, not net revenue or profit. The country is the user's recorded country, not verified shipping destination.

## What success looks like

- Reproduce the country-year totals from the numbered SQL files.
- Confirm the total includes all country groups and investigate missing country or unmatched user records.
- Report the top-three share and the remaining-country benchmark for both comparison years.
- Show the difference in percentage points and explain what the value represents.
- Keep the conclusion descriptive unless additional analysis supports a causal explanation.
