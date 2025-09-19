SELECT
    customer_id,
    country,
    COUNT(DISTINCT invoice_no) AS total_orders,
    SUM(total_amount) AS total_spent
FROM {{ ref('ecommerce_orders') }}  -- references the ecommerce_orders Silver model
GROUP BY customer_id, country
