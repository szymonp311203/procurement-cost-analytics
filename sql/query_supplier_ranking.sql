WITH supplier_kpi AS (
    SELECT 
        Supplier,
        COUNT(*) AS total_orders,
        ROUND(SUM(Order_Value), 2) AS total_spend,
        ROUND(AVG(Savings_Rate_Pct), 2) AS avg_savings_rate,
        ROUND(AVG(Defect_Rate_Pct), 2) AS avg_defect_rate,
        ROUND(SUM(CASE WHEN Compliance = 'Yes' THEN 1.0 ELSE 0.0 END) / COUNT(*), 2) AS compliance_rate
    FROM purchase_orders
    GROUP BY Supplier
)
SELECT 
    *,
    RANK() OVER (ORDER BY avg_defect_rate ASC) AS quality_rank,
    RANK() OVER (ORDER BY avg_savings_rate DESC) AS savings_rank,
    RANK() OVER (ORDER BY compliance_rate DESC) AS compliance_rank
FROM supplier_kpi
ORDER BY total_spend DESC;
