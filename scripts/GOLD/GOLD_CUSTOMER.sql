CREATE VIEW gold.dim_customers AS
SELECT 
    ROW_NUMBER() OVER(ORDER BY cst_id) AS CUSTOMER_KEY,--surrogate key
	ci.CST_ID as customer_id,
	ci.CST_KEY as customer_number,
	ci.CST_FIRSTNAME as first_name,
	ci.CST_LASTNAME as last_name,
	la.cntry as country,
	ci.cst_marital_status as marital_status,
	CASE WHEN ci.cst_gndr!='n/a' THEN ci.cst_gndr
	     ELSE COALESCE(ca.gen,'n/a')
	END AS gender,
	ca.bdate as birthdate,
	ci.CST_CREATE_DATE as create_date
FROM SILVER.CRM_CUST_INFO ci
LEFT JOIN SILVER.erp_cust_az12 CA
ON ci.cst_key=ca.cid
LEFT JOIN SILVER.erp_loc_a101 LA
ON ci.cst_key = LA.cid;