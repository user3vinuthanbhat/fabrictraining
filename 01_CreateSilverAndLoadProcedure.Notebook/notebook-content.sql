-- Fabric notebook source

-- METADATA ********************

-- META {
-- META   "kernel_info": {
-- META     "name": "synapse_pyspark"
-- META   },
-- META   "dependencies": {}
-- META }

-- CELL ********************

CREATE SCHEMA Silver;



-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }

-- CELL ********************

CREATE TABLE Silver.bronze_sales
(
    order_id INT,
    order_date DATE,
    customer VARCHAR(8000),
    amount INT,
    CreatedDateTS DATETIME2(0)
);

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }

-- CELL ********************

DROP PROCEDURE IF EXISTS dbo.usp_LoadBronzeToSilver;

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }

-- CELL ********************

CREATE PROCEDURE dbo.usp_LoadBronzeToSilver
AS
BEGIN
    TRUNCATE TABLE Silver.bronze_sales;

    INSERT INTO Silver.bronze_sales
        (order_id, order_date, customer, amount, CreatedDateTS)
    SELECT
        order_id,
        order_date,
        customer,
        amount,
        CreatedDateTS
    FROM Sales.Bronze.bronze_sales;
END;

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }
