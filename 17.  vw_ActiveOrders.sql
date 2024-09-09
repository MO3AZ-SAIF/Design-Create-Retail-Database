USE RetailDB;
GO

CREATE VIEW vw_ActiveOrders AS
SELECT 
    o.OrderID,
    o.OrderDate,
    o.OrderStatus,
    c.CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    SUM(od.Quantity * p.UnitPrice) AS TotalAmount
FROM 
    Sales.Orders o
JOIN 
    Sales.Customers c ON o.CustomerID = c.CustomerID
JOIN 
    Sales.OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Production.Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID,
		 o.OrderDate,
		 o.OrderStatus,
		 c.CustomerID,
         c.FirstName + ' ' + c.LastName
HAVING o.OrderStatus IN ('Processing', 'Shipped');
GO
SELECT * FROM vw_ActiveOrders;
GO

-- Drop View
/*
DROP VIEW IF EXISTS vw_ActiveOrders;
*/