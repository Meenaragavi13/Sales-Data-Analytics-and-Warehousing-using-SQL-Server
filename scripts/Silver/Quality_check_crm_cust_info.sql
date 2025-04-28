--Check for NULL or Duplicates in Primary Key 
--Exception: NO Result

SELECT CST_ID, COUNT(*) 
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1 OR CST_ID IS NULL;

-- Check for unwanted Spaces 
--Exception: NO results
SELECT CST_FIRSTNAME 
FROM silver.crm_cust_info 
WHERE cst_firstname!=TRIM(cst_firstname);

--Data Standardization AND Consistency
SELECT cst_gndr
FROM silver.crm_cust_info 
WHERE cst_gndr!=TRIM(cst_gndr)

SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;