USE RetailDB;
GO

CREATE VIEW vw_SlowSalesProducts AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    p.UnitPrice,
    p.StockQuantity,
    COALESCE(SUM(od.Quantity), 0) AS TotalSoldLastYear
FROM 
    Production.Products p
LEFT JOIN 
    Sales.OrderDetails od ON p.ProductID = od.ProductID
LEFT JOIN 
    Sales.Orders o ON od.OrderID = o.OrderID AND o.OrderDate >= DATEADD(YEAR, -1, GETDATE())
GROUP BY 
    p.ProductID, p.ProductName, p.Category, p.UnitPrice, p.StockQuantity
HAVING 
    COALESCE(SUM(od.Quantity), 0) < 15;
GO
SELECT * FROM  vw_SlowSalesProducts;
GO

-- Drop View
/*
DROP VIEW IF EXISTS vw_SlowSalesProducts;
*/