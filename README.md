# DataAnalytics-Assessment
SQL Assessment Project - Solutions to SQL business problems across multiple tables

### Assessment_Q1.sql

**Question**: Identify customers who have both at least one funded savings plan and one funded investment plan.

**Approach**:
- Used `is_a_fund = 1` for investment plans.
- Considered only entries with `confirmed_amount > 0` as funded for savings plans and `amount > 0` for investment plans.
- Aggregated savings data by:
  - Counting records per customer
  - Summing `confirmed_amount`, divided by 100.0 to convert from kobo to naira.
- Aggregated investment data similarly, using count only as amount was not required in output.
- Joined both datasets on `owner_id`, which links back to the `users_customuser.id`.
- Sorted by `total_deposits` descending to get high-value customers at the top.

**Challenges**:
- Ensured correct identification of savings vs. investment plans using provided flags.
- Took care to convert kobo to naira for readable output.
