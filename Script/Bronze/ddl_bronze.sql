-- =========================
-- TABLE CREATION: BRONZE LAYER
-- Purpose: Create the raw data table in the bronze layer to store unprocessed data
-- =========================
USE bronze;

DROP TABLE IF EXISTS inventory_forecasting;
CREATE TABLE inventory_forecasting (
    Date DATE,
    store_id VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    region VARCHAR(50),
    inventory_level INT,
    units_sold INT,
    units_ordered INT,
    demand_forecast INT,
    price FLOAT,
    discount FLOAT,
    weather_condition VARCHAR(20),
    holiday_promotion BOOLEAN,
    competitor_pricing FLOAT,
    seasonality VARCHAR(20)
);
