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

GO