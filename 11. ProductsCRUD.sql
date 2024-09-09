USE RetailDB;
GO

INSERT INTO Production.Products (ProductName,Category,UnitPrice,StockQuantity,SupplierID) VALUES 
('Dell G3 15-3500', 'Laptop', 23000.00,10,12);
SELECT * FROM Production.Products;
GO

UPDATE Production.Products SET UnitPrice = 25000.00 WHERE ProductID = 51;
SELECT * FROM Production.Products;
GO

DELETE FROM Production.Products WHERE ProductID = 51;
SELECT * FROM Production.Products;
GO