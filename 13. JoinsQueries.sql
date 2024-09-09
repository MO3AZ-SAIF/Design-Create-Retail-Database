USE RetailDB;
GO

-- INNER JOIN
SELECT o.OrderID, o.OrderDate, o.OrderStatus, c.CustomerID,
	   c.FirstName + ' ' + c.LastName AS CustomerName
FROM Sales.Orders o INNER JOIN Sales.Customers c 
ON o.CustomerID = c.CustomerID;


-- FULL OUTER JOIN
SELECT s.SupplierID , s.SupplierName , s.ContactName,
	   p.ProductID , p.ProductName , p.StockQuantity
FROM Production.Suppliers s FULL OUTER JOIN Production.Products p 
ON s.SupplierID = p.SupplierID;


-- LEFT JOIN 
SELECT s.SupplierID , s.SupplierName , s.ContactName,
	   p.ProductID , p.ProductName , p.StockQuantity
FROM Production.Suppliers s LEFT JOIN Production.Products p 
ON s.SupplierID = p.SupplierID;


-- RIGHT JOIN
SELECT s.SupplierID , s.SupplierName , s.ContactName,
	   p.ProductID , p.ProductName , p.StockQuantity
FROM Production.Suppliers s RIGHT JOIN Production.Products p 
ON s.SupplierID = p.SupplierID;


-- SELF JOIN 
SELECT 
    c1.CustomerID AS CustomerID1, c1.FirstName + ' ' + c1.LastName AS Customer1, 
	c2.CustomerID AS CustomerID2, c2.FirstName + ' ' + c2.LastName AS Customer2, 
	c1.Age, c1.Gender, c1.City
FROM  Sales.Customers c1 INNER JOIN Sales.Customers c2 
ON c1.Age = c2.Age AND c1.Gender = c2.Gender AND 
   c1.City = c2.City AND c1.CustomerID <> c2.CustomerID;


-- CROSS JOIN
SELECT p.ProductID, p.ProductName, 
       s.SupplierID, s.SupplierName
FROM Production.Products p
CROSS JOIN  Production.Suppliers s;
