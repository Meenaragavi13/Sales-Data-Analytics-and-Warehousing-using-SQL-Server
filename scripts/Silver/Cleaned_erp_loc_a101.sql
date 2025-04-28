PRINT '>>Truncating Table: silver.erp_loc_a101';
TRUNCATE TABLE silver.erp_loc_a101;

print '>>Inserting data into silver.erp_loc_a101';
INSERT INTO silver.erp_loc_a101
(cid,cntry)
SELECT
REPLACE(CID,'-','') AS CID,
CASE WHEN TRIM(cntry) = 'DE' then 'Germany'
     WHEN TRIM(cntry) IN ('US','USA') then 'United States'
     WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
     ELSE TRIM(CNTRY)
END AS cntry
from bronze.erp_loc_a101;
