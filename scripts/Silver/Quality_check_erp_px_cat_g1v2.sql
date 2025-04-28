use DataWarehouse;
Select 
id,
cat,
subcat,
maintenance
from bronze.erp_px_cat_g1v2;

--Check for unwanted spaces
SELECT * FROM Bronze.erp_px_cat_g1v2
WHERE cat!=TRIM(CAT) or subcat!=TRIM(subcat) or
maintenance!=TRIM(maintenance);

--Data Standardization & Consistency
SELECT DISTINCT CAT
FROM bronze.erp_px_cat_g1v2;

SELECT DISTINCT SUBCAT
FROM bronze.erp_px_cat_g1v2;

SELECT DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2;


select * from silver.erp_px_cat_g1v2;


