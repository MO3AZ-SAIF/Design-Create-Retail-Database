USE RetailDB;
GO

INSERT INTO Sales.Customers (FirstName, LastName, Age, Phone, Email, Gender, City) VALUES 
('Moaaz', 'Saif', 20, '01156196874', 'moaaz.saif@gmail.com', 'Male', 'Giza');
SELECT * FROM Sales.Customers;
GO

UPDATE Sales.Customers SET Age = 21 WHERE CustomerID = 151;
SELECT * FROM Sales.Customers;
GO

DELETE FROM Sales.Customers WHERE CustomerID = 151;
SELECT * FROM Sales.Customers;
GO