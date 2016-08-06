/* https://social.msdn.microsoft.com/Forums/sqlserver/en-US/a118146f-a6b9-4551-8d13-8cce1747c7c5/sql-distinct-count-in-date-range?forum=transactsql */

-- SQL DISTINCT COUNT IN DATE RANGE

DECLARE @Summary TABLE (SummaryDate [DateTime] NULL,OrderNumber VARCHAR(10), TaskNumber VARCHAR(8))

INSERT INTO @Summary(SummaryDate,OrderNumber,TaskNumber) SELECT '2015-01-01 00:00:01', 'ABC123456', 'JOB001'
INSERT INTO @Summary(SummaryDate,OrderNumber,TaskNumber) SELECT '2015-01-01 00:01:02', 'ABC123456', 'JOB002'
INSERT INTO @Summary(SummaryDate,OrderNumber,TaskNumber) SELECT '2015-01-01 00:10:02', 'ABC123444', 'JOB001'
INSERT INTO @Summary(SummaryDate,OrderNumber,TaskNumber) SELECT '2015-01-01 10:12:59', 'ABC123456', 'JOB002'

INSERT INTO @Summary(SummaryDate,OrderNumber,TaskNumber) SELECT '2015-01-01 18:20:05', 'ABC888888', 'JOB001'
INSERT INTO @Summary(SummaryDate,OrderNumber,TaskNumber) SELECT '2015-01-01 20:22:42', 'ABC789456', 'JOB001'
INSERT INTO @Summary(SummaryDate,OrderNumber,TaskNumber) SELECT '2015-01-01 21:02:11', 'BBB121212', 'JOB002'

/*
I would like to write a single query that get the distinct count of order number in sepcific date range result as expected in three columns:
2015-01-01
task_number    | AM   | PM
JOB001         | 2    | 2
JOB002         | 1    | 1
*/

select 
	TaskNumber,
	count(distinct case when datepart(hour,SummaryDate)  >=0 and datepart(hour,SummaryDate) < 12 then OrderNumber end) as AM,
	count(distinct case when datepart(hour,SummaryDate) >=12 and datepart(hour,SummaryDate) < 24 then OrderNumber end) as PM
from @Summary
group by TaskNumber