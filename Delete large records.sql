-- SQL delete large number of records from a table
-- MSSQL select into table create for test
USE tempdb;
SELECT *
INTO   SOD
FROM   AdventureWorks2008.Sales.SalesOrderDetail
GO
--(121317 row(s) affected)
 
-- T-SQL delete loop - delete in segments - delete 2004 records
-- SQL table delete without blocking
WHILE (2 > 1)
  BEGIN
    DELETE TOP ( 10000 ) FROM SOD
    WHERE       YEAR(ModifiedDate) = 2004
    IF @@ROWCOUNT = 0  -- no more to delete
      BREAK;
    -- 1 second delay loop to allow other processes to "jump in"
    WAITFOR delay '00:00:01'
  END
GO
 
/* Messages
(10000 row(s) affected)
 
(10000 row(s) affected)
 
(10000 row(s) affected)
 
(10000 row(s) affected)
 
(5576 row(s) affected)
 
(0 row(s) affected)
*/
SELECT COUNT(* )
FROM   SOD
GO
-- 75741
 
-- Cleanup
DROP TABLE SOD

GO

------------