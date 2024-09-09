USE RetailDB;
GO

INSERT INTO Production.Suppliers(SupplierName,ContactName,Phone,Email) VALUES 
('Giza Group', 'Moaaz Saif', '01156196874','info@gizagroup.com');
SELECT * FROM Production.Suppliers;
GO

UPDATE Production.Suppliers SET SupplierName = 'Giza Trading' WHERE SupplierID = 26;
SELECT * FROM Production.Suppliers;
GO

DELETE FROM Production.Suppliers WHERE SupplierID = 26;
SELECT * FROM Production.Suppliers;
GO