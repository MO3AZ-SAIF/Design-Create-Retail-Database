USE RetailDB;
GO

CREATE VIEW vw_ActualProfitSuppliers AS
SELECT
	s.SupplierID,
	s.SupplierName,
	s.ContactName,
	SUM(od.Quantity*p.UnitPrice) AS TotalProfit
FROM	
	Production.Suppliers s
LEFT JOIN
	Production.Products p ON s.SupplierID = p.SupplierID
INNER JOIN
	Sales.OrderDetails od ON od.ProductID = p.ProductID
GROUP BY s.SupplierID,
		 s.SupplierName,
		 s.ContactName;
GO
SELECT * FROM vw_ActualProfitSuppliers;
GO

-- Drop View
/*
DROP VIEW IF EXISTS vw_ActualProfitSuppliers;
*/