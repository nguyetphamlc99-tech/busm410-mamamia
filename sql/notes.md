# SQL Notes

## `01_time_to_sell_by_category.sql`

- **Purpose:** Compare average elapsed days from inventory-item creation to sale by category and creation year.
- **Source:** `bigquery-public-data.thelook_ecommerce.inventory_items`.
- **One result row:** One product category and creation year.
- **Metric:** Average `TIMESTAMP_DIFF(sold_at, created_at, DAY)`, rounded to two decimals. Only sold inventory items are included.
- **Result:** Team-provided output is summarized in `../charter.md`. It shows Accessories at 29.09 days (2023) and 29.00 days (2026), and Dresses at 30.03 days (2023) and 28.10 days (2026).
- **Estimated bytes processed:** Not included in the information provided. Add the estimate from BigQuery job details.
- **Interpretation:** This is time to sell among items that sold, not the standard inventory-turnover ratio. Counts are sold inventory-item records grouped by `created_at` year, not all sales made during that calendar year.
- **Limits:** Unsold items are excluded, and the 2026 cohort may be incomplete. The provided result excerpt lists Accessories and Dresses, while the query also includes Swimwear and Outerwear. Confirm whether their rows were omitted or not returned.
- **Decision:** Treat the comparison as descriptive. The query does not establish a cause or a financial savings estimate.

## `02_country_revenue_by_year.sql`

- **Purpose:** Compare recorded order-item sale-price totals by user country and order-item creation year.
- **Sources:** `bigquery-public-data.thelook_ecommerce.order_items` joined to `bigquery-public-data.thelook_ecommerce.users` on `user_id = id`.
- **One result row:** One user country and one order-item creation year.
- **Metric:** Sum of `order_items.sale_price`; the query does not filter by status or returns.
- **Result:** Team-provided output is summarized in `../charter.md`. The top three countries in the supplied rows account for 69.9% of the 2023 total and 70.4% of the 2025 total.
- **Estimated bytes processed:** Not included in the information provided. Add the estimate from BigQuery job details.
- **Interpretation:** This is a country revenue-concentration comparison, not revenue per customer, net revenue, or profit. The country is the user's recorded country.
- **Limits:** 2026 may be incomplete. Confirm all country groups were included, and verify the currency/unit before labeling `sale_price` values as dollars.
- **Decision:** Treat the result as descriptive. It does not explain why revenue is concentrated or establish an investment recommendation.
