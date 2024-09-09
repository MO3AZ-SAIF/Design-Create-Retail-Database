USE RetailDB;
GO

CREATE VIEW vw_LowStockProducts AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    p.UnitPrice,
    p.StockQuantity
FROM 
    Production.Products p
WHERE 
    p.StockQuantity < 10;
GO
SELECT * FROM vw_LowStockProducts;
GO

-- Drop View
/*
DROP VIEW IF EXISTS vw_LowStockProducts;
*/
