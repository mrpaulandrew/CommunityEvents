SELECT @@SERVERNAME
SELECT @@VERSION

----------------------------------------------------------------------------------

CREATE DATABASE [serverlesslakehouse];
USE [serverlesslakehouse];

----------------------------------------------------------------------------------

CREATE EXTERNAL DATA SOURCE lakeHouseStorage
WITH 
	( 
	LOCATION = 'https://synstore01.blob.core.windows.net/lakehouse/'
	);

----------------------------------------------------------------------------------

SELECT TOP 10
	*
FROM OPENROWSET
	(
    BULK '/tables/OrderHeader',
    DATA_SOURCE = 'lakeHouseStorage',
    FORMAT = 'delta'
	) AS ROWS;

----------------------------------------------------------------------------------

SELECT TOP 10
	*
FROM OPENROWSET
	(
    BULK '/tables/OrderDetailLines',
    DATA_SOURCE = 'lakeHouseStorage',
    FORMAT = 'delta'
	) AS ROWS;

----------------------------------------------------------------------------------

CREATE EXTERNAL TABLE OrderHeader
    (
	SalesOrderID DATETIME,
	SalesOrderDetailID INT,
	OrderQty INT,
	ProductID INT,
	UnitPrice FLOAT,
	UnitPriceDiscount FLOAT,
	LineTotal FLOAT,
	rowguid UNIQUEIDENTIFIER,
	ModifiedDate DATETIME
	)
    WITH 
	(
	FILE_FORMAT = delta,
	LOCATION = '/tables/OrderDetailLines',
    DATA_SOURCE = lakeHouseStorage
    ) 
	--FILE_FORMAT must be specified for HADOOP data source.
	--External table references 'FILE_FORMAT' that does not exist.

----------------------------------------------------------------------------------

CREATE OR ALTER VIEW OrderHeader AS SELECT * FROM OPENROWSET (BULK '/tables/OrderHeader',DATA_SOURCE = 'lakeHouseStorage',FORMAT = 'delta') AS ROWS;
CREATE  OR ALTER VIEW OrderDetailLines AS SELECT * FROM OPENROWSET (BULK '/tables/OrderDetailLines',DATA_SOURCE = 'lakeHouseStorage',FORMAT = 'delta') AS ROWS;

----------------------------------------------------------------------------------

--CREATE VIEW OrderAggregation AS
SELECT
    h.SalesOrderNumber,
    COUNT(l.SalesOrderDetailID) AS RecordCount
FROM
    dbo.OrderHeader h
    INNER JOIN dbo.OrderDetailLines l
        ON h.SalesOrderID = l.SalesOrderID
GROUP BY
    h.SalesOrderNumber
HAVING
	COUNT(l.SalesOrderDetailID) > 1;
	
----------------------------------------------------------------------------------

SELECT * FROM dbo.OrderAggregation