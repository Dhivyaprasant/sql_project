CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @start_time DATETIME,@end_time DATETIME
	BEGIN TRY
		PRINT '================================';
		PRINT'loading bronze layer';
		PRINT '================================';

		PRINT'---------------------------------';
		PRINT'loading CRM tables';
		PRINT'---------------------------------';
		SET @start_time = GETDATE();
		PRINT'>> truncating data into table:bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\GUHANPRASANTH\Desktop\Cinema\projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> total  duration:' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		

	

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\GUHANPRASANTH\Desktop\Cinema\projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
		 FIRSTROW = 2,
		 FIELDTERMINATOR = ',',
		 TABLOCK
		);

		BULK INSERT bronze.sales_info
		FROM 'C:\Users\GUHANPRASANTH\Desktop\Cinema\projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
		 FIRSTROW = 2,
		 FIELDTERMINATOR = ',',
		 TABLOCK
		);
		PRINT'---------------------------------';
		PRINT'loading ERP tables';
		PRINT'---------------------------------';

		BULK INSERT  bronze.erp_cust_az12
		FROM 'C:\Users\GUHANPRASANTH\Desktop\Cinema\projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH(
		 FIRSTROW = 2,
		 FIELDTERMINATOR = ',',
		 TABLOCK
		);

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\GUHANPRASANTH\Desktop\Cinema\projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
		 FIRSTROW = 2,
		 FIELDTERMINATOR = ',',
		 TABLOCK
		);

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\GUHANPRASANTH\Desktop\Cinema\projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
		 FIRSTROW = 2,
		 FIELDTERMINATOR = ',',
		 TABLOCK
	);
	END TRY
	BEGIN CATCH
	PRINT'======================';
	PRINT'ERROE OCCURE DURING BRONZE LAYER';
	PRINT'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
	END CATCH
END
