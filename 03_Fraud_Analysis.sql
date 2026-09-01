--- Fraud Volume ---
SELECT
    COUNT(*) AS total_fraud_transactions
FROM fraud_transactions
WHERE is_fraud = 1;


--- Fraud vs Non-Fraud Volume ---
SELECT
    is_fraud,
    COUNT(*) AS transaction_count
FROM fraud_transactions
GROUP BY is_fraud;

--- Fraud Rate ---
SELECT
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS fraud_rate
FROM fraud_transactions;


--- Fraud Transaction Value ---
SELECT
    ROUND(SUM(amount), 2) AS fraud_transaction_value
FROM fraud_transactions
WHERE is_fraud = 1;


--- Average Fraudulent Transaction Amount ---
SELECT
    ROUND(AVG(amount), 2) AS avg_fraud_amount
FROM fraud_transactions
WHERE is_fraud = 1;


--- Fraud by Transaction Type ---
SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS fraud_rate
FROM fraud_transactions
GROUP BY transaction_type
ORDER BY fraud_rate DESC;


--- Fraud by Merchant Category ---
SELECT
    merchant_category,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS fraud_rate
FROM fraud_transactions
GROUP BY merchant_category
ORDER BY fraud_rate DESC;

--- Fraud by Country ---
SELECT
    merchant_country,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS fraud_rate
FROM fraud_transactions
GROUP BY merchant_country
ORDER BY fraud_rate DESC;


--- Fraud Over Time-  investigate whether fraud activity changes over time ---
SELECT
    DATE_FORMAT(timestamp, '%Y-%m') AS month,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS fraud_rate
FROM fraud_transactions
GROUP BY DATE_FORMAT(timestamp, '%Y-%m')
ORDER BY month;


--- Fraud Types ---
SELECT
    fraud_type,
    COUNT(*) AS fraud_transactions
FROM fraud_transactions
WHERE is_fraud = 1
GROUP BY fraud_type
ORDER BY fraud_transactions DESC;