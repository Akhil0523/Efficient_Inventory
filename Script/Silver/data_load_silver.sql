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

    -- Load Sales table
    SET start_time = NOW();
    TRUNCATE TABLE silver.Sales;
    INSERT INTO silver.Sales (Date, store_id, product_id, units_sold, units_ordered, demand_forecast, price, discount)
    SELECT Date, store_id, product_id, units_sold, units_ordered, demand_forecast, price, discount
    FROM bronze.inventory_forecasting;
    SET end_time = NOW();
    SELECT CONCAT('Silver Sales Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;

    -- Load Warehouse table
    SET start_time = NOW();
    TRUNCATE TABLE silver.Warehouse;
    INSERT INTO silver.Warehouse (date, store_id, product_id, inventory_level, weather_condition, holiday_promotion, region)
    SELECT DISTINCT date, store_id, product_id, inventory_level, weather_condition, holiday_promotion, region
    FROM bronze.inventory_forecasting;
    SET end_time = NOW();
    SELECT CONCAT('Silver Warehouse Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;

    -- Load Product table
    SET start_time = NOW();
    TRUNCATE TABLE silver.Product;
    INSERT INTO silver.Product (product_id, category, competitor_pricing, seasonality)
    SELECT DISTINCT product_id, category, competitor_pricing, seasonality
    FROM bronze.inventory_forecasting;
    SET end_time = NOW();
    SELECT CONCAT('Silver Product Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;
END $$
DELIMITER ;


CALL silver_load();
