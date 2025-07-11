-- =========================
-- TABLE CREATION: SILVER LAYER
-- Purpose: Create cleaned and structured tables in the silver layer for intermediate processing
-- =========================
USE silver;

-- Sales table: Transactional data
DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales (
    sales_key INT AUTO_INCREMENT PRIMARY KEY,
    Date DATE,
    store_id VARCHAR(50),
    product_id VARCHAR(50),
    units_sold INT,
    units_ordered INT,
    demand_forecast INT,
    price FLOAT,
    discount FLOAT
);

-- Warehouse table: Inventory and contextual data
DROP TABLE IF EXISTS Warehouse;
CREATE TABLE Warehouse (
    warehouse_key INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    store_id VARCHAR(50),
    product_id VARCHAR(50),
    inventory_level INT,
    weather_condition VARCHAR(20),
    holiday_promotion BOOLEAN,
    region VARCHAR(50)
);

-- Product table: Product metadata
DROP TABLE IF EXISTS Product;
CREATE TABLE Product (
    product_key INT AUTO_INCREMENT PRIMARY KEY,
    product_id VARCHAR(50),
    category VARCHAR(50),
    competitor_pricing FLOAT,
    seasonality VARCHAR(20)
);
