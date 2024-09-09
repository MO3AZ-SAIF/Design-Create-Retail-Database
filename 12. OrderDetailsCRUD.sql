USE RetailDB;
GO

INSERT INTO Sales.OrderDetails (OrderID, ProductID, Quantity) VALUES 
(85, 16, 2);
SELECT * FROM Sales.OrderDetails;
GO

UPDATE Sales.OrderDetails SET Quantity = 1 WHERE OrderDetailID = 321;
SELECT * FROM Sales.OrderDetails;
GO

DELETE FROM Sales.OrderDetails WHERE OrderDetailID = 321;
SELECT * FROM Sales.OrderDetails;
GO