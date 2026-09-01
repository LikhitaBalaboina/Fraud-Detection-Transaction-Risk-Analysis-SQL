--- Analysis 1: Transaction Distribution ---
--- how many transactions are there for each transaction type ---
SELECT
    transaction_type,
    COUNT(*) AS transaction_count
FROM fraud_transactions
GROUP BY transaction_type;

--- Analysis 2: Amount Distribution ---
SELECT
    MIN(amount) AS minimum_amount,
    MAX(amount) AS maximum_amount,
    AVG(amount) AS average_amount
FROM fraud_transactions;

--- Analysis 3: Transaction Types ---
SELECT
    transaction_type,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM fraud_transactions
GROUP BY transaction_type;

--- Analysis 4: Merchant Categories ---
SELECT
    merchant_category,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM fraud_transactions
GROUP BY merchant_category
ORDER BY transaction_count DESC;

--- Analysis 5: Countries ---
SELECT
    merchant_country,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM fraud_transactions
GROUP BY merchant_country
ORDER BY transaction_count DESC;

--- Analysis 6: Fraud vs Non-Fraud Overview ---
SELECT
    is_fraud,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM fraud_transactions
GROUP BY is_fraud;

--- Analysis 7: Monthly Transaction Pattern ---
SELECT
    DATE_FORMAT(timestamp, '%Y-%m') AS transaction_month,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM fraud_transactions
GROUP BY DATE_FORMAT(timestamp, '%Y-%m')
ORDER BY transaction_month;