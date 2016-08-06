/* https://social.msdn.microsoft.com/Forums/sqlserver/en-US/0c70ed08-408d-452b-a2b9-6005ea00bb0e/creating-a-hierarchical-query-only-with-2-column-in-mssql-2012?forum=transactsql  */

CREATE TABLE #tmp([CURRENT Process ID] INT,[Previous Process ID] INT)
DECLARE @CurrentProcessID INT
SET @CurrentProcessID=1088
INSERT INTO #tmp([CURRENT Process ID] ,[Previous Process ID] )
SELECT 1088,1081 UNION
SELECT 1081,1074 UNION
SELECT 1074,1070 UNION
SELECT 1075,1073 UNION
SELECT 1070,1065 UNION
SELECT 1073,1064 UNION
SELECT 1064,1063 UNION
SELECT 1065,1062 UNION 
SELECT 1045,NULL 

SELECT * FROM #tmp

;WITH cte
AS
(
	SELECT [CURRENT Process ID],[Previous Process ID],1 AS [LEVEL] FROM #tmp WHERE [CURRENT Process ID]=@CurrentProcessID
	UNION ALL
	SELECT t.[Current Process ID],t.[Previous Process ID],c.[Level]+1 AS [LEVEL] FROM #tmp t
	INNER JOIN cte c ON c.[Previous Process ID]=t.[Current Process ID]
	
)

SELECT * FROM cte
DROP TABLE #tmp