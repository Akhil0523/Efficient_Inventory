-- =========================
-- DATA QUALITY CHECKS: GOLD LAYER
-- Purpose: Validate data integrity in the gold layer
-- =========================
USE gold;

-- Fact_Sales Checks
-- Check for NULLs in key columns
SELECT * FROM Fact_Sales WHERE
    product_key IS NULL OR
    warehouse_key IS NULL OR
    date_key IS NULL;

-- Check for invalid foreign keys
SELECT fs.* FROM Fact_Sales fs
LEFT JOIN Dim_Product dp ON fs.product_key = dp.product_key
WHERE dp.product_key IS NULL;

-- Check for duplicates (business key: product_key, warehouse_key, date_key)
SELECT product_key, warehouse_key, date_key, COUNT(*) AS dup_count
FROM Fact_Sales
GROUP BY product_key, warehouse_key, date_key
HAVING dup_count > 1;

-- Dim_Product Checks
-- Check for NULLs
SELECT * FROM Dim_Product WHERE product_id IS NULL;

-- Dim_Warehouse Checks
-- Check for NULLs
SELECT * FROM Dim_Warehouse WHERE store_id IS NULL;

-- Dim_Date Checks
-- Check for NULLs
SELECT * FROM Dim_Date WHERE date IS NULL;
