-- =========================
-- TABLE CREATION: GOLD LAYER
-- Purpose: Create final tables in the gold layer for analytics-ready data in a star schema
-- =========================
USE gold;

-- Fact table: Sales data with surrogate keys
DROP TABLE IF EXISTS Fact_Sales;
CREATE TABLE Fact_Sales (
    sales_key INT PRIMARY KEY AUTO_INCREMENT,
    product_key INT,
    warehouse_key INT,
    date_key VARCHAR(20),
    units_sold INT,
    units_ordered INT,
    demand_forecast INT,
    price FLOAT,
    discount FLOAT
);

-- Dimension table: Product details
DROP TABLE IF EXISTS Dim_Product;
CREATE TABLE Dim_Product (
    product_key INT PRIMARY KEY AUTO_INCREMENT,
    product_id VARCHAR(50),
    category VARCHAR(50),
    competitor_pricing FLOAT,
    seasonality VARCHAR(20)
);

-- Dimension table: Warehouse details
DROP TABLE IF EXISTS Dim_Warehouse;
CREATE TABLE Dim_Warehouse (
    warehouse_key INT PRIMARY KEY AUTO_INCREMENT,
    store_id VARCHAR(50),
    region VARCHAR(50),
    weather_condition VARCHAR(20),
    holiday_promotion BOOLEAN
);

-- Dimension table: Date with generated attributes
DROP TABLE IF EXISTS Dim_Date;
CREATE TABLE Dim_Date (
    date DATE PRIMARY KEY,
    year INT GENERATED ALWAYS AS (YEAR(date)) STORED,
    month INT GENERATED ALWAYS AS (MONTH(date)) STORED,
    day INT GENERATED ALWAYS AS (DAY(date)) STORED,
    weekday INT GENERATED ALWAYS AS (WEEKDAY(date)) STORED,
    date_key VARCHAR(20) GENERATED ALWAYS AS (CONCAT(YEAR(date), LPAD(MONTH(date), 2, '0'), LPAD(DAY(date), 2, '0'))) STORED
);
