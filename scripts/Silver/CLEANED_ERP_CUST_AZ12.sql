PRINT '>>Truncating Table:  silver.erp_cust_az12';
TRUNCATE TABLE  silver.erp_cust_az12;

print '>>Inserting data into silver.erp_cust_az12';
INSERT INTO silver.erp_cust_az12 (cid,bdate,gen)
Select 
CASE WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID,4,LEN(CID))
     ELSE CID
END cid,
CASE WHEN bdate > GETDATE() THEN NULL
     ELSE bdate
END AS bdate,
case WHEN UPPER(TRIM(GEN)) IN ('F','FEMALE') then 'Female'
     WHEN UPPER(TRIM(GEN)) IN ('M','MALE')  THEN 'Male'
     ELSE 'N/A'
END AS GEN
from bronze.erp_cust_az12;
