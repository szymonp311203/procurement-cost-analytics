SELECT 
    Item_Category,
    COUNT(*) AS total_orders,
    ROUND(SUM(Order_Value), 2) AS total_spend,
    ROUND(AVG(Savings_Rate_Pct), 2) AS avg_savings_rate,
    ROUND(AVG(Defect_Rate_Pct), 2) AS avg_defect_rate,
    ROUND(SUM(CASE WHEN Compliance = 'Yes' THEN 1.0 ELSE 0.0 END) / COUNT(*), 2) AS compliance_rate,
    ROUND(SUM(CASE WHEN Order_Status = 'Cancelled' THEN 1.0 ELSE 0.0 END) / COUNT(*), 2) AS cancellation_rate
FROM purchase_orders
GROUP BY Item_Category
ORDER BY total_spend DESC;
