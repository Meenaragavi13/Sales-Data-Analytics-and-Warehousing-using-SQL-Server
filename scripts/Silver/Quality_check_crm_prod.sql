--Quality Checks
--Check for NULLS or duplicates in primary key
-- exception:NO result

USE DataWarehouse;

SELECT 
prd_id,
count(*)
from silver.crm_prod_info
group by prd_id 
HAVING count(*)>1 OR prd_id IS NULL;

--check for unwanted Spaces 
--Exceptation: No results
Select prd_nm
from silver.crm_prod_info
where prd_nm != TRIM(prd_nm);

--Check fro NUlls or Negative Numbers
--Exceptation: NO results
SELECT prd_cost 
FROM silver.crm_prod_info
Where prd_cost<0 OR prd_cost is NULL;

--Data Standardization & Consistency
SELECT DISTINCT PRD_LINE
FROM silver.crm_prod_info;

--Check for invalid Date Orders
Select *
from silver.crm_prod_info
where prd_end_dt < prd_start_dt;


