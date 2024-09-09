USE RetailDB;
GO

-- Create Schemas
CREATE SCHEMA Sales;
GO
CREATE SCHEMA Production;
GO

-- Create Sequences
CREATE SEQUENCE Production.SuppliersIDs START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Production.ProductsIDs START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Sales.CustomersIDs START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Sales.OrdersIDs START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Sales.OrderDetailsIDs START WITH 1 INCREMENT BY 1;
GO

-- Suppliers Table
CREATE TABLE Production.Suppliers (
    SupplierID INT PRIMARY KEY DEFAULT NEXT VALUE FOR Production.SuppliersIDs,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);
GO

-- Products Table
CREATE TABLE Production.Products (
    ProductID INT PRIMARY KEY DEFAULT NEXT VALUE FOR Production.ProductsIDs,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    UnitPrice DECIMAL(10, 2) NOT NULL CHECK( UnitPrice > 0 ),
    StockQuantity INT NOT NULL CHECK( StockQuantity > 0 ),
	SupplierID INT,
	CONSTRAINT fk_supplier FOREIGN KEY (SupplierID) REFERENCES Production.Suppliers(SupplierID)
);
GO

-- Customers Table
CREATE TABLE Sales.Customers (
    CustomerID INT PRIMARY KEY DEFAULT NEXT VALUE FOR Sales.CustomersIDs,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
	Age INT CHECK( AGE >= 16 ),
	Phone VARCHAR(20),
    Email VARCHAR(100) NOT NULL UNIQUE,
	Gender VARCHAR(10) NOT NULL CHECK(Gender IN ('Male', 'Female')),
	City VARCHAR(50),
);
GO

-- Orders Table
CREATE TABLE Sales.Orders (
    OrderID INT PRIMARY KEY DEFAULT NEXT VALUE FOR Sales.OrdersIDs,
    OrderDate DATE NOT NULL CHECK( OrderDate < GETDATE() ),
    OrderStatus VARCHAR(20) CHECK( OrderStatus IN ('Processing','Shipped','Delivered','Cancelled') ),
	CustomerID INT NOT NULL,
	CONSTRAINT fk_customer FOREIGN KEY (CustomerID) REFERENCES Sales.Customers(CustomerID)
);
GO

-- OrderDetails Table
CREATE TABLE Sales.OrderDetails (
    OrderDetailID INT PRIMARY KEY DEFAULT NEXT VALUE FOR Sales.OrderDetailsIDs,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK( Quantity > 0 ),
	CONSTRAINT fk_order FOREIGN KEY (OrderID) REFERENCES Sales.Orders(OrderID),
    CONSTRAINT fk_product FOREIGN KEY (ProductID) REFERENCES Production.Products(ProductID)
);
GO

-- Drop Tables
/*
DROP TABLE IF EXISTS Sales.OrderDetails;
DROP TABLE IF EXISTS Sales.Orders;
DROP TABLE IF EXISTS Sales.Customers;
DROP TABLE IF EXISTS Production.Products;
DROP TABLE IF EXISTS Production.Suppliers;
*/

-- Drop Schemas
/*
DROP SCHEMA IF EXISTS Sales;
DROP SCHEMA IF EXISTS Production;
*/

-- Drop Sequences
/*
DROP SEQUENCE IF EXISTS Production.SuppliersIDs;
DROP SEQUENCE IF EXISTS Production.ProductsIDs;
DROP SEQUENCE IF EXISTS Sales.CustomersIDs;
DROP SEQUENCE IF EXISTS Sales.OrdersIDs;
DROP SEQUENCE IF EXISTS Sales.OrderDetailsIDs;
*/