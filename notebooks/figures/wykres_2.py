import matplotlib.pyplot as plt
import seaborn as sns

sns.set_style('whitegrid')

category_summary = pd.read_sql_query("""
    SELECT 
        Item_Category,
        ROUND(SUM(Order_Value), 2) AS total_spend,
        ROUND(AVG(Defect_Rate_Pct), 2) AS avg_defect_rate
    FROM purchase_orders
    GROUP BY Item_Category
    ORDER BY total_spend DESC
""", conn)

fig, axes = plt.subplots(1, 2, figsize=(14, 5))
axes[0].barh(category_summary['Item_Category'], category_summary['total_spend'] / 1e6, color='steelblue')
axes[0].set_xlabel('Total Spend (mln)')
axes[0].set_title('Wydatki wg kategorii')

axes[1].barh(category_summary['Item_Category'], category_summary['avg_defect_rate'], color='indianred')
axes[1].set_xlabel('Średni Defect Rate (%)')
axes[1].set_title('Jakość wg kategorii')
plt.tight_layout()
plt.savefig('category_spend_vs_quality.png', dpi=150)
plt.show()
