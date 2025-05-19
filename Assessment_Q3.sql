-- Question 3: Account Inactivity Alert
-- Goal: Identify all active savings or investment accounts that have had no deposits for the past 365 days.

-- Step 1: Combine both savings and investment plans
SELECT 
    p.id AS plan_id,
    p.owner_id,
    
    -- Label the account type based on flags
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Unknown'
    END AS type,

    -- Get the date of the most recent confirmed inflow
    MAX(sa.created_on) AS last_transaction_date,

    -- Calculate days since last transaction
    DATEDIFF(CURDATE(), MAX(sa.created_on)) AS inactivity_days
FROM plans_plan p
LEFT JOIN savings_savingsaccount sa ON p.id = sa.plan_id AND sa.confirmed_amount > 0
WHERE (p.is_regular_savings = 1 OR p.is_a_fund = 1) -- Only active plans
GROUP BY p.id, p.owner_id, type
HAVING last_transaction_date IS NULL OR inactivity_days > 365 -- Flag if over 1 year
ORDER BY inactivity_days DESC; -- Accounts longest inactive shown first