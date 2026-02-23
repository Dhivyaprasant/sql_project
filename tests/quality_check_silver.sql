/*
===========================================
DATA QUALITY CHECKS
==========================================
this checks:
  duplicate or null primary keys
  unwanted spaces in string fields
  data standardization and consistency
  invalid date ranges and orders
*/
--==========================================
--checking 'silver.crm_cust_info'
--==========================================
--check for NULLs or duplicates in primary key
--expectation :no results
SELECT 
	 cst_id,
	 COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

--check for unwanted spaces
--Expectation: no results
SELECT cst_key
FROM silver.crm_cut_info
WHERE cst_key != TRIM(cst_key);
--==========================================
--checking 'silver.crm_prd_info'
--==========================================
--check for invalid dates

-- data standardization & consistency
--exception: no results
SELECT DISTINCT prd_line FROM silver.crm_prd_info;

--check for invalid date order
--exceptation: no results
SELECT * FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

--==========================================
--checking 'silver.crm_sales_info'
--==========================================
--check for invalid dates

SELECT 
	NULLIF(sls_due_dt,0) AS sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <=0
	OR LEN(sls_due_dt) != 8
	OR sls_due_dt > 10500101
	OR sls_due_dt < 19000101;
--check data consistency:sales = quantity * price
--expectation: no results
SELECT DISTINCT
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_info
WHERE sls_sales != sls_quantity * sls_price
	OR sls_sales IS NULL
	OR sls_quantity IS NULL
	OR sls_price IS NULL
	OR sls_price <=0
	OR sls_quantity <=0
	OR sls_sales <=0
ORDER BY sls_sales,sls_quantity,sls_price;




-- =========================================
-- Checking 'silver.erp_cust_az12'
--=================================
--identify out-of-range dates
--Exception: birthdates between 1924-01-01 and today
SELECT DISTINCT
	bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01'
	OR bdate > GETDATE();
--data standardization & consistency
SELECT DISTINCT
	gen
FROM silver.erp_cust_az12;






-- =========================================
-- Checking 'silver.erp_loc_a101'
--=================================
--data standardization

SELECT DISTINCT
	cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

-- =========================================
-- Checking 'silver.erp_px_cat_g1v2'
--=================================
--check for unwanted spaces
--exception: no results

SELECT * FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
	OR subcat != TRIM(subcat)
	OR  maintenance != TRIM(maintenance);

--data standardization & consistency

SELECT  DISTINCT
 	maintenance
FROM silver.erp_px_cat_g1v2;



  
  
