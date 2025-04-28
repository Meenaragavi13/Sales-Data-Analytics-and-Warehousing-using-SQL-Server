use DataWarehouse;

Select 
CASE WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID,4,LEN(CID))
     ELSE CID
END cid,
bdate,gen
from bronze.erp_cust_az12
wheRE CASE WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID,4,LEN(CID))
     ELSE CID
END NOT IN (SELECT DISTINCT CST_KEY from Silver.crm_cust_info);

--IDENTIFY OUT-OF-RANGE DATES
SELECT DISTINCT 
bdate
from bronze.erp_cust_az12
where bdate <'1924-01-01' --(more than 100 years)

SELECT DISTINCT 
bdate
from bronze.erp_cust_az12
where bdate > getdate();

--Data Standardization & Consistency
SELECT DISTINCT gen 
FROM bronze.erp_cust_az12;