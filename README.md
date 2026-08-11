# Sales Performance Analysis 

## 1. Background & Overview

This project analyzes the sales performance of a retail business across **2023 to November 2025**, using sales, customer, and product data to evaluate overall business performance and identify key areas for improvement.

The analysis focuses on three key areas:

- **Revenue & Regional Performance:** Evaluate revenue trends, seasonality, and regional contributions to overall sales.
- **Customer Performance:** Compare customer volume and customer value across regions to identify differences in purchasing behavior.
- **Product & Profitability:** Assess product and category performance based on revenue, gross profit, gross margin, and average order value.

The analysis was conducted using **SQL Server for data validation, preparation, and analysis**, and **Power BI for interactive business reporting and visualization**.

---

## 2. Project Files
### Dashboard
- 📊 [Power BI Dashboard (.pbix)](sales_performance_dashboard.pbix)

### SQL Scripts
- 🧹 [Data_validation.sql](SQL/Data_validation.sql)
- 🔄 [Data_preparation.sql](SQL/Data_preparation.sql)
- 📈 [business_questions.sql](SQL/business_questions.sql)

### Dataset
- 👥 [customers.csv](Data/customers.csv)
- 📦 [products.csv](Data/products.csv)
- 🛒 [Orders_2023.csv](Data/Orders_2023.csv)
- 🛒 [Orders_2024.csv](Data/Orders_2024.csv)
- 🛒 [Orders_2025.csv](Data/Orders_2025.csv)

### Images
- 🗺️ [ERD](Images/ERD.png)
- 📊 [Sales Performance Overview](Images/OverallRevenue.png)
- 👥 [Products & Customers Dashboard](Images/Product&CustomersInsights.png)
  
---

## 3. Data Structure Overview

The dataset consists of five tables:

- **Customers** – Customer information and region
- **Products** – Product details, categories, prices, and base costs
- **Orders_2023** – Sales transactions in 2023
- **Orders_2024** – Sales transactions in 2024
- **Orders_2025** – Sales transactions in 2025 (January - November)

Here is the ERD:

![ERD](Images/ERD.png)

*The transactional data was originally stored in three separate tables (Orders_2023, Orders_2024, and Orders_2025). As these tables share the same schema, they are represented as a single Orders entity in the ERD for simplicity. During data preparation, the three tables were merged into the analytical view vw_full_orders.

---

## 4. Executive Summary
## Overview of Findings
- The business generated approximately **$871K in revenue and $478K in gross profit** from 2023 to November 2025, with gross margin remaining relatively stable at approximately **50–60%**. Revenue was highly concentrated in the **West and East regions, which jointly contributed approximately 73% of total revenue**, while **North and South generated higher revenue per customer despite having smaller customer bases**.

- At the product level, **Grinders & Brewers** was a major driver of revenue and gross profit, while **Subscriptions achieved the highest gross margin at approximately 63–66%**. In contrast, **Merchandise generated relatively low revenue and maintained the lowest gross margins**, suggesting potential opportunities for further product and profitability review.


## 5. Insights Deep Dive

### 5.1. Revenue & Regional Performance

### Revenue is concentrated in West and East
<img width="412" height="190" alt="Screenshot 2026-08-11 082406" src="https://github.com/user-attachments/assets/ad3716b1-4476-433c-97f6-4abf541f9d29" />

<img width="412" height="272" alt="Screenshot 2026-08-11 082818" src="https://github.com/user-attachments/assets/413bb279-73c7-4016-ae98-ffe8d0690446" />

- **West and East jointly contributed approximately 73% of total revenue**, making them the primary revenue-generating regions.
- West showed particularly strong performance in **Q1**, contributing approximately **44.5–47.5% of quarterly revenue** across the observed years.

### Revenue shows a recurring seasonal pattern

- Revenue generally peaks toward the **end of the year**, particularly in **November and December in years with complete data**.
- This recurring pattern suggests a potential **seasonal increase in customer demand** toward year-end.

### Gross margin remained relatively stable

