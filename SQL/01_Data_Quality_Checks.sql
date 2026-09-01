CREATE TABLE fraud_transactions (
    transaction_id VARCHAR(50),
    timestamp DATETIME,
    customer_id VARCHAR(50),
    card_id VARCHAR(50),
    device_id VARCHAR(50),
    ip_address VARCHAR(50),
    merchant_id VARCHAR(50),
    merchant_category VARCHAR(100),
    merchant_country VARCHAR(10),
    merchant_city VARCHAR(100),
    merchant_latitude DECIMAL(10,6),
    merchant_longitude DECIMAL(10,6),
    transaction_type VARCHAR(50),
    amount DECIMAL(12,2),
    currency VARCHAR(10),
    is_fraud TINYINT,
    fraud_type VARCHAR(100)
);

--- Step 1 - Row Count ---
---  how many transactions are in our table ---
SELECT COUNT(*) AS total_transactions
FROM fraud_transactions;

DESCRIBE fraud_transactions;

--- Step 2 - Duplicate Check ---
---  find out whether the same transaction ID appears more than once ---
SELECT 
    transaction_id,
    COUNT(*) AS occurrence_count
FROM fraud_transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;

--- Step 3 - NULL / Missing-Value Check ---
---  to check whether any columns contain NULL values ---
SELECT
    SUM(transaction_id IS NULL) AS transaction_id_nulls,
    SUM(timestamp IS NULL) AS timestamp_nulls,
    SUM(customer_id IS NULL) AS customer_id_nulls,
    SUM(card_id IS NULL) AS card_id_nulls,
    SUM(device_id IS NULL) AS device_id_nulls,
    SUM(ip_address IS NULL) AS ip_address_nulls,
    SUM(merchant_id IS NULL) AS merchant_id_nulls,
    SUM(merchant_category IS NULL) AS merchant_category_nulls,
    SUM(merchant_country IS NULL) AS merchant_country_nulls,
    SUM(merchant_city IS NULL) AS merchant_city_nulls,
    SUM(merchant_latitude IS NULL) AS merchant_latitude_nulls,
    SUM(merchant_longitude IS NULL) AS merchant_longitude_nulls,
    SUM(transaction_type IS NULL) AS transaction_type_nulls,
    SUM(amount IS NULL) AS amount_nulls,
    SUM(currency IS NULL) AS currency_nulls,
    SUM(is_fraud IS NULL) AS is_fraud_nulls,
    SUM(fraud_type IS NULL) AS fraud_type_nulls
FROM fraud_transactions;


--- step 4 - Unique-Value Checks ---
---  what values actually exist in important categorical columns ---
SELECT DISTINCT transaction_type
FROM fraud_transactions;

SELECT DISTINCT merchant_category
FROM fraud_transactions;

SELECT DISTINCT merchant_country
FROM fraud_transactions;

SELECT DISTINCT currency
FROM fraud_transactions;

SELECT DISTINCT is_fraud
FROM fraud_transactions;

SELECT DISTINCT fraud_type
FROM fraud_transactions;

SELECT 
    fraud_type,
    COUNT(*) AS count
FROM fraud_transactions
GROUP BY fraud_type;

--- Step 5 - Invalid / Unexpected Values ---
SELECT DISTINCT transaction_type
FROM fraud_transactions
WHERE transaction_type NOT IN ('purchase', 'transfer');

SELECT DISTINCT merchant_category
FROM fraud_transactions
WHERE merchant_category NOT IN (
    'restaurants',
    'electronics',
    'fashion',
    'pharmacy',
    'utilities',
    'grocery',
    'gas_station',
    'travel',
    'entertainment',
    'online_marketplace',
    'transfer'
);

SELECT DISTINCT merchant_country
FROM fraud_transactions
WHERE merchant_country NOT IN (
    'CA',
    'GB',
    'BR',
    'DE',
    'AU',
    'IN',
    'ES',
    'IT',
    'FR',
    'US'
);

SELECT DISTINCT currency
FROM fraud_transactions
WHERE currency <> 'USD';

SELECT DISTINCT is_fraud
FROM fraud_transactions
WHERE is_fraud NOT IN (0, 1);

SELECT COUNT(*) AS negative_amounts
FROM fraud_transactions
WHERE amount < 0;

SELECT COUNT(*) AS zero_amounts
FROM fraud_transactions
WHERE amount = 0;

--- Step 6 - is_fraud Validation ---
SELECT
    is_fraud,
    COUNT(*) AS transaction_count
FROM fraud_transactions
GROUP BY is_fraud;

--- Step 7 - Fraud Type Validation ---
SELECT COUNT(*) AS fraud_without_type
FROM fraud_transactions
WHERE is_fraud = 1
  AND (fraud_type IS NULL OR fraud_type = '');
  
 
--- Step 8 - Date/Time Validation ---
SELECT
    MIN(timestamp) AS earliest_transaction,
    MAX(timestamp) AS latest_transaction
FROM fraud_transactions;