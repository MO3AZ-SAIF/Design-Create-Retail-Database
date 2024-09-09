USE RetailDB;
GO

INSERT INTO Sales.Orders (OrderDate, OrderStatus, CustomerID) VALUES 
('2024-07-10', 'Processing', 18);
SELECT * FROM Sales.Orders;
GO

UPDATE Sales.Orders SET OrderStatus = 'Cancelled' WHERE OrderID = 251;
SELECT * FROM Sales.Orders;
GO

DELETE FROM Sales.Orders WHERE OrderID = 251;
SELECT * FROM Sales.Orders;
GO