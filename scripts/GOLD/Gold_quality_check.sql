USE DataWarehouse;

select cst_id, COUNT(*) from
	(SELECT 
	ci.CST_ID,
	ci.CST_KEY,
	ci.CST_FIRSTNAME,
	ci.CST_LASTNAME,
	ci.cst_marital_status,
	ci.CST_GNDR,
	ci.CST_CREATE_DATE,
	ca.bdate,
	ca.gen,
	la.cntry
	FROM SILVER.CRM_CUST_INFO ci
	LEFT JOIN SILVER.erp_cust_az12 CA
	ON ci.cst_key=ca.cid
	LEFT JOIN SILVER.erp_loc_a101 LA
	ON ci.cst_key = LA.cid)t 
GROUP BY CST_ID
HAVING COUNT(*)>1;

SELECT DISTINCT	
	ci.CST_GNDR,
	ca.gen
FROM SILVER.CRM_CUST_INFO ci
LEFT JOIN SILVER.erp_cust_az12 CA
ON ci.cst_key=ca.cid
LEFT JOIN SILVER.erp_loc_a101 LA
ON ci.cst_key = LA.cid;

SELECT DISTINCT	
	ci.CST_GNDR,
	ca.gen,
	CASE WHEN ci.cst_gndr!='n/a' THEN ci.cst_gndr
	     ELSE COALESCE(ca.gen,'n/a')
	END AS new_gen
FROM SILVER.CRM_CUST_INFO ci
LEFT JOIN SILVER.erp_cust_az12 CA
ON ci.cst_key=ca.cid
LEFT JOIN SILVER.erp_loc_a101 LA
ON ci.cst_key = LA.cid;

--product
SELECT prd_key, COUNT(*)
from (
    SELECT 
	pn.prd_id,
	pn.cat_id,
	pn.prd_key,
	pn.prd_nm,
	pn.prd_cost,
	pn.prd_line,
	pn.prd_start_dt,
	pn.prd_end_dt,
	pc.cat,
	pc.subcat,
	pc.maintenance
	from silver.crm_prod_info pn 
	LEFT JOIN SILVER.erp_px_cat_g1v2 PC
	ON pn.cat_id=pc.id
	where prd_end_dt is null )t
group by prd_key
having count(*) > 1;