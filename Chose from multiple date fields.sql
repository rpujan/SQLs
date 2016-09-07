/*
https://social.msdn.microsoft.com/Forums/sqlserver/en-US/2ac12dda-1a99-4cf9-9c7a-0859f4f0bef4/chose-from-multiple-date-fields?forum=transactsql
*/

declare @table table
(
	accountid int,
	date1 datetime,
	date2 datetime,
	date3 datetime,
	date4 datetime
)
insert into @table
select 1,'2016-01-01','2015-12-31','2016-09-06','2016-09-10'
union all
select 2,'2015-01-01','2016-09-10','2015-12-31','2016-12-31'

SELECT * FROM @table t

declare @param datetime
set @param = '2016-09-06'

SELECT accountid
	, (
		SELECT MIN(t.dt) 
		FROM (VALUES 
				(date1)
				, (date2)
				, (date3)
				, (date4)
			) t(dt)
		WHERE t.dt >= @param
	) as [date]
FROM @table