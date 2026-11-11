# Charter: Accessories Time-to-Sell Gap

## Project question

Among inventory items that were sold, how did the average time from item creation to sale change for Accessories compared with Dresses across the 2023–2026 creation-year cohorts?

## The gap

The results supplied for this query show that Accessories remained close to 29 days to sell, while Dresses decreased from 30.03 days in the 2023 cohort to 28.10 days in the 2026 cohort.

| Category | Creation year | Average days to sell | Sold inventory-item rows |
|---|---:|---:|---:|
| Accessories | 2023 | 29.09 | 1,028 |
| Accessories | 2024 | 29.84 | 1,502 |
| Accessories | 2025 | 29.60 | 2,249 |
| Accessories | 2026 | 29.00 | 3,379 |
| Dresses | 2023 | 30.03 | 565 |
| Dresses | 2024 | 29.28 | 829 |
| Dresses | 2025 | 29.50 | 1,255 |
| Dresses | 2026 | 28.10 | 1,853 |

From 2023 to 2026, the average decreased by 0.09 days for Accessories and 1.93 days for Dresses. In the 2026 cohorts shown, Accessories averaged 0.90 days longer to sell than Dresses. This is a descriptive difference; the query does not explain why it occurred.

## Measure and unit of analysis

The source is `bigquery-public-data.thelook_ecommerce.inventory_items`. Each result row represents one product category and inventory-item creation year. The average is calculated as `AVG(TIMESTAMP_DIFF(sold_at, created_at, DAY))` for rows where `sold_at` is not null. The count is the number of sold inventory-item records in that creation-year cohort.

This is an average time-to-sell measure. It is not the standard inventory-turnover ratio. It also excludes items that had not sold, so it describes sold items only.

## Comparator

Dresses is an internal comparison category, not an external industry benchmark or a proven target. The categories may differ in product mix, price, or other factors. The comparison does not show that logistics, demand, or fulfillment caused the difference.

## Potential value

In the 2026 results supplied, the 0.90-day average difference across 3,379 sold Accessories records corresponds to about 3,041 inventory-item-days (0.90 × 3,379). This is an illustration of the size of the observed gap, not a proven improvement opportunity or dollar saving.

The query does not provide item cost, inventory value, or a sourced carrying-cost rate, so this charter does not estimate financial savings. The suggested $45 price and 20% annual carrying-cost assumptions need sources and validation before they can support a dollar estimate.

## Limits and next checks

- The query includes only rows with `sold_at` populated. Unsold inventory is excluded; this can make recent cohorts look faster because items that have not sold yet are not included.
- The 2026 cohort may be incomplete. Confirm the dataset's latest date before comparing it with prior years.
- The submitted result excerpt contains Accessories and Dresses. The query also filters for Swimwear and Outerwear; include those results too if they were returned, or state why the write-up focuses on these two categories.
- Before recommending a cause or action, review the data coverage and agree on further checks that the available tables and fields can support.
