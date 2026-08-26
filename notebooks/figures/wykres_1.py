import matplotlib.pyplot as plt
import seaborn as sns

sns.set_style('whitegrid')

# Wykres 1: Defect rate vs Compliance rate per dostawca (scatter, rozmiar = spend)
supplier_summary = pd.read_sql_query("""
    SELECT 
        Supplier,
        ROUND(SUM(Order_Value), 2) AS total_spend,
        ROUND(AVG(Defect_Rate_Pct), 2) AS avg_defect_rate,
        ROUND(SUM(CASE WHEN Compliance = 'Yes' THEN 1.0 ELSE 0.0 END) / COUNT(*), 2) AS compliance_rate
    FROM purchase_orders
    GROUP BY Supplier
""", conn)

fig, ax = plt.subplots(figsize=(9, 6))
scatter = ax.scatter(
    supplier_summary['avg_defect_rate'], 
    supplier_summary['compliance_rate'],
    s=supplier_summary['total_spend'] / 20000,  # rozmiar wg wydatków
    alpha=0.7,
    c=range(len(supplier_summary)),
    cmap='viridis'
)
for i, row in supplier_summary.iterrows():
    ax.annotate(row['Supplier'], (row['avg_defect_rate'], row['compliance_rate']), 
                xytext=(5, 5), textcoords='offset points', fontsize=10)
ax.set_xlabel('Średni Defect Rate (%)')
ax.set_ylabel('Compliance Rate')
ax.set_title('Dostawcy: jakość vs zgodność (rozmiar = wydatki)')
plt.tight_layout()
plt.savefig('supplier_quality_vs_compliance.png', dpi=150)
plt.show()
