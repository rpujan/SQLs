DECLARE @Trans TABLE (Account_ID [int] NULL,	Account_Name VARCHAR(10), Year_Quarter VARCHAR(8))


;WITH CTE_QTR
AS
(
  select 'Q1' AS QTR union all
  select 'Q2' AS QTR union all
  select 'Q3' AS QTR union all
  select 'Q4' AS QTR  
),
CTE_Year
AS
(
 SELECT YEAR(GETDATE()) AS Yr UNION all
 SELECT YEAR(GETDATE()) -1 AS Yr UNION all
 SELECT YEAR(GETDATE()) -2 AS Yr UNION all
 SELECT YEAR(GETDATE())  -3 AS Yr 
)       


INSERT INTO @Trans(Account_ID, Account_Name, Year_Quarter) 
SELECT Account_ID,Account_Name,CAST(Yr AS CHAR(4)) + QTR  AS Year_Quarter
FROM
(
SELECT 1 AS Account_ID, 'COGS'  as Account_Name
UNION ALL 
SELECT 2, 'Sales'
) Temp
cross join CTE_Year
cross join CTE_QTR
SELECT * FROM @Trans
ORDER BY 1,2,3 DESC