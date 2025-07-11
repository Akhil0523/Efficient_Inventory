-- =========================
-- DATA QUALITY CHECKS: SILVER LAYER
-- Purpose: Validate data integrity in the silver layer
-- =========================
USE silver;

-- Sales Table Checks
-- Check for leading/trailing spaces
SELECT 'Sales' AS table_name, 'product_id' AS column_name, product_id AS value
FROM Sales WHERE LENGTH(product_id) != LENGTH(TRIM(product_id))
UNION ALL
SELECT 'Sales', 'store_id', store_id
FROM Sales WHERE LENGTH(store_id) != LENGTH(TRIM(store_id));

-- Check for NULLs
SELECT * FROM Sales WHERE
    product_id IS NULL OR
    store_id IS NULL OR
    Date IS NULL OR
    units_sold IS NULL OR
    units_ordered IS NULL OR
    demand_forecast IS NULL OR
    price IS NULL OR
    discount IS NULL;

-- Check for duplicates (business key: product_id, store_id, Date)
SELECT product_id, store_id, Date, COUNT(*) AS dup_count
FROM Sales
GROUP BY product_id, store_id, Date
HAVING dup_count > 1;

-- Warehouse Table Checks
-- Check for leading/trailing spaces
SELECT 'Warehouse' AS table_name, 'store_id' AS column_name, store_id AS value
FROM Warehouse WHERE LENGTH(store_id) != LENGTH(TRIM(store_id))
UNION ALL
SELECT 'Warehouse', 'product_id', product_id
FROM Warehouse WHERE LENGTH(product_id) != LENGTH(TRIM(product_id));

-- Check for NULLs
SELECT * FROM Warehouse WHERE
    date IS NULL OR
    store_id IS NULL OR
    product_id IS NULL OR
    inventory_level IS NULL;

-- Check for duplicates (business key: date, store_id, product_id)
SELECT date, store_id, product_id, COUNT(*) AS dup_count
FROM Warehouse
GROUP BY date, store_id, product_id
HAVING dup_count > 1;

-- Product Table Checks
-- Check for leading/trailing spaces
SELECT 'Product' AS table_name, 'product_id' AS column_name, product_id AS value
FROM Product WHERE LENGTH(product_id) != LENGTH(TRIM(product_id))
UNION ALL
SELECT 'Product', 'category', category
FROM Product WHERE LENGTH(category) != LENGTH(TRIM(category));

-- Check for NULLs
SELECT * FROM Product WHERE
    product_id IS NULL OR
    category IS NULL;

-- Check for duplicates (business key: product_id)
SELECT product_id, COUNT(*) AS dup_count
FROM Product
GROUP BY product_id
HAVING dup_count > 1;
