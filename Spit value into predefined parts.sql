/*
I have a numeric value that needs to be split into unequal but predifined parts. The parts are always 13 periodes into the future.

Input: 1-1-2016  | 1.000

Output:
1-1-2016 |  (1/24)*1000
1-2-2016 |  (1/12)*1.000
1-3-2016 |  (1/12)*1.000
1-4-2016 |  (1/12)*1.000
etc
1-1-2017 |  (1/24)*1.000

The parts always number 13 months into the future and only the first and last part are 1/24, the rest is 1/12.
*/
DECLARE  @tbl AS TABLE ([dt] date, [Value] NUMERIC(10,5))
 
INSERT INTO @tbl VALUES ('2016-01-01',1.000);

;WITH base AS 
(
   SELECT [dt] , Value ,  1 AS n FROM @tbl
   UNION ALL
   SELECT  DATEADD(MONTH,1,dt), Value , n+1
   FROM base  WHERE n+1 <= 13
)
SELECT 
*,
CONVERT(VARCHAR(10), dt, 110)  +' | ' +  CASE WHEN n IN (1,13) THEN  '(1/24)' ELSE '(1/12)' END +'*' + CAST([Value] AS VARCHAR(10)) AS [Calculation_Text]
,  CASE WHEN n IN (1,13) THEN  (1.0000/24)*[Value] ELSE (1.0000/12)*[Value] END  AS [Calculated_Value]
 
  FROM base