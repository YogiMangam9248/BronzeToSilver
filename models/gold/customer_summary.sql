WITH customer_rank AS (
    SELECT
        customer_id,
        country,
        total_orders,
        total_spent,
        RANK() OVER (PARTITION BY country ORDER BY total_spent DESC) AS rank_by_country
    FROM {{ ref('silver.customers') }}
),

country_summary AS (
    SELECT
        country,
        COUNT(DISTINCT customer_id) AS num_customers,
        SUM(total_spent) AS country_total_spent,
        AVG(total_spent) AS avg_spent_per_customer
    FROM {{ ref('silver.customers') }}
    GROUP BY country
)

SELECT
    c.customer_id,
    c.country,
    c.total_orders,
    c.total_spent,
    c.rank_by_country,
    cs.num_customers,
    cs.country_total_spent,
    cs.avg_spent_per_customer
FROM customer_rank c
JOIN country_summary cs
    ON c.country = cs.country