- Monthly gross margin generally remained within the **50–60% range** throughout the observed period.
- Despite fluctuations in monthly revenue, the overall margin remained relatively stable.

--> This suggests that the business maintained a relatively consistent pricing and product cost structure during the observed period.



### 5.2. Customer Value & Regional Behavior
<p align="center">
  <img src="https://github.com/user-attachments/assets/9df353aa-0016-49dc-be15-80455150c656" alt="Dashboard" width="900">
</p>

### Customer volume does not fully explain regional customer value

- **West and East have substantially larger customer bases**, with their combined customer count approximately **three times that of North and South**.
- However, **North and South generate higher average revenue per customer** despite having smaller customer bases.

--> This indicates that regional performance differs not only in customer acquisition volume but also in customer value.

### North and South have a higher concentration of high-value customers

- **60% of the top 10 customers by revenue are located in North and South**, despite these regions having considerably fewer customers overall.
- Revenue from these high-value customers is largely associated with **Grinders & Brewers**, suggesting that purchasing patterns and product preferences may contribute to the higher customer value observed in these regions.

### Customer value should be considered alongside customer volume

- West and East benefit from a **larger customer base**, which supports their high overall revenue contribution.
- North and South, however, demonstrate **higher revenue per customer and a greater presence among top-value customers**.

--> Therefore, regional performance should be evaluated using both customer scale and customer value rather than total revenue alone.



### 5.3. Product & Profitability

<img width="542" height="475" alt="Screenshot 2026-08-11 082543" src="https://github.com/user-attachments/assets/55b4fd5b-5200-43d4-8093-4d80c6087529" />


<img width="442" height="200" alt="Screenshot 2026-08-11 082633" src="https://github.com/user-attachments/assets/4c9fc948-7012-4ead-a937-c8c6d48adfc8" />

### Grinders & Brewers is the main revenue and gross profit driver

- **Grinders & Brewers** is a major contributor to both revenue and gross profit.
- It also has one of the highest AOVs among product categories, with an AOV approximately **three times higher than Subscriptions**.

--> The category plays an important role in driving overall financial performance through both transaction value and total sales contribution.

### Subscriptions have the strongest profitability

- **Subscriptions consistently achieve the highest gross margin, approximately 63–66% across regions.**
- This means a relatively large proportion of its revenue is retained as gross profit after product costs.
- Its combination of substantial revenue contribution and high margin makes it an important category from a profitability perspective.

### Merchandise is the weakest-performing category

- Merchandise generates relatively low revenue compared with the stronger-performing categories.
- Its gross margin is also consistently among the lowest, at approximately **35–38% across regions**.

--> The combination of low revenue and low margin suggests that Merchandise may warrant further review of its pricing, costs, or product strategy.


## 6. Recommendations

Based on the insights and findings above, we recommend the **Sales and Commercial Management teams** consider the following:

- **Prioritize high-value product categories while reviewing underperforming products.** Grinders & Brewers is a major driver of revenue and gross profit, while Subscriptions achieve the highest gross margin. The business should maintain strong support for these categories while reviewing the pricing, costs, and product mix of lower-performing Merchandise products.

- **Develop North and South based on customer value.** Although these regions have smaller customer bases, they generate higher revenue per customer and contain a relatively high share of top-value customers. Management should analyze their purchasing behavior and product preferences to identify opportunities for targeted customer acquisition and retention.

- **Diversify regional growth while maintaining core markets.** West and East contribute approximately **73% of total revenue**, indicating strong performance but also regional concentration. The business should continue supporting these markets while exploring opportunities to expand customer acquisition and revenue in North and South.

- **Incorporate seasonality into operational planning.** Since revenue tends to peak toward the end of the year, management should use historical seasonal patterns to improve **inventory, staffing, and promotional planning** ahead of the November–December period.

- Focus marketing campaigns on top-selling product categories while exploring opportunities to increase sales of lower-performing products.

- Regularly monitor sales performance through dashboards to support timely business decisions.

