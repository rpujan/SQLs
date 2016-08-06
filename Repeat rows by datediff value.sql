/*
Repeat rows by datediff value
https://social.msdn.microsoft.com/Forums/sqlserver/en-US/8a5f5de5-6fa2-420e-bc0e-68d978479ef2/repeat-rows-by-datediff-value?forum=transactsql
*/

create table events (CustomerID int, ArrivedDateTime datetime, DepartDateTime datetime)
Insert into events values (1,'2016-01-01 00:32:00.000', '2016-01-01 01:15:00.000')
,(2, '2016-01-01 00:36:00.000', ' 2016-01-01 07:02:00.000')
,(3 ,'2016-01-01 00:41:00.000', ' 2016-01-01 01:49:00.000')
,(4,'2016-01-01 00:51:00.000', ' 2016-01-01 09:00:00.000')
,(5,'2016-01-01 00:58:00.000', ' 2016-01-01 09:10:00.000')
,(6,'2016-01-01 01:27:00.000', ' 2016-01-01 14:05:00.000')

/*
select * from events
select Cast(min(ArrivedDateTime)as date) from events
select Cast(Cast(min(ArrivedDateTime) as date) as datetime) from events 
select dateadd(hour,2,(select Cast(Cast(min(ArrivedDateTime) as date) as datetime))) from events
*/
;WITH  myDateCTE as
(
select dateadd(hour,n,(select Cast(Cast(min(ArrivedDateTime) as date) as datetime) 
from events)) dt 
from (values(0),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24) ) d(n)
 
)


select Cast(dt as Date) [Date], datepart(hour,dt)-1 [Hour],count(*) CustomersCnt 
from  events e left join myDateCTE c
 on c.dt between e.ArrivedDateTime and e.DepartDateTime  
Group by dt 
 
 
 Drop table events