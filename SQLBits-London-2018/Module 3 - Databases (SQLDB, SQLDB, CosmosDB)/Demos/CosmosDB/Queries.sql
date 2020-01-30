SELECT COUNT(0) FROM c

SELECT * FROM c ORDER BY c.bk ASC

SELECT * FROM c ORDER BY c.bk DESC

SELECT * FROM c WHERE c.bk = "3"

SELECT * FROM c WHERE c.address.county = "Shropshire"

SELECT * FROM c WHERE c.address.company LIKE "SQL%"

SELECT * FROM c WHERE LEFT(c.address.company,3) = "SQL"


/*
https://docs.microsoft.com/en-us/azure/cosmos-db/sql-api-sql-query-reference
*/