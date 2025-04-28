CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
	    SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';
	
		PRINT '------------------------------------------------';
		PRINT 'Loading CRM TABLES';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting data into :bronze.crm_cust_info';
		BULK INSERT BRONZE.CRM_CUST_INFO
		FROM 'C:\Users\MeenaragaviPerumal\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR(50)) + 'SECONDS';
		PRINT '-------------------'

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prod_info';
		TRUNCATE TABLE bronze.crm_prod_info;

		PRINT '>> Inserting data into: bronze.crm_prod_info';
		BULK INSERT BRONZE.CRM_PROD_INFO
		FROM 'C:\Users\MeenaragaviPerumal\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR(50)) + 'SECONDS';
		PRINT '-------------------'

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
	
		PRINT '>> Inserting data into: bronze.crm_sales_details';
		BULK INSERT BRONZE.crm_sales_details
		FROM 'C:\Users\MeenaragaviPerumal\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR(50)) + 'SECONDS';
		PRINT '-------------------'

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting data into: bronze.erp_cust_az12';
		BULK INSERT BRONZE.erp_cust_az12
		FROM 'C:\Users\MeenaragaviPerumal\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR(50)) + 'SECONDS';
		PRINT '-------------------'

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
	
		PRINT '>> Inserting data into: bronze.erp_loc_a101';
		BULK INSERT BRONZE.erp_loc_a101
		FROM 'C:\Users\MeenaragaviPerumal\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR(50)) + 'SECONDS';
		PRINT '-------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting data into: bronze.erp_px_cat_g1v2';
		BULK INSERT BRONZE.erp_px_cat_g1v2
		FROM 'C:\Users\MeenaragaviPerumal\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR(50)) + ' SECONDS';
		PRINT '-------------------'
		SET @batch_end_time = GETDATE();
		
		PRINT '========================================================================';
		PRINT 'Bronze Layer is Loaded Successfully!';
		PRINT 'Complete Load Duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR(50)) + ' SECONDS';
		PRINT '========================================================================';
	END TRY
	BEGIN CATCH
	    PRINT '=====================================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST( ERROR_NUMBER() AS NVARCHAR(50) );
		PRINT 'ERROR MESSAGE' + CAST( ERROR_STATE() AS NVARCHAR(50) );
		PRINT '=====================================================================';
	END CATCH;
END;