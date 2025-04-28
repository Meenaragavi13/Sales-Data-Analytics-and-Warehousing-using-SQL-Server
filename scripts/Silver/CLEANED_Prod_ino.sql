PRINT '>>Truncating Table: silver.crm_prod_info';
TRUNCATE TABLE silver.crm_prod_info;

print '>>Inserting data into silver.crm_prod_info';

Insert into silver.crm_prod_info
(prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt)

SELECT
prd_id,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) as prd_key, 
prd_nm,
ISNULL(prd_cost,0) as prd_cost,
case upper(trim(prd_line))
     when 'M' then 'Mountain'
     when 'R' then 'Road'
	 when 'T' then 'Touring'
	 when 'S' then 'Other Sales'
	 ELSE 'N/A'
	 END AS PRD_LINE,
CAST(prd_start_dt AS DATE) AS prd_start_dt,
CAST(
    LEAD(prd_start_dt) OVER(partition by prd_key ORDER BY prd_start_dt)-1 
	AS DATE) AS prd_end_dt_test -- Created end date as the start date of the next record -1
from bronze.crm_prod_info;
