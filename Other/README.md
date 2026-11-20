# Dataset documentation and table notes

## Dataset

- **Dataset ID:** `bigquery-public-data.thelook_ecommerce`
- **BigQuery project:** `bigquery-public-data`
- **Table browser:** Open the dataset in BigQuery Explorer and inspect each table's **Details**, **Schema**, and **Preview** tabs.
- **Google documentation:** [BigQuery e-commerce analytics codelab](https://codelabs.developers.google.com/codelabs/bigquery-measures?hl=en). The codelab introduces theLook e-commerce tables and illustrates order-item measures. Use BigQuery's live schema as the authority for the exact table fields and types in this project.
- **Team output:** [Country-year results in Google Sheets](https://docs.google.com/spreadsheets/d/1rDDExt7Uf89crvoLI5ZjTG0p1JqFMs49nnnk2eYQmJY/edit?gid=1679571377#gid=1679571377).
- **Belgium category output:** [Category results in Google Sheets](https://docs.google.com/spreadsheets/d/1jXNwfXJ5pRDnpHl_6pYGra9pCK5BWavyb9ZEVs8Khlg/edit?usp=sharing). Its category percentages imply about 296 Belgian purchasers, compared with the earlier result of 286; see [findings.md](../findings.md).

## Tables used

| Table | Columns used | Role in analysis |
|---|---|---|
| `users` | `id`, `country` | User identifier and user's recorded country |
| `order_items` | `id`, `user_id`, `created_at`, `sale_price` | Order-item identifier, user join key, year filter, and value summed |
| `products` | `id`, `category` (assumed for CP2 query 08; verify in BigQuery) | Product identifier and category label for category-purchase features |

The country analysis joins `order_items.user_id` to `users.id`. The CP2 purchaser table joins `order_items.user_id` to `users.id` and left-joins `order_items.product_id` to `products.id`, reading `products.category`; verify the product fields in the live schema before running query 08. The left product join preserves order items in the spend outcome when no product row matches. Confirm the displayed column descriptions and types in BigQuery and add important documentation notes here.

## Table diagram

![Tables and join](table_diagram.png)

[Printable table diagram (PDF)](table_diagram.pdf)

The editable DBML source is [thelook_revenue_erd.dbml](thelook_revenue_erd.dbml).
