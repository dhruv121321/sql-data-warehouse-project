/*
====================================================
Stored procedure to load data to bronze layer (source --> Bronze layer)
====================================================

Purpose: this script load data from the source (csv files) to the bronze schema
	- it truncates all the existing tables
	- Uses BULK INSERT command and loads all data from external source

Parameters: it accepts no parameters and does not return any values

USAGE: EXEC bronze.load_bronze

*/




CREATE OR ALTER PROCEDURE bronze.load_bronze as
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	set @start_time = GETDATE();
	BEGIN TRY
		
		PRINT '================================================';
		PRINT 'Loading Bronze layer';
		PRINT '================================================';
		PRINT '------------------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '------------------------------------------------';
		PRINT '************************************************';
		set @start_time = GETDATE();
		PRINT 'Truncating table: bronze.crm_cust_info';
		PRINT '************************************************';
		TRUNCATE TABLE bronze.crm_cust_info
		PRINT '************************************************';
		PRINT 'loading data into table: bronze.crm_cust_info';
		PRINT '************************************************';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\dhruv\OneDrive\Desktop\EDA\SQL_Prj_dataset\datasets\source_crm\cust_info.csv'
		WITH(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK --improves performance,can use parallelism

		);
		set @end_time = GETDATE();
		PRINT '>>Load duration:'+ cast(datediff(second,@start_time,@end_time) as NVARCHAR);
		PRINT '************************************************';
		PRINT 'Truncating table: bronze.crm_prd_info';
		PRINT '************************************************';
		set @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info

		PRINT '************************************************';
		PRINT 'loading data into table: bronze.crm_prd_info';
		PRINT '************************************************';

		BULK INSERT bronze.crm_prd_info
		from 'C:\Users\dhruv\OneDrive\Desktop\EDA\SQL_Prj_dataset\datasets\source_crm\prd_info.csv'
		WITH(
		firstrow =2,
		FIELDTERMINATOR=',',
		tablock

		);
		set @end_time = GETDATE();
		PRINT '>>Load duration:'+ cast(datediff(second,@start_time,@end_time) as NVARCHAR);
		PRINT '************************************************';
		PRINT 'Truncating table: bronze.crm_sales_details';
		PRINT '************************************************';
		set @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '************************************************';
		PRINT 'loading data into table: bronze.crm_sales_details';
		PRINT '************************************************';

		BULK INSERT bronze.crm_sales_details from
		'C:\Users\dhruv\OneDrive\Desktop\EDA\SQL_Prj_dataset\datasets\source_crm\sales_details.csv'
		with(
		firstrow=2,
		FIELDTERMINATOR=',',
		tablock


		);
		set @end_time = GETDATE();
		PRINT '>>Load duration:'+ cast(datediff(second,@start_time,@end_time) as NVARCHAR);
		PRINT '------------------------------------------------';
		PRINT 'Loaded CRM tables';
		PRINT '------------------------------------------------';
		PRINT '------------------------------------------------';
		PRINT 'Loading ERP tables';
		PRINT '------------------------------------------------';
		set @start_time = GETDATE();
		PRINT '************************************************';
		PRINT 'Truncating table: bronze.erp_cust_az12';
		PRINT '************************************************';
		TRUNCATE TABLE bronze.erp_cust_az12
		PRINT '************************************************';
		PRINT 'loading data into table: bronze.erp_cust_az12';
		PRINT '************************************************';
		BULK INSERT bronze.erp_cust_az12 from
		'C:\Users\dhruv\OneDrive\Desktop\EDA\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		set @end_time = GETDATE();
		PRINT '>>Load duration:'+ cast(datediff(second,@start_time,@end_time) as NVARCHAR);
		PRINT '************************************************';
		PRINT 'Truncating table: bronze.erp_loc_a101';
		PRINT '************************************************';
		set @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101
		PRINT '************************************************';
		PRINT 'loading data into table: bronze.erp_loc_a101';
		PRINT '************************************************';
		BULK INSERT bronze.erp_loc_a101 from
		'C:\Users\dhruv\OneDrive\Desktop\EDA\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
		with(
		firstrow=2,
		fieldterminator=','
		);
		set @end_time = GETDATE();
		PRINT '>>Load duration:'+ cast(datediff(second,@start_time,@end_time) as NVARCHAR);
		PRINT '************************************************';
		PRINT 'Truncating table: bronze.erp_px_cat_g1v2';
		PRINT '************************************************';
		set @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		PRINT '************************************************';
		PRINT 'loading data into table: bronze.erp_px_cat_g1v2 ';
		PRINT '************************************************';
		bulk insert bronze.erp_px_cat_g1v2 from
		'C:\Users\dhruv\OneDrive\Desktop\EDA\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
		with(
		firstrow=2,
		fieldterminator=',',
		TABLOCK
		);
		set @end_time = GETDATE();
		PRINT '>>Load duration:'+ cast(datediff(second,@start_time,@end_time) as NVARCHAR);
		PRINT '------------------------------------------------';
		PRINT 'Loaded ERP tables';
		PRINT '------------------------------------------------';
		PRINT '================================================';
		PRINT 'Loaded Bronze layer';
		PRINT '================================================';
	END TRY 
	BEGIN CATCH
	print '+++++++++++++++++++++++++++++++++++++++++++'
	print 'ERROR OCCURED'
	print 'error message:' + error_message()
	print '+++++++++++++++++++++++++++++++++++++++++++'
	END CATCH
	set @end_time = GETDATE();
	PRINT '>>Load duration of bronze:'+ cast(datediff(second,@start_time,@end_time) as NVARCHAR);
END

