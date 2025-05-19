# Data Analytics SQL Proficiency Assessment

This repository contains solutions to a SQL-based data analytics assessment designed to evaluate query performance, optimization, and problem-solving skills using relational databases.

---

## Questions & Explanations

### **Question 1: High-Value Customers with Multiple Products**

**Objective:** Identify customers who have both at least one funded savings plan and one funded investment plan.

**Approach:**
- Joined the `users_customuser`, `plans_plan`, and `savings_savingsaccount` tables.
- Filtered for funded savings and investment plans using `is_regular_savings` and `is_a_fund`.
- Used `COUNT()` to get the number of each type of product.
- Aggregated `confirmed_amount` to get total deposits.

---

### **Question 2: Transaction Frequency Analysis**

**Objective:** Categorize customers based on average transaction frequency per month.

**Approach:**
- Calculated total transactions per customer.
- Averaged the counts to find per customer frequency.
- Used `CASE` to classify customers into High, Medium, or Low frequency groups.
- Grouped by frequency category.

---

### **Question 3: Account Inactivity Alert**

**Objective:** Flag accounts with no inflow transactions in the past 365 days.

**Approach:**
- Retrieved last transaction date for each plan or savings account.
- Compared to current date to find those with over 365 days of inactivity.
- Returned plan/account type, owner, and inactivity days.

---

### **Question 4: Customer Lifetime Value (CLV) Estimation**

**Objective:** Estimate CLV based on tenure and transaction volume.

**Approach:**
- Tenure = months since user signup.
- Total transactions = count of savings inflows.
- CLV estimated using the formula:
\[
  CLV = \left(\frac{\text{total_transactions}}{\text{tenure}}\right) \times 12 \times \text{avg_profit_per_transaction}
\]
  where profit per transaction = 0.1% of transaction value.

---

## Challenges Encountered

- Ensured handling of partial months and differing activity spans by using average per customer over time.
- Some columns were misaligned between assumptions and schema (e.g., `is_regular_savings` was actually in `plans_plan`).
- Ensuring compatibility with MySQL syntax such as `DATEDIFF()` and `TIMESTAMPDIFF()`.
- Avoiding double-counting in joins, especially when multiple tables reference the same keys.
- All amounts were in **kobo**, requiring conversion to **naira** where necessary for readability.

---

## Setup & Run

You can run each `.sql` file individually in any MySQL interface connected to the corresponding schema.

**NOTE:** All sensitive data or database dumps are excluded in line with privacy and submission policies.

---

## Author

- EE Explicit
- [@eeexplicit1](https://github.com/eeexplicit1)