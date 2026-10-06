SELECT * FROM fact_retail_sales;


SELECT 
	COUNT(*) AS total_records,
	ROUND(SUM(CASE WHEN transaction_type = 'SALE' THEN amount_paid ELSE 0 END),2) AS sales_revenue,
	ROUND(SUM(CASE WHEN transaction_type = 'RETURN' THEN amount_paid ELSE 0 END),2) AS return_deductions,
	ROUND(SUM(CASE WHEN transaction_type = 'SALE' THEN amount_paid ELSE - amount_paid END),2) AS net_revenue
FROM fact_retail_sales;



