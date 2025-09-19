This project demonstrates an **end-to-end ELT workflow** using **dbt Cloud** and **Snowflake**
# multi-layered ELT pipeline using dbt and Snowflake:

- **Bronze layer**: Raw, unprocessed data directly ingested from the source (in this case, a Kaggle online retail dataset). This layer preserves the original data for traceability and auditing.  
- **Silver layer**: Cleansed and validated data derived from Bronze. Here, transformations standardize fields, filter out invalid records, rename columns based on business needs and minimum data validations.  
- **Gold layer**: Aggregated, business-ready data built from the Silver layer. This layer is optimized for analytics, dashboards, and reporting, providing insights such as customer-level metrics or sales trends.


Step 1: **bronze → silver data pipeline** using **Snowflake** as the data warehouse and **dbt Cloud** for transformations. The pipeline uses a **Kaggle dataset of online retail transactions** as the source data to simulate real-world e-commerce data.

---

## 📂 Project Structure

```
models/
  silver/
    ecommerce_orders.sql   # Cleans raw orders data from BRONZE layer
    customers.sql          # Aggregates orders to customer-level metrics
```

---

## 🔗 Data Flow

**Source Table:**  
`"BRONZE"."PUBLIC"."ONLINEORDERS"`

**Silver Models:**
1. **`silver.ecommerce_orders`**
   - Cleans raw data (removes negative quantities, normalizes description, computes `total_amount`).
2. **`silver.customers`**
   - Aggregates customer-level metrics:
     - `total_orders`
     - `total_spent`
     - grouped by `customer_id` & `country`.

---

## 🏃‍♂️ How to Run

Run both silver models:

```bash
dbt run --select silver.ecommerce_orders silver.customers --no-partial-parse
```

List available models:

```bash
dbt ls --resource-type model
```

---

## 🧪 Testing (Optional)

Add simple data tests in `models/silver/schema.yml`:

```yaml
version: 2

models:
  - name: ecommerce_orders
    columns:
      - name: invoice_no
        tests:
          - not_null
      - name: total_amount
        tests:
          - not_null

  - name: customers
    columns:
      - name: customer_id
        tests:
          - not_null
```

Run tests:

```bash
dbt test --select silver
```

---

## 📊 Next Steps

- Add **gold models** for dashboards (e.g., monthly sales trends).
- Add **dbt snapshots** if you need historical tracking.
- Schedule runs in dbt Cloud for automation.

---

## 👤 Author
Yogi — building an end-to-end ELT pipeline for learning dbt + Snowflake.

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
