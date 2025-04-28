use DataWarehouse;
PRINT '>>Truncating Table: silver.crm_sales_details';
TRUNCATE TABLE silver.crm_sales_details;

print '>>Inserting data into silver.crm_sales_details';
INSERT INTO silver.crm_sales_details (sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
)
Select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt)!=8 THEN NULL
	 ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
	 END AS sls_order_dt,
CASE WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt)!=8 THEN NULL
	 ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
	 END AS sls_ship_dt,
CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt)!=8 THEN NULL
	 ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
	 END AS sls_due_dt,
CASE when sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
     then sls_quantity * ABS(sls_price)
	 ELSE sls_sales
END as sls_sales,
sls_quantity,
CASE WHEN sls_price is NULL OR sls_price<=0
     THEN sls_sales/ NULLIF(sls_quantity,0)
	 ELSE sls_price
END AS SLS_price
from bronze.crm_sales_details;