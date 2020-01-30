DROP DATABASE Demo;

CREATE DATABASE [Demo];

USE [Demo];

DROP SCHEMA [dataPool]
DROP SCHEMA [storagePool]

EXEC('CREATE SCHEMA dataPool;')
EXEC('CREATE SCHEMA storagePool;')

/*
  EXTERNAL FORMAT
*/

DROP EXTERNAL FILE FORMAT csv;

CREATE EXTERNAL FILE FORMAT csv
WITH 
    (
    FORMAT_TYPE = DelimitedText,
    FORMAT_OPTIONS (FIELD_TERMINATOR = ',',STRING_DELIMITER = '"')
    );

/*
  STORAGE POOL EXTERNAL TABLE
*/

DROP EXTERNAL TABLE [storagePool].[Address];

CREATE EXTERNAL TABLE [storagePool].[Address]
    (
    AddressID INT,
    AddressLine1 NVARCHAR(60),
    AddressLine2 NVARCHAR(60),
    City NVARCHAR(30),
    StateProvince NVARCHAR(50),
    CountryRegion NVARCHAR(50),
    PostalCode NVARCHAR(15),
    rowguid UNIQUEIDENTIFIER,
    ModifiedDate DATETIME
    )
    WITH
    (
    DATA_SOURCE = SqlStoragePool,
    LOCATION = '/RAW/AdventureWorks/Address.csv',
    FILE_FORMAT = csv
    );

SELECT TOP 100 * FROM [storagePool].[Address];


/*
  INTERNAL TABLE
*/

DROP TABLE [dbo].[Address];

CREATE TABLE [dbo].[Address]
    (
    AddressID INT,
    AddressLine1 NVARCHAR(60),
    AddressLine2 NVARCHAR(60),
    City NVARCHAR(30),
    StateProvince NVARCHAR(50),
    CountryRegion NVARCHAR(50),
    PostalCode NVARCHAR(15),
    rowguid UNIQUEIDENTIFIER,
    ModifiedDate DATETIME
    );

INSERT INTO [dbo].[Address] SELECT TOP 100 * FROM [storagePool].[Address];

SELECT * FROM [dbo].[Address] 

/*
  DATA POOL EXTERNAL TABLE
*/

DROP EXTERNAL TABLE [dataPool].[Address];

CREATE EXTERNAL TABLE [dataPool].[Address]
    (
    AddressID INT,
    AddressLine1 NVARCHAR(60),
    AddressLine2 NVARCHAR(60),
    City NVARCHAR(30),
    StateProvince NVARCHAR(50),
    CountryRegion NVARCHAR(50),
    PostalCode NVARCHAR(15),
    rowguid UNIQUEIDENTIFIER,
    ModifiedDate DATETIME
    )
    WITH
    (
        DATA_SOURCE = SqlDataPool,
        DISTRIBUTION = ROUND_ROBIN
    );

SELECT * FROM [dataPool].[Address];

/*
  INSERT INTO DATA POOL EXTERNAL TABLE
*/

DECLARE @db_name SYSNAME = 'Demo'
DECLARE @schema_name SYSNAME = 'dataPool'
DECLARE @table_name SYSNAME = 'Address'
DECLARE @query SYSNAME = 'SELECT * FROM storagePool.Address'

EXEC [dbo].[sp_data_pool_table_insert_data] @db_name, @schema_name, @table_name, @query;

