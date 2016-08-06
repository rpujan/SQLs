-- https://social.msdn.microsoft.com/Forums/sqlserver/en-US/c042f108-97b2-48f2-b50e-b6c6c8e32026/grouping-syntax?forum=transactsql
-- Grouping syntax
declare @tmpDate TABLE  (ID INT IDENTITY(1,1), bDay INT NOT NULL, bMonth varchar(10) NOT NULL, bYear INT NOT NULL DEFAULT 1900) 
INSERT INTO @tmpDate ( bDay, bMonth, bYear )
VALUES  (1,'MAY', DEFAULT), 
		(5,'', DEFAULT), 
		(0,'MAY', DEFAULT),
		(5,'MAY',2015), 
		(5,'MAY',2015), 
		(3,'MAY',2015)


SELECT CASE WHEN bDay between 1 and 31 and len(bMonth) > 2 and bYear > 1900
THEN CAST(CAST(CAST(bDay AS VARCHAR(8))+ '. ' + bMonth + '. ' + CAST(bYear AS VARCHAR(8)) AS DATE) AS VARCHAR(10)) + ' 00:00:00'
ELSE NULL END FROM @tmpDate AS td
GROUP BY 
CASE WHEN bDay between 1 and 31 and len(bMonth) > 2 and bYear > 1900
THEN CAST(CAST(CAST(bDay AS VARCHAR(8))+ '. ' + bMonth + '. ' + CAST(bYear AS VARCHAR(8)) AS DATE) AS VARCHAR(10)) + ' 00:00:00'
ELSE NULL END 


