Select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
from bronze.crm_sales_details
where sls_ord_num != TRIM(sls_ord_num);

Select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
from bronze.crm_sales_details
where sls_prd_key not in (SELECT prd_key from silver.crm_prod_info);


Select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
from bronze.crm_sales_details
where sls_cust_id not in (SELECT cst_id from silver.crm_cust_info)

--CHECk FOR INVALID DATES
Select 
NULLIF(sls_order_dt,0) AS sls_order_dt
from bronze.crm_sales_details
WHERE SLS_ORDER_DT <=0 or len(sls_order_dt)!=8;

Select 
NULLIF(sls_order_dt,0) AS sls_order_dt
from bronze.crm_sales_details 
where sls_order_dt >20500101 OR sls_order_dt <19000101 --check for outlier

Select 
NULLIF(sls_ship_dt,0) AS sls_ship_dt
from bronze.crm_sales_details
WHERE sls_ship_dt <=0 or len(sls_ship_dt)!=8;

Select 
NULLIF(sls_ship_dt,0) AS sls_ship_dt
from bronze.crm_sales_details 
where sls_order_dt >20500101 OR sls_ship_dt <19000101;


Select 
*
from bronze.crm_sales_details
where sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt;


-- Business Rules
SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
from bronze.crm_sales_details
where sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL;

SELECT DISTINCT
sls_sales AS old_sales,
sls_quantity,
sls_price,
CASE when sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
     then sls_quantity * ABS(sls_price)
	 ELSE sls_sales
END as sls_sales,
CASE WHEN sls_price is NULL OR sls_price<=0
     THEN sls_sales/ NULLIF(sls_quantity,0)
	 ELSE sls_price
END AS SLS_price
from bronze.crm_sales_details