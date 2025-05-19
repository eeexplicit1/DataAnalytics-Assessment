-- Question 4: Customer Lifetime Value (CLV) Estimation
-- Goal: Estimate CLV using tenure (months), total transactions, and average profit per transaction

-- Step 1: Calculate total transactions and total value per customer
WITH customer_transactions AS (
    SELECT 
        sa.owner_id AS customer_id, -- customer linked to savings account
        COUNT(*) AS total_transactions, -- total number of transactions
        SUM(sa.confirmed_amount) / 100 AS total_transaction_value -- total value of transactions converted from kobo to Naira
    FROM savings_savingsaccount sa
    GROUP BY sa.owner_id
),

-- Step 2: Calculate tenure in months from signup date to today
tenure_calculation AS (
    SELECT 
        u.id AS customer_id,
        CONCAT(u.first_name, ' ',u.last_name) AS name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months -- number of months since account creation
    FROM users_customuser u
),

-- Step 3: Combine both tables and calculate average profit per transaction
combined_data AS (
    SELECT 
        t.customer_id,
        te.name,
        te.tenure_months,
        t.total_transactions,
        
        -- Calculate average profit per transaction:
        -- Profit is 0.1% (0.001) of total transaction value divided by total number of transactions
        (t.total_transaction_value * 0.001) / NULLIF(t.total_transactions, 0) AS avg_profit_per_transaction
    FROM customer_transactions t
    JOIN tenure_calculation te ON t.customer_id = te.customer_id
)

-- Step 4: Apply CLV formula and present final output
SELECT 
    cd.customer_id,
    cd.name,
    cd.tenure_months,
    cd.total_transactions,
    
    -- CLV formula:
    -- (total_transactions / tenure) * 12 months * avg profit per transaction
    -- Rounded to 2 decimal places
    ROUND((cd.total_transactions / NULLIF(cd.tenure_months, 0)) * 12 * cd.avg_profit_per_transaction, 2) AS estimated_clv
FROM combined_data cd
ORDER BY estimated_clv DESC; -- Show customers with highest value first