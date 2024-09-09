USE RetailDB;
GO

CREATE PROCEDURE sp_RestockLowInventoryProducts (@RestockLevel AS INT)
AS
BEGIN
    UPDATE Production.Products
    SET StockQuantity = @RestockLevel
    WHERE StockQuantity < @RestockLevel;

    SELECT ProductID, ProductName, StockQuantity
    FROM Production.Products
    WHERE StockQuantity = @RestockLevel;
END;
GO

EXEC sp_RestockLowInventoryProducts @RestockLevel = 15;
GO

-- Drop the stored procedure if needed
/*
DROP PROCEDURE IF EXISTS sp_RestockLowInventoryProducts;
*/