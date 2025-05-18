# DataAnalytics-Assessment
This repository contains SQL queries to series of analytical questions designed to assess SQL skills using business scenarios focusing on customer behaviour, account activity, transactional trends and performance.

## Per Question Explanations
### Assessment_Q1: High Value customers with multiple products
**Approach:** 
- Joined `users_customuser`, `plans_plan`, and `savings_savingsaccount` tables.
- Counted distinct savings and investment plans using conditional aggregation.
- Filtered for plans where `confirmed_amount > 0` (i.e., funded).
- Output includes: `owner_id`, `full name`, `number of savings and investment plans`, and `total deposits`.
- Results are ordered by total deposits in descending order.
  
**Challenge:**  
  Ensuring correct counts per customer and avoiding duplicate plan contributions required careful use of `DISTINCT` in conditional `COUNT()`.

### Assessment_Q2: Transaction Frequency Analysis
 **Approach:**  
  Used the `savings_savingsaccount` table.
- Filtered to include only successful transactions.
- Calculated the number of transactions per customer and normalized it over their activity span in months.
- Classified users into:
  - **High Frequency**: ≥10 transactions/month  
  - **Medium Frequency**: 3–9 transactions/month  
  - **Low Frequency**: ≤2 transactions/month  
- Aggregated the result to show total users in each category and their average transaction frequency.
**Challenge:**  
  Needed to normalize transaction counts across varying time spans, handled via `TIMESTAMPDIFF` and `+1` month offset to avoid division by zero.

### Assessment_Q3: Account Inactivity Alert
**Approach:**  
- Left joined `plans_plan` with `savings_savingsaccount`.  
- Focused only on non-archived, non-deleted, and active plans (either savings or investments).
- Filtered for successful transactions and calculated the days since the last transaction.
- Used `DATEDIFF` to compute inactivity duration.
- Returned only accounts with no activity in over a year or no transaction record at all.
  
**Challenge:**  
  Transaction status had success rate inconsistencies (`success` , `successful`,`monnify_success`)

### Assessment_Q4: Customer Lifetime Value(CLV) Estimation
**Approach:**  
  Joined `users_customuser` with `savings_savingsaccount`.
- Calculated:
  - **Tenure in months** (since account creation).
  - **Total number of transactions.**
  - **Average transaction value.**
- **Assumption:**  
  For each customer, the `profit_per_transaction` is **0.1%** of the transaction value.  
