--- AQ1: Priority Risk ---
WITH category_fraud AS (
    SELECT
        merchant_category,
        COUNT(*) AS total_transactions,
        SUM(is_fraud) AS fraudulent_transactions,
        ROUND(
            SUM(is_fraud) * 100.0 / COUNT(*),
            2
        ) AS fraud_rate
    FROM fraud_transactions
    GROUP BY merchant_category
)

SELECT
    merchant_category,
    total_transactions,
    fraudulent_transactions,
    fraud_rate
FROM category_fraud
WHERE fraudulent_transactions > (
    SELECT AVG(fraudulent_transactions)
    FROM category_fraud
)
AND fraud_rate > (
    SELECT AVG(fraud_rate)
    FROM category_fraud
);



--- AQ2: Fraud Contribution ---
WITH category_fraud AS (
    SELECT
        merchant_category,
        SUM(is_fraud) AS fraudulent_transactions
    FROM fraud_transactions
    GROUP BY merchant_category
)

SELECT
    merchant_category,
    fraudulent_transactions,
    ROUND(
        fraudulent_transactions * 100.0 /
        SUM(fraudulent_transactions) OVER (),
        2
    ) AS fraud_contribution_pct,
    RANK() OVER (
        ORDER BY fraudulent_transactions DESC
    ) AS fraud_rank
FROM category_fraud
ORDER BY fraud_rank;



--- AQ3: Fraud Concentration ---
WITH category_fraud AS (
    SELECT
        merchant_category,
        SUM(is_fraud) AS fraudulent_transactions
    FROM fraud_transactions
    GROUP BY merchant_category
),

fraud_contribution AS (
    SELECT
        merchant_category,
        fraudulent_transactions,
        ROUND(
            fraudulent_transactions * 100.0 /
            SUM(fraudulent_transactions) OVER (),
            2
        ) AS fraud_contribution_pct,
        RANK() OVER (
            ORDER BY fraudulent_transactions DESC
        ) AS fraud_rank
    FROM category_fraud
)

SELECT
    merchant_category,
    fraudulent_transactions,
    fraud_contribution_pct,
    ROUND(
        SUM(fraud_contribution_pct) OVER (
            ORDER BY fraud_rank
        ),
        2
    ) AS cumulative_contribution_pct
FROM fraud_contribution
ORDER BY fraud_rank;



--- AQ4: Unusual Fraud Periods ---
WITH monthly_fraud AS (
    SELECT
        DATE_FORMAT(`timestamp`, '%Y-%m') AS fraud_month,
        SUM(is_fraud) AS fraudulent_transactions
    FROM fraud_transactions
    GROUP BY DATE_FORMAT(`timestamp`, '%Y-%m')
)

SELECT
    fraud_month,
    fraudulent_transactions
FROM monthly_fraud
WHERE fraudulent_transactions > (
    SELECT AVG(fraudulent_transactions)
    FROM monthly_fraud
)
ORDER BY fraud_month;



--- AQ5: Risk Classification ---
WITH category_fraud AS (
    SELECT
        merchant_category,
        COUNT(*) AS total_transactions,
        SUM(is_fraud) AS fraudulent_transactions,
        ROUND(
            SUM(is_fraud) * 100.0 / COUNT(*),
            2
        ) AS fraud_rate
    FROM fraud_transactions
    GROUP BY merchant_category
)

SELECT
    merchant_category,
    total_transactions,
    fraudulent_transactions,
    fraud_rate,
    CASE
        WHEN fraud_rate < 0.20 THEN 'Low Risk'
        WHEN fraud_rate < 1.00 THEN 'Medium Risk'
        ELSE 'High Risk'
    END AS risk_level
FROM category_fraud
ORDER BY fraud_rate DESC;