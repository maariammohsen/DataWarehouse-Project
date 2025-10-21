--1) Creating DWH

--CREATE DATABASE DataWarehouse;

--USE DataWarehouse;

--2)Creating Schema for each Layer:

--GO
--CREATE SCHEMA Silver;

--GO
--CREATE SCHEMA Bronze;

--GO
--CREATE SCHEMA Gold;

--GO
--Creating Stored Procedure for Bronze Layer:
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
	--3) Creating Bronze Layer for CRM files:

	-- Creating Customer Info table:

	IF OBJECT_ID('Bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE Bronze.crm_cust_info;

	CREATE TABLE Bronze.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR (25),
	cst_firstname NVARCHAR (50),
	cst_lastname NVARCHAR (50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
	)

	TRUNCATE Bronze.crm_cust_info;

	BULK INSERT Bronze.crm_cust_info
	FROM 'D:\Python\projects\DWH Demo Project\Resources\datasets\source_crm\cust_info.CSV'
	WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',' ,
	TABLOCK
	);

	--Data Quality Queries

	SELECT * FROM Bronze.crm_cust_info;

	SELECT COUNT(*) FROM Bronze.crm_cust_info;



	-- Creating Product Info table:

	IF OBJECT_ID('Bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE Bronze.crm_prd_info;

	CREATE TABLE Bronze.crm_prd_info(
	prd_id INT,
	prd_key NVARCHAR (50),
	prd_nm NVARCHAR (100),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE
	)

	TRUNCATE Bronze.crm_prd_info;

	BULK INSERT Bronze.crm_prd_info
	FROM 'D:\Python\projects\DWH Demo Project\Resources\datasets\source_crm\prd_info.CSV'
	WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	)

	--Data Quality Queries

	SELECT * FROM Bronze.crm_prd_info;

	SELECT COUNT(*) FROM Bronze.crm_prd_info;



	--Creating Sales Details table:

	IF OBJECT_ID('Bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE Bronze.crm_sales_details;

	CREATE TABLE Bronze.crm_sales_details(
	sls_ord_num INT,
	sls_prd_key NVARCHAR (50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
	)

	ALTER TABLE Bronze.crm_sales_details
	ALTER COLUMN sls_ord_num NVARCHAR(50);

	TRUNCATE Bronze.crm_sales_details;

	BULK INSERT Bronze.crm_sales_details
	FROM 'D:\Python\projects\DWH Demo Project\Resources\datasets\source_crm\sales_details.CSV'
	WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	)

	--Data Quality Queries

	SELECT * FROM Bronze.crm_sales_details;

	SELECT COUNT(*) FROM Bronze.crm_sales_details;



	--4) Creating Bronze Layer for ERP files:

	--Creating Customer table:

	IF OBJECT_ID('Bronze.erp_CUST_AZ12', 'U') IS NOT NULL
	DROP TABLE Bronze.erp_CUST_AZ12;

	CREATE TABLE Bronze.erp_CUST_AZ12(
	CID NVARCHAR (50),
	BDATE DATE,
	GEN NVARCHAR (50)
	)

	TRUNCATE Bronze.erp_CUST_AZ12;

	BULK INSERT Bronze.erp_CUST_AZ12
	FROM 'D:\Python\projects\DWH Demo Project\Resources\datasets\source_erp\CUST_AZ12.csv'
	WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
	)

	--Data Quality Queries

	SELECT * FROM Bronze.erp_CUST_AZ12;

	SELECT COUNT(*) FROM Bronze.erp_CUST_AZ12;



	--Creating Location table:

	IF OBJECT_ID('Bronze.erp_LOC_A101', 'U') IS NOT NULL
	DROP TABLE Bronze.erp_LOC_A101;

	CREATE TABLE Bronze.erp_LOC_A101(
	CID NVARCHAR(50),
	CNTRY NVARCHAR(50)
	)

	TRUNCATE Bronze.erp_LOC_A101;

	BULK INSERT Bronze.erp_LOC_A101
	FROM 'D:\Python\projects\DWH Demo Project\Resources\datasets\source_erp\LOC_A101.csv'
	WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
	)

	--Data Quality Queries

	SELECT * FROM Bronze.erp_LOC_A101;

	SELECT COUNT(*) FROM Bronze.erp_LOC_A101;



	--Creating Category table:

	IF OBJECT_ID('Bronze.erp_PX_CAT_G1V2', 'U') IS NOT NULL
	DROP TABLE Bronze.erp_PX_CAT_G1V2;

	CREATE TABLE Bronze.erp_PX_CAT_G1V2(
	ID NVARCHAR(50),
	CAT NVARCHAR(50),
	SUBCAT NVARCHAR(50),
	MAINTENANCE NVARCHAR(50)
	)

	TRUNCATE Bronze.erp_PX_CAT_G1V2;

	BULK INSERT Bronze.erp_PX_CAT_G1V2
	FROM 'D:\Python\projects\DWH Demo Project\Resources\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	)

	--Data Quality Queries

	SELECT * FROM Bronze.erp_PX_CAT_G1V2;

	SELECT COUNT(*) FROM Bronze.erp_PX_CAT_G1V2;

END;