-- Question 2: Transaction Frequency Analysis
-- Goal: Categorize customers based on average transaction frequency per month.

-- Step 1: Calculate the number of transactions per customer per month
WITH monthly_transactions AS (
    SELECT 
        owner_id,
        DATE_FORMAT(created_on, '%Y-%m') AS month,
        COUNT(*) AS transactions_in_month
    FROM savings_savingsaccount
    GROUP BY owner_id, DATE_FORMAT(created_on, '%Y-%m')
),

-- Step 2: Calculate the average transactions per month for each customer
avg_monthly_transactions AS (
    SELECT 
        owner_id,
        AVG(transactions_in_month) AS avg_transactions_per_month
    FROM monthly_transactions
    GROUP BY owner_id
),

-- Step 3: Categorize customers by frequency
categorized_customers AS (
    SELECT
        CASE 
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_transactions_per_month
    FROM avg_monthly_transactions
)

-- Step 4: Final aggregation for category counts and average
SELECT
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM categorized_customers
GROUP BY frequency_category
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END;