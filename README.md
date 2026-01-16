# 🏢 SQL Data Warehouse Project

## 📌 Project Overview
This project involves building a modern **Data Warehouse** solution using **T-SQL** following the **Medallion Architecture (Bronze, Silver, Gold)**. The system ingests raw data from multiple sources (CRM and ERP), transforms and cleanses it using Stored Procedures, and exposes the final data via **SQL Views** optimized for Power BI and reporting.

The solution ensures data quality through rigorous naming conventions, data standardization, and a clear separation of raw and business-ready data.

---

## 🏗️ Architecture & Data Flow
The project follows a multi-layer architecture to ensure data integrity and traceability.
<img width="1024" height="506" alt="image" src="https://github.com/user-attachments/assets/40245d4d-13b7-48a9-8558-490a16f62942" />


### 1. Bronze Layer (Raw Data)
* **Object Type:** Tables
* **Objective:** Store data in its original format from source systems.
* **Data Model:** "As-is" (No transformations).
* **Load Mechanism:** Stored Procedure (`load_bronze`).
* **Source Systems:**
    * **CRM:** Customer and Sales data.
    * **ERP:** Enterprise data.

### 2. Silver Layer (Cleaned & Standardized)
* **Object Type:** Tables
* **Objective:** Cleanse, standardize, and integrate data.
* **Load Mechanism:** Stored Procedure (`load_silver`).
* **Transformations Applied:**
    * Removed duplicates and nulls from Primary Keys.
    * Trimmed leading/trailing whitespaces.
    * Normalized `Gender` and `Marital Status` fields.
    * Handled NULL values in critical columns.
    * Handled missing and incorrent dates

### 3. Gold Layer (Business Ready)
* **Object Type:** Views (Virtual Layer)
* **Objective:** Optimized for reporting and analytics (Star Schema).
* **Load Mechanism:** None (Logic is encapsulated in Views).
* **Business Logic:**
    * Integrates data from Silver tables.
    * Performs aggregations and derived column calculations.
    * Joins dimensions (`dim`) and facts (`fact`).

---


## 🛠️ Technical Standards & Naming Conventions

To maintain consistency and readability, the project adheres to strict naming rules:

### General Rules
* **Case:** Snake case (`lower_case_with_underscores`).
* **Language:** English only.
* **Restrictions:** No SQL reserved words used as object names.

### Table & View Naming
| Layer | Object Type | Pattern | Example | Description |
| :--- | :--- | :--- | :--- | :--- |
| **Bronze** | Table | `<source>_<entity>` | `crm_cust_info` | Matches original source name. |
| **Silver** | Table | `<source>_<entity>` | `crm_cust_info` | Matches original source name. |
| **Gold** | View | `<category>_<entity>` | `gold.dim_customers` | Business-aligned names. |

### Column Naming
| Type | Pattern | Example | Description |
| :--- | :--- | :--- | :--- |
| **Surrogate Keys** | `<table_name>_key` | `customer_key` | Unique identifier in Dimension views. |
| **Technical Cols** | `dwh_<column_name>` | `dwh_load_date` | Metadata (e.g., load timestamp). |

### Stored Procedures
* **Pattern:** `load_<layer>`
* **Usage:** Only used for loading physical tables (Bronze & Silver).
* **List:** `load_bronze`, `load_silver`

---

## 📂 Data Sources
The project consumes CSV datasets located in the `datasets` folder:
* [📂 View Datasets](https://github.com/dhruv121321/sql-data-warehouse-project/tree/main/datasets)
    * `source_crm`: Contains sales and customer CSVs.
    * `source_erp`: Contains logistics and product category CSVs.

---

## 🚀 How to Run the Project
The ETL process is managed via Stored Procedures for the physical layers, while the Gold layer is immediately queryable as Views.

1.  **Initialize Database:** Run the DDL scripts given in scripts folder to create database and tables (Bronze, Silver) and Views (Gold).
2.  **Load Bronze Layer:**
    ```sql
    EXEC load_bronze;
    ```
    *Ingests raw CSV data into Bronze tables.*

3.  **Load Silver Layer:**
    ```sql
    EXEC load_silver;
    ```
    *Cleanses data, removes duplicates, and standardizes formats.*

4.  **Query Gold Layer:**
    The Gold views are now ready for reporting:
    ```sql
    SELECT * FROM gold.dim_customers;
    SELECT * FROM gold.fact_sales;
    SELECT * FROM gold.dim_products;
    ```

---

## 📊 Key Transformations (Silver Layer)
The SQL scripts in the Silver layer handle specific data quality issues:
* **Sanitization:** `TRIM()` applied to text fields to remove unwanted spaces.
* **Deduplication:** Logic implemented to ensure unique primary keys.
* **Normalization:**
    * *Gender:* Standardized (e.g., 'M' -> 'Male', 'F' -> 'Female' or 'Unknown').
    * *Marital Status:* Standardized (e.g., 'M' -> 'Married', ''S' -> Single' ).
* **Null Handling:** Default values applied where critical attributes were missing.
* **Handled Dates:** handled incorrect dates and corrected data type.

---
---
## 📈 Data Analysis & Reporting
After building the Gold layer, I performed comprehensive data analysis using SQL to validate the warehouse and generate business insights. This process was divided into Exploratory Data Analysis (EDA) and Advanced Analytics.

### 1. Exploratory Data Analysis (EDA)
Before jumping into complex reporting, I conducted EDA to understand the dataset's structure and health:
* **Database Exploration:** verified table structures, row counts, and schema integrity.
* **Dimensions Exploration:** Analyzed distinct values in dimension tables (`dim_customers`, `dim_products`) to ensure data consistency.
* **Date Exploration:** Validated the date ranges and temporal distribution of sales data.
* **Measures Exploration:** Calculated "Big Numbers" (Total Revenue, Total Orders) to establish baseline metrics.
* **Magnitude & Ranking:** Identified Top N and Bottom N performers (e.g., top customers, best-selling products) to spot outliers and key drivers.

### 2. Advanced Analytics
I used complex SQL queries to derive actionable business intelligence:
* **Change-Over-Time Analysis:** Analyzed sales trends year-over-year and month-over-month to identify seasonality.
* **Cumulative Analysis:** Calculated running totals and moving averages to visualize growth trajectories.
* **Performance Analysis:** Compared actual sales against historical benchmarks.
* **Part-to-Whole Analysis:** calculated the proportional contribution of different product categories to the total revenue.
* **Data Segmentation:** Segmented customers and products to understand different market groups.
* **Report Generation:** Created final summary views summarizing key business KPIs.
---
## 📬 Contact & Feedback
If you have any questions or suggestions regarding this Data Warehouse implementation, please feel free to reach out or open an issue in the repository.
