# SQL project

## 📌 Project Overview
This project focuses on **advanced sales analytics using SQL**, where transactional sales data is analyzed to understand **performance trends, product behavior, customer activity, and business growth over time**. The project is built on a **fact–dimension (star schema) model** and makes extensive use of **CTEs and window functions** to perform real-world analytical calculations.

The goal of the project is to move beyond simple aggregation and perform **comparative, cumulative, and trend-based analysis**, similar to what is done in professional data analytics and BI environments.


### 🔹 `performance_analysis.sql`
In this file, I analyzed **product-level sales performance over time** using **CTEs and window functions**.

- Calculated **yearly and monthly sales per product**
- Compared **current sales with average sales** for each product
- Classified performance as **Above Average / Below Average**
- Used `LAG()` to compare **current year/month sales with previous year/month**
- Identified **Increase, Decrease, or No Change** trends

---

### 🔹 `Change_over_timeAnlysis.sql`
This file focuses on **time-based sales trends and cumulative performance**.
- Aggregated sales by **year and month**
- Calculated:
  - Total sales
  - Total customers
  - Total quantity sold
- Implemented **running totals** of sales using `SUM() OVER`
- Calculated **moving averages of price** to smooth short-term fluctuations
- Performed **monthly and yearly cumulative analysis**

---

### 🔹 `Part_toWhole_and_Segmentation.sql`
In this file, I performed **part-to-whole analysis** to understand how individual segments contribute to total sales.

What I did:
- Broke down total sales into **segments (products/customers)**
- Calculated **percentage contribution** of each segment
- Identified **high-impact contributors vs low-impact segments**

---

### 🔹 `customer_report.sql`
This script generates **customer-level analytical reports**.

What I did:
- Analyzed customer purchasing behavior
- Identified **top customers by sales contribution**
- Grouped customers based on their sales impact

This helps identify **high-value customers** and customer concentration risks.

---

### 🔹 `product_report.sql`
This file focuses on **product performance reporting**.
- Identified **top-performing and underperforming products**
- Analyzed product-wise sales contribution
- Supported insights for **inventory and product strategy**

---

## 🎯 Key SQL Concepts Used
- Common Table Expressions (CTEs)
- Window Functions (`AVG() OVER`, `SUM() OVER`, `LAG() OVER`)
- Year-over-Year and Month-over-Month comparison
- Running totals and moving averages
- Time-based grouping and aggregation
- Business-oriented performance classification

---

## 🚀 Skills Demonstrated
- Advanced SQL analytics
- Business performance analysis
- Time-series analysis
- Analytical thinking with relational data
- Real-world data warehouse querying

---
---

## 📂 Dataset Download
All CSV files used in this project can be downloaded from the link below:

🔗 **Google Drive – CSV Files**  
https://drive.google.com/drive/folders/1121vSzAcDb1vKR1WxNSERUC5PqJ2LYtS?usp=drive_link

---

## 🗃️ Data Model
- **fact_sales** → Stores transactional data such as order date, quantity, sales amount, price, customer key, and product key  
- **dim_products** → Contains product names and product-related attributes  
- **dim_customers** → Contains customer-level details for reporting and segmentation  

---

## 🛠️ CSV Import Steps (MySQL Import Wizard)
1. Open **MySQL Workbench**
2. Create or select a schema 
3. Right-click on the schema → **Table Data Import Wizard**
4. Select the CSV file
5. Choose **Create new table**
6. Verify column names and data types
7. Finish the import
8. Repeat for all CSV files
9. Execute the scripts for Analysis

---
