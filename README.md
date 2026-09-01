# Fraud-Detection-Transaction-Risk-Analysis-SQL
Fraud Detection and Transaction Risk Analysis using SQL

## Project Overview

This project analyzes financial transaction data to identify fraud patterns and assess transaction risk using SQL.

The analysis focuses on fraud rates, fraudulent transaction values, transaction types, merchant categories, countries, fraud activity over time, and fraud types.

The project also includes advanced SQL analysis to identify fraud contribution, fraud concentration, unusual fraud periods, and risk classification.

## Business Problem

Financial transaction data can contain fraudulent activities that may lead to financial losses and increased transaction risk.

The business needs to understand where fraud occurs, how frequently it occurs, which transaction types and merchant categories are more exposed, and whether fraud activity changes over time.

The goal is to use transaction data to identify fraud patterns and areas that may require further investigation or monitoring.

## Project Objective

- Calculate the overall fraud rate and fraudulent transaction value.
- Analyze fraud across transaction types, merchant categories, and countries.
- Identify fraud patterns and changes in fraud activity over time.
- Analyze the most common fraud types.
- Perform advanced SQL analysis to identify priority risk areas, fraud contribution, fraud concentration, unusual fraud periods, and risk classification.
- Generate business insights that can support fraud monitoring and risk management.

  ## Dataset

The dataset contains financial transaction records with information about transaction amounts, transaction types, merchant categories, countries, timestamps, fraud indicators, and fraud types.

The dataset was used to analyze transaction patterns and identify potential fraud risks using SQL.

## SQL Analysis

The project includes the following SQL analysis:

- Data quality checks
- Exploratory data analysis (EDA)
- Fraud analysis
- Business question analysis
- Advanced SQL analysis

### SQL Techniques Used

- SELECT and filtering
- GROUP BY and aggregate functions
- CASE statements
- Subqueries
- Common Table Expressions (CTEs)
- Window functions
- Ranking
- Date-based analysis

  ## Key Business Results

- Overall fraud rate was **0.15%**.
- Fraudulent transaction value was **37,143.72**.
- Transfer had a **100% fraud rate**, while purchase transactions had a **0.14% fraud rate**.
- Online marketplace had the highest merchant-category fraud rate at **0.21%**.
- Fraud rates across countries ranged from **0.14% to 0.16%**.
- Average transaction amount was **24.93 for fraudulent transactions** and **38.22 for non-fraudulent transactions**.
- Monthly fraudulent transactions ranged from **106 to 142** after November 2024.
- Card testing was the most common fraud type, accounting for **53.69%**.
- The top 5 merchant categories contributed **53.82%** of fraudulent transactions.
- Transfer was classified as **High Risk**, while online marketplace was classified as **Medium Risk** based on the project's risk thresholds.

  ## Key Insights

- Overall fraud exposure is relatively low, with an overall fraud rate of 0.15%.
- Fraud is not evenly distributed across transaction types, with transfer showing an extreme fraud rate.
- Online marketplace has the highest merchant-category fraud rate, although its fraud volume is relatively small.
- Fraud contribution is distributed across several merchant categories rather than being concentrated in only one or two categories.
- Fraud activity varies over time, with January 2025 showing the highest above-average monthly fraud volume.
- Card testing represents the largest share of identified fraud types.
- The transfer category requires cautious interpretation because its 100% fraud rate is based on only 80 transactions.

  ## Business Recommendations

- Monitor transfer transactions closely and investigate the high fraud rate, while considering the small transaction volume.
- Apply additional monitoring to online marketplace transactions because they have the highest merchant-category fraud rate.
- Prioritize monitoring across the merchant categories contributing the largest share of fraudulent transactions.
- Investigate months with above-average fraud activity to identify potential changes in transaction behavior or fraud patterns.
- Strengthen controls against card testing because it represents the largest share of identified fraud types.
- Use transaction-level and category-level risk indicators to support ongoing fraud monitoring and investigation.


  ## Project Structure

```text
Fraud-Detection-Transaction-Risk-Analysis-SQL/
│
├── README.md
│
├── SQL/
│   ├── 01_Data_Quality_Checks.sql
│   ├── 02_EDA.sql
│   ├── 03_Fraud_Analysis.sql
│   ├── 04_Business_Questions.sql
│   └── 05_Advanced_SQL.sql
│
└── Results/
    ├── BQ_Results/
    │   └── BQ_Results.txt
    │
    └── AQ_Results/
        └── AQ_Results.txt
