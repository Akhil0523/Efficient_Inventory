-- =========================
-- TABLE CREATION: SILVER LAYER
-- Purpose: Create cleaned and structured tables in the silver layer for intermediate processing
-- =========================
USE silver;

CREATE TABLE dim_product (
    product_id VARCHAR(20) PRIMARY KEY,
    category VARCHAR(50),
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE dim_store (
    store_id VARCHAR(20),
    region VARCHAR(50),
    store_id_region VARCHAR(100) PRIMARY KEY,
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE dim_date (
    date DATE PRIMARY KEY,
    seasonality VARCHAR(20),
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE fact_inventory (
    date DATE,
    product_id VARCHAR(20),
    store_id_region VARCHAR(100),

    inventory_level INT,
    units_sold INT,
    units_ordered INT,
    demand_forecast INT,
    price DECIMAL(10,2),
    discount DECIMAL(5,2),
    competitor_pricing DECIMAL(10,2),
    weather_condition VARCHAR(50),
    holiday_promotion BOOLEAN,

    PRIMARY KEY (date, product_id, store_id_region),
    FOREIGN KEY (date) REFERENCES dim_date(date),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (store_id_region) REFERENCES dim_store(store_id_region),

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
