use DataWarehouse;

PRINT '>>Truncating Table: Silver.erp_px_cat_g1v2';
TRUNCATE TABLE silver.erp_px_cat_g1v2;

print '>>Inserting data into Silver.erp_px_cat_g1v2';
INSERT INTO SILVER.erp_px_cat_g1v2
(id,cat,subcat,maintenance)
Select 
id,
cat,
subcat,
maintenance
from bronze.erp_px_cat_g1v2;

