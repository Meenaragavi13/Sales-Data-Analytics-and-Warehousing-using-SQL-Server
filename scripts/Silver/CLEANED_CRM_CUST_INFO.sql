
use DataWarehouse;
PRINT '>>Truncating Table: SILVER.crm_cust_info';
TRUNCATE TABLE SILVER.crm_cust_info;

print '>>Inserting data into SILVER.crm_cust_info';
INSERT INTO SILVER.crm_cust_info(
cst_id,cst_key,cst_firstname,cst_lastname,cst_material_status,cst_gndr,
cst_create_date)
SELECT 
cst_id,
cst_key,
TRIM(cst_firstname) as cst_firstname,
TRIM(cst_lastname) as cst_lastname,
CASE WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Single'
     when UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
	 ELSE 'n/a'
	 END as cst_material_status,
CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
     when UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
	 ELSE 'n/a'
	 END as cst_gndr,
cst_create_date
FROM
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY CST_ID ORDER BY CST_CREATE_DATE DESC) AS FLAG_LAST
FROM Bronze.crm_cust_info)T WHERE FLAG_LAST=1 and cst_id is NOT NULL;

select * from SILVER.crm_cust_info;
