WITH cleaned AS (
    SELECT
        InvoiceNo AS invoice_no,
        StockCode AS stock_code,
        INITCAP(Description) AS description,
        Quantity AS quantity,
        TRY_TO_TIMESTAMP(InvoiceDate) AS invoice_ts,
        UnitPrice AS unit_price,
        ROUND(Quantity * UnitPrice, 2) AS total_amount,
        CustomerID AS customer_id,
        INITCAP(Country) AS country
    FROM "BRONZE"."PUBLIC"."ONLINEORDERS"
    WHERE Quantity > 0
      AND UnitPrice > 0
)
SELECT * FROM cleaned