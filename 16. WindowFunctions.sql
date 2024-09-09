USE RetailDB;
GO

-- Ranking Products by Total Sales
SELECT 
    p.ProductID, 
	p.ProductName,
    SUM(od.Quantity * p.UnitPrice) AS TotalSales,
    DENSE_RANK() OVER (ORDER BY SUM(od.Quantity * p.UnitPrice) DESC) AS SalesRank
FROM Sales.OrderDetails od
INNER JOIN Production.Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName;


-- Determining Monthly Sales Trends
SELECT 
    YEAR(o.OrderDate) AS Year,
    MONTH(o.OrderDate) AS Month,
    SUM(od.Quantity * p.UnitPrice) AS TotalSales,
    COALESCE(LAG(SUM(od.Quantity * p.UnitPrice)) OVER (ORDER BY YEAR(o.OrderDate), MONTH(o.OrderDate)),0) AS PreviousMonthSales,
    SUM(od.Quantity * p.UnitPrice) - COALESCE(LAG(SUM(od.Quantity * p.UnitPrice)) OVER (ORDER BY YEAR(o.OrderDate), MONTH(o.OrderDate)), 0) AS SalesDifference
FROM Sales.Orders o
INNER JOIN Sales.OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Production.Products p ON od.ProductID = p.ProductID
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate);

