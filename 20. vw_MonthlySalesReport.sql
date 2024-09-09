USE RetailDB;
GO

CREATE VIEW vw_MonthlySalesSummary AS
SELECT 
    DATEPART(MONTH, o.OrderDate) AS Month,
    DATEPART(YEAR, o.OrderDate) AS Year,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
	COUNT(DISTINCT c.CustomerID) AS CustomersNum,
    CAST(SUM(od.Quantity * p.UnitPrice) AS DECIMAL(10,2)) AS TotalSales,
    CAST(AVG(od.Quantity * p.UnitPrice) AS DECIMAL(10,2)) AS AverageOrderValue
FROM 
    Sales.Orders o
JOIN 
    Sales.OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Production.Products p ON od.ProductID = p.ProductID
JOIN 
	Sales.Customers c ON c.CustomerID = o.CustomerID
GROUP BY 
    DATEPART(YEAR, o.OrderDate), DATEPART(MONTH, o.OrderDate);
GO
SELECT * FROM  vw_MonthlySalesSummary;
GO

-- Drop View
/*
DROP VIEW IF EXISTS vw_MonthlySalesSummary;
*/