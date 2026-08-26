SELECT 
    Supplier,
    COUNT(*) AS total_orders,
    ROUND(SUM(Order_Value), 2) AS total_spend,
    ROUND(AVG(Savings_Rate_Pct), 2) AS avg_savings_rate,
    ROUND(AVG(Defect_Rate_Pct), 2) AS avg_defect_rate,
    ROUND(
        SUM(CASE WHEN Is_On_Time = 1 THEN 1.0 ELSE 0.0 END) 
        / SUM(CASE WHEN Is_On_Time IS NOT NULL THEN 1.0 ELSE 0.0 END), 
    2) AS on_time_rate,
    ROUND(SUM(CASE WHEN Compliance = 'Yes' THEN 1.0 ELSE 0.0 END) / COUNT(*), 2) AS compliance_rate
FROM purchase_orders
GROUP BY Supplier
ORDER BY total_spend DESC;
