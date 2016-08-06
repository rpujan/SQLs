/*
 * http://social.msdn.microsoft.com/Forums/sqlserver/en-US/7067c65a-b523-41b9-91ae-84eec79ff83a/pivot-report
 */
 
 CREATE TABLE PIVOTTEST(DBNAME VARCHAR(10),SIZE DECIMAL(5,1),DATES DATETIME)
INSERT INTO PIVOTTEST VALUES('DB1', 3.1, '1/1/2013')
INSERT INTO PIVOTTEST VALUES('DB2', 2.0, '1/1/2013')
INSERT INTO PIVOTTEST VALUES('DB1', 3.5, '2/1/2013')
INSERT INTO PIVOTTEST VALUES('DB2', 2.4, '2/1/2013')
INSERT INTO PIVOTTEST VALUES('DB1', 3.9, '3/1/2013')
INSERT INTO PIVOTTEST VALUES('DB2', 2.6, '3/1/2013')
select * from PIVOTTEST

------------------------------------------
DECLARE
    @cols nvarchar(max),
    @stmt nvarchar(max)
SELECT @cols = isnull(@cols + ', ', '') + '[' + CAST(T.DATES AS VARCHAR) + ']' FROM (SELECT distinct DATES FROM PIVOTTEST) as T
SELECT @stmt = '
    SELECT *
    FROM PIVOTTEST as T
        PIVOT 
        (
            max(T.SIZE)
            for T.DATES in (' + @cols + ')
        ) as P'
exec sp_executesql  @stmt = @stmt

DROP TABLE PIVOTTEST

/*
 * 
DBNAME	SIZE	DATES
DB1		3.1		2013-01-01 00:00:00.000
DB2		2.0		2013-01-01 00:00:00.000
DB1		3.5		2013-02-01 00:00:00.000
DB2		2.4		2013-02-01 00:00:00.000
DB1		3.9		2013-03-01 00:00:00.000
DB2		2.6		2013-03-01 00:00:00.000
 
DBNAME	Jan  1 2013 12:00AM		Feb  1 2013 12:00AM		Mar  1 2013 12:00AM
DB1		3.1						3.5						3.9
DB2		2.0						2.4						2.6
 * 
 */