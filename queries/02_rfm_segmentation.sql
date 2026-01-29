/*
============================================
REQUÊTE 2 : CUSTOMER SEGMENTATION (RFM)
============================================
Objectif : Segmenter clients par comportement
Plateforme : Snowflake
Dataset : TPCH_SF1
Technique : Scoring RFM adaptatif
============================================
*/

USE WAREHOUSE ANALYTICS_WH;
USE DATABASE ECOMMERCE_DB;
USE SCHEMA ANALYTICS;

WITH customer_metrics AS (
    SELECT 
        O_CUSTKEY as customer_id,
        MAX(O_ORDERDATE) as last_order_date,
        DATEDIFF(DAY, MAX(O_ORDERDATE), CURRENT_DATE()) as recency_days,
        COUNT(DISTINCT O_ORDERKEY) as frequency,
        ROUND(SUM(O_TOTALPRICE), 2) as monetary
    FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
    WHERE O_ORDERSTATUS = 'F'
    GROUP BY O_CUSTKEY
),

rfm_scores AS (
    SELECT 
        customer_id,
        recency_days,
        frequency,
        monetary,
        
        -- R Score (inversé : plus récent = meilleur)
        NTILE(5) OVER (ORDER BY recency_days ASC) as r_score,
        
        -- F Score
        NTILE(5) OVER (ORDER BY frequency DESC) as f_score,
        
        -- M Score
        NTILE(5) OVER (ORDER BY monetary DESC) as m_score
        
    FROM customer_metrics
),

rfm_segments AS (
    SELECT 
        *,
        CASE 
            WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
            WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 THEN 'Loyal Customers'
            WHEN r_score >= 4 AND f_score <= 2 AND m_score >= 3 THEN 'Big Spenders'
            WHEN r_score >= 4 AND f_score <= 2 AND m_score <= 2 THEN 'Promising'
            WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
            WHEN r_score <= 2 AND f_score <= 2 THEN 'Lost'
            ELSE 'Others'
        END as segment
    FROM rfm_scores
)

-- Résumé par segment
SELECT 
    segment,
    COUNT(*) as nb_customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) as pct_customers,
    ROUND(AVG(recency_days), 1) as avg_recency_days,
    ROUND(AVG(frequency), 2) as avg_frequency,
    ROUND(AVG(monetary), 2) as avg_monetary,
    ROUND(SUM(monetary), 2) as total_revenue,
    ROUND(SUM(monetary) * 100.0 / SUM(SUM(monetary)) OVER (), 2) as pct_revenue
FROM rfm_segments
GROUP BY segment
ORDER BY avg_monetary DESC;

/*
============================================
RÉSULTATS ATTENDUS
============================================
- Champions : <1%, CLV très élevé
- Loyal : ~5%, fréquence haute
- Big Spenders : ~15-20%, panier élevé
- At Risk : ~3%, inactifs
- Lost : ~40%, jamais revenus
- Promising : ~15%, upsell opportunity
============================================
*/