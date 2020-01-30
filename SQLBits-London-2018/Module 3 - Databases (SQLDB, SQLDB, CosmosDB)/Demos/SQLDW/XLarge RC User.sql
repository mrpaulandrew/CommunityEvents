CREATE LOGIN XLargeResourceClass WITH PASSWORD = '';

CREATE USER XLargeResourceClass for LOGIN XLargeResourceClass;

GRANT CONTROL ON DATABASE::sqldwdemo01 to XLargeResourceClass;

EXEC sp_addrolemember 'xlargerc', 'XLargeResourceClass'