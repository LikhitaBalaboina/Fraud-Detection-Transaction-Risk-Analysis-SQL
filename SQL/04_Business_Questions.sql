--- BQ1 — Overall Fraud Rate ---
SELECT
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraudulent_transactions,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate
FROM fraud_transactions;


--- BQ2 — Transaction Value Associated With Fraud ---
SELECT
    ROUND(SUM(amount), 2) AS fraud_transaction_value
FROM fraud_transactions
WHERE is_fraud = 1;


--- BQ3 — Fraud Rate by Transaction Type ---
SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraudulent_transactions,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate
FROM fraud_transactions
GROUP BY transaction_type;


--- BQ4 — Fraud Rate by Merchant Category ---
SELECT
    merchant_category,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraudulent_transactions,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate
FROM fraud_transactions
GROUP BY merchant_category;


--- BQ5 — Fraud Rate by Country ---
SELECT
    merchant_country,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraudulent_transactions,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate
FROM fraud_transactions
GROUP BY merchant_country;

--- BQ6 — Fraudulent vs Non-Fraudulent Transaction Amounts ---
SELECT
    CASE
        WHEN is_fraud = 1 THEN 'Fraud'
        ELSE 'Non-Fraud'
    END AS fraud_status,
    COUNT(*) AS total_transactions,
    ROUND(AVG(amount), 2) AS average_transaction_amount
FROM fraud_transactions
GROUP BY is_fraud;


--- BQ7 — Fraud Activity Over Time ---
SELECT
    DATE_FORMAT(timestamp, '%Y-%m') AS fraud_month,
    COUNT(*) AS fraudulent_transactions
FROM fraud_transactions
WHERE is_fraud = 1
GROUP BY DATE_FORMAT(timestamp, '%Y-%m')
ORDER BY fraud_month;


--- BQ8 — Most Common Fraud Types ---
SELECT
    fraud_type,
    COUNT(*) AS fraudulent_transactions
FROM fraud_transactions
WHERE is_fraud = 1
GROUP BY fraud_type;