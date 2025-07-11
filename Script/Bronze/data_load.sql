-- =========================
-- STORED PROCEDURE: LOAD BRONZE FROM CSV
-- Purpose: Load raw data from a CSV file into the bronze layer
-- =========================
DROP PROCEDURE IF EXISTS bronze_load_from_csv;
DELIMITER $$
CREATE PROCEDURE bronze_load_from_csv(IN csv_path VARCHAR(255))
BEGIN
    DECLARE start_time DATETIME;
    DECLARE end_time DATETIME;

    SET start_time = NOW();
    TRUNCATE TABLE bronze.inventory_forecasting;

    SET @sql = CONCAT(
        'LOAD DATA LOCAL INFILE \'', csv_path, '\' ',
        'INTO TABLE bronze.inventory_forecasting ',
        'FIELDS TERMINATED BY \',\' ENCLOSED BY \'\"\' ',
        'LINES TERMINATED BY \'\\r\\n\' IGNORE 1 ROWS'
    );
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET end_time = NOW();
    SELECT CONCAT('Bronze Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;
END $$
DELIMITER ;

-- =========================
-- STORED PROCEDURE: LOAD BRONZE FROM TABLE
-- Purpose: Load raw data from an existing table into the bronze layer
-- =========================
DROP PROCEDURE IF EXISTS bronze_load_from_table;
DELIMITER $$
CREATE PROCEDURE bronze_load_from_table()
BEGIN
    DECLARE start_time DATETIME;
    DECLARE end_time DATETIME;

    SET start_time = NOW();
    TRUNCATE TABLE bronze.inventory_forecasting;
    INSERT INTO bronze.inventory_forecasting
    SELECT * FROM inventory.inventory_forecasting;
    SET end_time = NOW();
    SELECT CONCAT('Bronze Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS msg;
END $$
DELIMITER ;

CALL bronze_load_from_table();
