--CREATE VIEW Gold.Customer_Dim AS 
--USE DataWarehouse;
SELECT 
ROW_NUMBER() OVER(ORDER BY cst_id) AS Customer_Key,
ci.cst_id AS Customer_Id,
ci.cst_key AS Customer_Number ,
ci.cst_firstname AS Customer_First_Name,
ci.cst_lastname AS Customer_Last_Name,
la.CNTRY AS Country,
ci.cst_marital_status AS Marital_Status,
CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
ELSE COALESCE(ca.GEN,'n/a')
END AS Gender,
ca.BDATE AS Birthday_Date,
ci.cst_create_date AS Customer_Creation_Date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_CUST_AZ12 ca
ON ci.cst_key = ca.CID
LEFT JOIN silver.erp_LOC_A101 la
ON ci.cst_key = la.CID;


--CREATE VIEW Gold.ProductDim AS
SELECT 
ROW_NUMBER() OVER(ORDER BY prd_id , prd_start_dt) AS Product_Number,
p.prd_id AS Product_Id,
p.prd_key AS Product_Key,
p.prd_nm AS Product_Name,
p.cat_id AS Category_Id,
pc.CAT AS Category,
pc.SUBCAT AS SubCategory,
pc.MAINTENANCE AS Maintenance,
p.prd_cost AS Product_Cost,
p.prd_line AS Product_Line,
p.prd_start_dt AS Start_Date,
p.created_at AS Created_At
FROM silver.crm_prd_info p
LEFT JOIN silver.erp_PX_CAT_G1V2 pc 
ON p.cat_id = pc.ID
WHERE p.prd_end_dt IS NULL;



CREATE VIEW Gold.SalesFact AS 
SELECT
s.sls_ord_num AS Order_Number,
pd.Product_Number,
c.Customer_Key,
s.sls_order_dt AS Order_Date,
s.sls_ship_dt AS Ship_Date,
s.sls_due_dt AS Due_Date,
s.sls_sales AS Sales_Amount,
s.sls_quantity AS Quantity,
s.sls_price AS Price
FROM silver.crm_sales_details s
LEFT JOIN Gold.ProductDim pd
ON s.sls_prd_key = pd.Product_Key
LEFT JOIN Gold.Customer_Dim c
ON s.sls_cust_id = c.Customer_Id;
