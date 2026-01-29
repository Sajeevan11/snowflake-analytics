/*
============================================
REQUÊTE 1 : EXECUTIVE KPIS
============================================
Objectif : Métriques clés avec croissance YoY
Plateforme : Snowflake
Dataset : TPCH_SF1 (1.5M orders)
Période : 1994 vs 1993
============================================
*/

USE WAREHOUSE ANALYTICS_WH;
USE DATABASE ECOMMERCE_DB;
USE SCHEMA ANALYTICS;

-- KPIs 1994
WITH kpis_1994 AS (
    SELECT 
        COUNT(DISTINCT O_ORDERKEY) as total_orders,
        COUNT(DISTINCT O_CUSTKEY) as total_customers,
        ROUND(SUM(O_TOTALPRICE), 2) as total_revenue,
        ROUND(AVG(O_TOTALPRICE), 2) as avg_order_value
    FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
    WHERE O_ORDERSTATUS = 'F'
      AND YEAR(O_ORDERDATE) = 1994
),

-- KPIs 1993
kpis_1993 AS (
    SELECT 
        COUNT(DISTINCT O_ORDERKEY) as total_orders,
        COUNT(DISTINCT O_CUSTKEY) as total_customers,
        ROUND(SUM(O_TOTALPRICE), 2) as total_revenue,
        ROUND(AVG(O_TOTALPRICE), 2) as avg_order_value
    FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
    WHERE O_ORDERSTATUS = 'F'
      AND YEAR(O_ORDERDATE) = 1993
)

-- Comparaison YoY
SELECT 
    -- Métriques 1994
    k94.total_orders as orders_1994,
    k94.total_customers as customers_1994,
    k94.total_revenue as revenue_1994,
    k94.avg_order_value as aov_1994,
    
    -- Croissance YoY
    ROUND(((k94.total_orders - k93.total_orders) * 100.0 / NULLIF(k93.total_orders, 0)), 2) as orders_growth_yoy_pct,
    ROUND(((k94.total_customers - k93.total_customers) * 100.0 / NULLIF(k93.total_customers, 0)), 2) as customers_growth_yoy_pct,
    ROUND(((k94.total_revenue - k93.total_revenue) * 100.0 / NULLIF(k93.total_revenue, 0)), 2) as revenue_growth_yoy_pct,
    ROUND(((k94.avg_order_value - k93.avg_order_value) * 100.0 / NULLIF(k93.avg_order_value, 0)), 2) as aov_growth_yoy_pct

FROM kpis_1994 k94
CROSS JOIN kpis_1993 k93;

/*
============================================
RÉSULTATS ATTENDUS (1994 vs 1993)
============================================
Orders : 227,597 (+0.42% YoY)
Customers : 86,608 (+0.15% YoY)
Revenue : 344B€ (+0.22% YoY)
AOV : 151,216€ (-0.20% YoY)

INSIGHTS :
- Croissance stable (~0.2-0.4%)
- Marché mature B2B
- Panier moyen légèrement en baisse
============================================
*/