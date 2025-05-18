SELECT
  frequency_category,
  COUNT(*) AS customer_count,
  ROUND(AVG(transactions_per_month), 2) AS avg_transactions_per_month
FROM (
  SELECT
    s.owner_id,
    COUNT(*) / (TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1) AS transactions_per_month,
    CASE
      WHEN COUNT(*) / (TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1) >= 10 THEN 'High Frequency'
      WHEN COUNT(*) / (TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1) BETWEEN 3 AND 9 THEN 'Medium Frequency'
      ELSE 'Low Frequency'
    END AS frequency_category
  FROM savings_savingsaccount s
  WHERE s.transaction_status IS NOT NULL
    AND LOWER(s.transaction_status) IN ('success', 'successful', 'monnify_success')
    AND s.transaction_date IS NOT NULL
  GROUP BY s.owner_id
) AS t
GROUP BY frequency_category;