CREATE VIEW gold.dim_product AS 
SELECT 
ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt,pn.prd_key) AS product_key,
pn.prd_id AS product_id,
pn.prd_key AS product_number,
pn.prd_nm AS product_name,
pn.cat_id AS category_id,
pc.cat AS category,
pc.subcat AS subcategory,
pc.maintenance AS maintenance,
pn.prd_cost AS cost,
pn.prd_line AS product_line,
pn.prd_start_dt AS start_date
from silver.crm_prod_info pn 
LEFT JOIN SILVER.erp_px_cat_g1v2 PC
ON pn.cat_id=pc.id
where prd_end_dt is null -- filter out all historical data;
