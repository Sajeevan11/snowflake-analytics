# 📊 Snowflake Analytics Project

> SQL Analytics on Snowflake with Executive KPIs & Customer Segmentation

[![Snowflake](https://img.shields.io/badge/Snowflake-Analytics-blue)](https://www.snowflake.com/)
[![SQL](https://img.shields.io/badge/SQL-Advanced-green)]()

---

## 🎯 Project Overview

Analytics project demonstrating advanced SQL capabilities on Snowflake, migrated from BigQuery.

**Dataset:** TPC-H (1.5M orders, 150K customers, 6M line items)  
**Techniques:** Window Functions, RFM Segmentation, YoY Analysis  
**Platform:** Snowflake (multi-cloud data warehouse)

---

## 📂 Project Structure
```
snowflake-analytics/
│
├── queries/
│   ├── 01_executive_kpis.sql          ← Executive dashboard metrics
│   └── 02_rfm_segmentation.sql        ← Customer RFM analysis
│
├── documentation/
│   └── bigquery_vs_snowflake.md       ← Platform comparison
│
└── README.md                           ← You are here
```

---

## 📊 Query 1: Executive KPIs

**Objective:** High-level business metrics with YoY comparison

**Key Metrics:**
- Total Orders
- Unique Customers
- Total Revenue
- Average Order Value

**Results (1994 vs 1993):**
- Orders: 227,597 (+0.42% YoY) 📈
- Customers: 86,608 (+0.15% YoY)
- Revenue: €344B (+0.22% YoY)
- AOV: €151,216 (-0.20% YoY)

**Business Insights:**
- ✅ Stable growth (~0.2-0.4%) indicating mature B2B market
- ⚠️ Slight AOV decline despite revenue growth
- 🎯 Customer base expansion strategy needed

**File:** [`queries/01_executive_kpis.sql`](queries/01_executive_kpis.sql)

---

## 💎 Query 2: Customer Segmentation (RFM)

**Objective:** Segment customers by Recency, Frequency, Monetary value

**Method:** Adaptive RFM scoring with NTILE distribution

**Segments Defined:**
- **Champions:** High R/F/M scores, premium customers 👑
- **Loyal Customers:** Consistent purchasers 🤝
- **Big Spenders:** High value, low frequency (opportunity!) 💰
- **At Risk:** Previously loyal, now inactive (retention focus) ⚠️
- **Lost:** Churned customers 💀
- **Promising:** Recent low-value customers (upsell potential) 🌱
- **Others:** Middle-tier customers

**Business Value:**
- Targeted marketing campaigns per segment
- Retention strategies for "At Risk" customers
- Upsell opportunities for "Promising" segment
- VIP program for "Champions"

**File:** [`queries/02_rfm_segmentation.sql`](queries/02_rfm_segmentation.sql)

---

## 🔄 BigQuery → Snowflake Migration

**Key syntax differences:**

| Concept | BigQuery | Snowflake |
|---------|----------|-----------|
| Extract year | `EXTRACT(YEAR FROM date)` | `YEAR(date)` ✅ |
| Date truncate | `DATE_TRUNC(date, MONTH)` | `DATE_TRUNC('MONTH', date)` |
| Backticks | Required | Optional |
| Notation | `project.dataset.table` | `database.schema.table` |

**See full comparison:** [`documentation/bigquery_vs_snowflake.md`](documentation/bigquery_vs_snowflake.md)

---

## 🛠️ Technical Stack

- **Platform:** Snowflake (AWS eu-west-3)
- **Warehouse:** ANALYTICS_WH (XSMALL, auto-suspend 60s)
- **Dataset:** TPCH_SF1 (public sample data)
- **SQL Features:** 
  - Common Table Expressions (CTE)
  - Window Functions (NTILE, LAG)
  - CASE WHEN logic
  - CROSS JOIN aggregations
  - NULLIF for division protection

---

## 🚀 How to Use

### Prerequisites
- Snowflake account ([free trial available](https://signup.snowflake.com/))
- Access to `SNOWFLAKE_SAMPLE_DATA.TPCH_SF1`

### Run Queries
1. Open [Snowflake Console](https://app.snowflake.com/)
2. Create warehouse: `CREATE WAREHOUSE ANALYTICS_WH WITH WAREHOUSE_SIZE = 'XSMALL';`
3. Copy-paste SQL from `queries/` folder
4. Execute and analyze results

### Expected Runtime
- Query 1 (Executive KPIs): ~2-3 seconds
- Query 2 (RFM Segmentation): ~5-8 seconds

---

## 📈 Skills Demonstrated

**Technical Skills:**
- ✅ Multi-cloud data warehouse (Snowflake)
- ✅ Advanced SQL (Window Functions, CTE, NTILE)
- ✅ Platform migration (BigQuery → Snowflake)
- ✅ Query optimization techniques

**Business Skills:**
- ✅ KPI definition and tracking
- ✅ Customer segmentation (RFM methodology)
- ✅ YoY comparison analysis
- ✅ Actionable business insights

---

## 📧 Contact

**Sajeevan Iziajee**
- 📧 Email: iziajee@gmail.com
- 💼 LinkedIn: [Your LinkedIn Profile]
- 🔗 GitHub: [github.com/Sajeevan11](https://github.com/Sajeevan11)

---

## 🔗 Related Projects

- [BigQuery E-Commerce Analytics](https://github.com/Sajeevan11/bigquery-ecommerce-analytics) - 8 advanced SQL queries with business recommendations

---

*Last Updated: January 2026*