-- =========================
-- STORED PROCEDURE: LOAD SILVER
-- Purpose: Transform and load data from bronze to silver layer
-- =========================
DROP PROCEDURE IF EXISTS silver_load;
DELIMITER $$
CREATE PROCEDURE silver_load()
BEGIN
    DECLARE start_time DATETIME;
    DECLARE end_time DATETIME;

    -- Load dim_product table
    SET start_time = NOW();
    TRUNCATE TABLE silver.dim_product;
    
    INSERT INTO dim_product (product_id, category)
    SELECT DISTINCT `Product ID`, Category
    FROM bronze.inventory_forecasting;

    SET end_time = NOW();
    SELECT CONCAT('Silver dim_product Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;

    -- Load dim_store table
    SET start_time = NOW();
    TRUNCATE TABLE silver.dim_store;
    
    INSERT INTO dim_store (store_id, region, store_id_region)
    SELECT DISTINCT `Store ID`, Region, CONCAT(`Store ID`, '_', Region)
    FROM bronze.inventory_forecasting;

    SET end_time = NOW();
    SELECT CONCAT('Silver dim_store Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;

    -- Load dim_date table
    SET start_time = NOW();
    TRUNCATE TABLE silver.dim_date;

    INSERT INTO dim_date (date, seasonality)
    SELECT DISTINCT Date, Seasonality
    FROM bronze.inventory_forecasting;
    
    SET end_time = NOW();
    SELECT CONCAT('Silver dim_date Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;

    -- Load fact_inventory table
    SET start_time = NOW();
    TRUNCATE TABLE silver.fact_inventory;

    INSERT INTO fact_inventory (
    date, product_id, store_id_region,
    inventory_level, units_sold, units_ordered,
    demand_forecast, price, discount, competitor_pricing,
    weather_condition, holiday_promotion
    )
    SELECT 
        f.Date,
        f.`Product ID`,
        CONCAT(f.`Store ID`, '_', f.Region),
        f.`Inventory Level`,
        f.`Units Sold`,
        f.`Units Ordered`,
        f.`Demand Forecast`,
        f.Price,
        f.Discount,
        f.`Competitor Pricing`,
        f.`Weather Condition`,
        f.`Holiday/Promotion`
    FROM inventoryproblems.inventory_forecasting f;

    SET end_time = NOW();
    SELECT CONCAT('Silver fact_inventory Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;

END $$
DELIMITER ;

CALL silver_load();
