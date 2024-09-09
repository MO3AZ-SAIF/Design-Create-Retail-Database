USE RetailDB;
GO

-- Find the Most Expensive Product Ordered by Each Customer
SELECT o.CustomerID, p.ProductName, MAX(p.UnitPrice) AS MaxPrice
FROM Sales.Orders o
INNER JOIN Sales.OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Production.Products p ON od.ProductID = p.ProductID
WHERE p.UnitPrice = (
        SELECT MAX(p2.UnitPrice)
        FROM Sales.OrderDetails od2
        INNER JOIN Production.Products p2 
		ON od2.ProductID = p2.ProductID
        WHERE od2.OrderID IN ( 
			SELECT OrderID FROM Sales.Orders 
			WHERE CustomerID = o.CustomerID 
		)
	)
GROUP BY o.CustomerID, p.ProductName
ORDER BY MaxPrice DESC;


-- Find Suppliers Who Supply Products Not Ordered in the Last 2 Months
SELECT s.SupplierID, s.SupplierName , s.ContactName
FROM Production.Suppliers s
WHERE s.SupplierID IN ((
		SELECT p.SupplierID
        FROM  Production.Products p
        WHERE p.ProductID NOT IN (
                SELECT od.ProductID
                FROM Sales.OrderDetails od
                INNER JOIN Sales.Orders o 
				ON od.OrderID = o.OrderID
                WHERE o.OrderDate >= DATEADD(MONTH, -2, GETDATE())
				)
		)
);
