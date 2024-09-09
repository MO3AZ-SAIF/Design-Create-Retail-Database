USE RetailDB;
GO

CREATE TYPE OrderDtl AS TABLE ( ProductID INT, Quantity INT);
GO

CREATE PROCEDURE sp_InsertNewOrder
    (@OrderDate DATE, @CustomerID INT,@OrderDetails OrderDtl READONLY)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @OrderID INT = NEXT VALUE FOR Sales.OrdersIDs;

        INSERT INTO Sales.Orders (OrderID, OrderDate, OrderStatus, CustomerID)
        VALUES (@OrderID, @OrderDate, 'Processing', @CustomerID);

        INSERT INTO Sales.OrderDetails (OrderID, ProductID, Quantity)
        SELECT @OrderID, ProductID, Quantity
        FROM @OrderDetails;

        UPDATE p
        SET StockQuantity = StockQuantity - od.Quantity
        FROM Production.Products p
        INNER JOIN @OrderDetails od ON p.ProductID = od.ProductID
        WHERE p.ProductID = od.ProductID AND StockQuantity >= od.Quantity;

        IF EXISTS (
            SELECT 1 FROM Production.Products p
            INNER JOIN @OrderDetails od 
			ON p.ProductID = od.ProductID
            WHERE StockQuantity < od.Quantity
        )
        BEGIN
            PRINT('Insufficient stock for one or more products.');
            ROLLBACK TRANSACTION;
            RETURN;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
		PRINT('Something is wrong!.');
    END CATCH
END;
GO

DECLARE @DetailValues OrderDtl;
INSERT INTO @DetailValues (ProductID, Quantity) VALUES (5, 1), (18, 2);
EXEC sp_InsertNewOrder 
    @OrderDate = '2024-06-15',
    @CustomerID = 56,
    @OrderDetails = @DetailValues;
GO

-- Drop the stored procedure
/*
DROP PROCEDURE IF EXISTS sp_InsertNewOrder;
*/