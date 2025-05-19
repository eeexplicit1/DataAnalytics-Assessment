# Question 1: Identify high-value customers with both funded savings and investment plans(Multiple Products)
/* Goal: Find users who have at least one funded savings plan and one funded investment plan,
and order them by total deposits.*/

USE `adashi_staging`;
SELECT 
    u.id AS owner_id,            -- Customer ID
    concat(u.first_name, ' ', u.last_name) as name,            -- Customer Name

    -- Count of distinct funded regular savings plans
    COUNT(DISTINCT CASE 
        WHEN p.is_regular_savings = 1 THEN p.id
    END) AS savings_count,

    -- Count of distinct funded investment plans
    COUNT(DISTINCT CASE 
        WHEN p.is_a_fund = 1 THEN p.id
    END) AS investment_count,

    -- Total confirmed deposits for all plans (in Naira)
    ROUND(SUM(CASE 
        WHEN sa.confirmed_amount IS NOT NULL THEN sa.confirmed_amount
        ELSE 0
    END) / 100, 2) AS total_deposits

FROM users_customuser u

-- Join to plans to find savings and investment ownership
JOIN plans_plan p ON u.id = p.owner_id

-- Join to savings_savingsaccount to access confirmed inflow
JOIN savings_savingsaccount sa ON sa.plan_id = p.id 
    AND sa.confirmed_amount > 0 -- Only count funded transactions

GROUP BY u.id, u.name

-- Filter: Must have at least one savings and one investment plan
HAVING savings_count > 0 AND investment_count > 0

-- Order by highest depositors
ORDER BY total_deposits DESC;