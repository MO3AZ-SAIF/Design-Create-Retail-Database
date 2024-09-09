USE RetailDB;
GO

CREATE PROCEDURE sp_CalculateTotalSalesForCustomer(@CustID AS INT)
AS
BEGIN
    SELECT 
		c.CustomerID, 
		c.FirstName, 
		c.LastName, 
		o.OrderStatus,
		SUM(od.Quantity) AS TotalProducts,
		SUM(p.UnitPrice * od.Quantity) AS TotalSales
    FROM 
		Sales.Customers c
    JOIN 
		Sales.Orders o ON c.CustomerID = o.CustomerID
    JOIN 
		Sales.OrderDetails od ON o.OrderID = od.OrderID
    JOIN 
		Production.Products p ON od.ProductID = p.ProductID
    WHERE 
		c.CustomerID = @CustID
    GROUP BY 
		c.CustomerID, c.FirstName, c.LastName , o.OrderStatus;
END;
GO

EXEC sp_CalculateTotalSalesForCustomer @CustID = 7;
GO 

-- Drop the stored procedure if needed
/*
DROP PROCEDURE IF EXISTS sp_CalculateTotalSalesForCustomer;
*/