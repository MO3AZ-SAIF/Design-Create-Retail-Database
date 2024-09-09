USE RetailDB;
GO

-- CTE to calculate total amount for each order
WITH OrderTotalAmountCTE AS (
    SELECT o.OrderID, o.OrderDate , o.OrderStatus , o.CustomerID, 
		   SUM(od.Quantity * p.UnitPrice) AS TotalAmount
    FROM Sales.Orders o
    INNER JOIN Sales.OrderDetails od ON o.OrderID = od.OrderID
    INNER JOIN Production.Products p ON od.ProductID = p.ProductID
    GROUP BY o.OrderID ,o.OrderDate , o.OrderStatus , o.CustomerID
)
SELECT * FROM OrderTotalAmountCTE;


-- CTE to calculate total sales per category
WITH CategorySalesCTE AS (
    SELECT p.Category , SUM(od.Quantity * p.UnitPrice) AS TotalSales
    FROM Sales.OrderDetails od
    INNER JOIN Production.Products p ON od.ProductID = p.ProductID
    GROUP BY p.Category
)
SELECT * FROM CategorySalesCTE ORDER BY TotalSales DESC;