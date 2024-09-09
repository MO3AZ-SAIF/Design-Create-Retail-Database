USE MASTER;
GO

-- Create database if it not exists
IF DB_ID('RetailDB') IS NULL
BEGIN
    CREATE DATABASE RetailDB;
END
ELSE
BEGIN
    PRINT 'Database "RetailDB" already exists.';
END;
GO

-- Drop database if it exists
IF DB_ID('RetailDB') IS NOT NULL
BEGIN
	USE MASTER;
    DROP DATABASE RetailDB;
END
ELSE
BEGIN
    PRINT 'Database "RetailDB" does not exist, so it cannot be dropped.';
END;
GO
