/*
* https://social.msdn.microsoft.com/Forums/sqlserver/en-US/f15c6e47-ce54-4935-b449-453157a3337f/two-row-serial-number-date-compare-and-take-more-then-5-hours-between-two-rows?forum=transactsql
* Two Row Serial number date compare and take more then 5 hours between two rows
*/
declare @table as table (tld_tripno varchar(30),id int ,descr varchar(50),tld_location varchar(10), dt datetime)

insert into @table values ('TL\M3\00424\2015',1,'Gate In','M3','20150101 12:00')
insert into @table values ('TL\M3\00424\2015',2,'Start Loading','M3','20150101 14:00')
insert into @table values ('TL\M3\00424\2015',3,'Finish Loading','M3','20150101 21:36:30:15')
insert into @table values ('TL\M3\00424\2015',4,'Gate out','M3','20150101 23:24:26:10')
insert into @table values ('TL\M3\00424\2015',5,'Gate In','14045','20150101 18:00')
insert into @table values ('TL\M3\00424\2015',6,'Gate out','14045','20150101 22:00')

select * from @table

;
WITH CTE1
AS
(
SELECT tld_tripno,descr,tld_location,MAX(DT) AS [Finish Loading]  FROM @table
WHERE descr='Finish Loading'
GROUP BY tld_tripno,descr,tld_location
),
CTE2
AS
(
SELECT tld_tripno,descr,tld_location,MAX(DT)AS [Gate out]  FROM @table
WHERE descr='Gate out'
GROUP BY tld_tripno,descr,tld_location

)

SELECT cte1.tld_tripno,cte1.tld_location,[Finish Loading],[Gate out] ,datediff(HOUR,[Finish Loading],[Gate out])
,cast((datediff (HOUR, [Finish Loading],[Gate out])) as varchar(200)) + ':' +
 cast((datediff (HOUR, [Finish Loading],[Gate out])) * 60 -  DATEDIFF(minute,[Finish Loading],[Gate out])as varchar(100))
 FROM CTE1 inner join CTE2 on cte1.tld_tripno=cte2.tld_tripno and cte1.tld_location=cte2.tld_location
 
 /*
declare @t1 as datetime = '20150706 16:20:00:00'
declare @t2 as datetime = '20150706 17:00:00:00'
 
select cast(datediff(minute, @t1, @t2) / 60 as varchar(10)) + ':' +
       cast(datediff(minute, @t1, @t2) - datediff(minute, @t1, @t2) / 60 * 60 as varchar(10))

  
select cast(datediff(hour, @t1, @t2) as varchar(10)) + ':' +
        cast(datediff(hour, @t1, @t2) * 60 - datediff(minute, @t1, @t2) as varchar(10))
*/
        