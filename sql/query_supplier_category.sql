SELECT 
    Supplier,
    Item_Category,
    COUNT(*) AS total_orders,
    ROUND(AVG(Defect_Rate_Pct), 2) AS avg_defect_rate,
    ROUND(SUM(CASE WHEN Order_Status = 'Cancelled' THEN 1.0 ELSE 0.0 END) / COUNT(*), 2) AS cancellation_rate
FROM purchase_orders
WHERE Item_Category = 'Electronics'
GROUP BY Supplier, Item_Category
ORDER BY cancellation_rate DESC;
