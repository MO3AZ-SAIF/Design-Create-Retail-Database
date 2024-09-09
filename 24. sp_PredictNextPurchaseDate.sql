USE RetailDB;
GO

CREATE PROCEDURE sp_PredictNextPurchaseDate (@CustID AS INT) 
AS
BEGIN
	WITH PurchaseIntervals AS (
        SELECT 
            CustomerID,
            DATEDIFF(DAY, 
                LAG(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate),
                OrderDate) AS Interval
        FROM 
            Sales.Orders
        WHERE 
            CustomerID = @CustID
    ),

    AverageIntervals AS (
        SELECT 
            AVG(Interval) AS AvgInterval
        FROM 
            PurchaseIntervals
        WHERE 
            Interval IS NOT NULL
    )

    SELECT 
        c.CustomerID,
        c.FirstName,
        c.LastName,
        MAX(o.OrderDate) AS LastOrderDate,
        DATEADD(DAY, ai.AvgInterval, MAX(o.OrderDate)) AS PredictedNextPurchaseDate
    FROM 
        Sales.Customers c
    JOIN 
        Sales.Orders o ON c.CustomerID = o.CustomerID
    CROSS JOIN 
        AverageIntervals ai
    WHERE 
        c.CustomerID = @CustID
    GROUP BY 
        c.CustomerID, c.FirstName, c.LastName, ai.AvgInterval;
END;
GO

EXEC sp_PredictNextPurchaseDate @CustID = 25;
GO

-- Drop the stored procedure
/*
DROP PROCEDURE IF EXISTS sp_PredictNextPurchaseDate;
*/
