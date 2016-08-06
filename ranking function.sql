/* https://social.msdn.microsoft.com/Forums/sqlserver/en-US/94757c26-7e4d-4a23-b5c5-de580d20581a/ranking-function?forum=transactsql */
Create table #temp 
(
eventdate date
,srid int
)
insert into #temp values('1/1/2015',1)
insert into #temp values('1/1/2015',1)
insert into #temp values('1/1/2015',5)
insert into #temp values('1/1/2016',4)
insert into #temp values('1/1/2016',8)
insert into #temp values('1/1/2016',4)

Select * from #temp
Select srid,eventdate, Case when count(*) Over(Partition by srid,eventdate) >1 then 0 else 1 end from #temp
drop table #temp