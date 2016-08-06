/*
Totals for last two days
https://social.msdn.microsoft.com/Forums/sqlserver/en-US/eeec5c7e-5e65-447a-ac7e-98cc7fe8dc98/totals-for-last-two-days?forum=transactsql
*/

Declare @date table (myDate date);
declare @testDate date = current_timestamp;
declare @beginDate date = dateadd(day, -60, @testDate);

while @testDate > @beginDate
begin
 insert @date values (@testDate);
 set @testDate = DATEADD(day, -1, @testDate);
end

 declare @a table 
 (
 admits int,
 day date

 )


 insert into @a(admits,day)
 values(
30,'3/1/2016')
 insert into @a(admits,day)
 values( 20,  '3/1/2016')
 insert into @a(admits,day)
 values( 2,  '3/1/2016')
 insert into @a(admits,day)
 values(5, '3/2/2016')
 insert into @a(admits,day)
 values( 3,  '3/2/2016')
 insert into @a(admits,day)
 values( 6,  '3/3/2016')
 insert into @a(admits,day)
 values( 2,  '3/3/2016')
 insert into @a(admits,day)
 values(5, '3/4/2016')
 insert into @a(admits,day)
 values( 6,  '3/4/2016')
 insert into @a(admits,day)
 values(2, '3/5/2016')
 insert into @a(admits,day)
 values(1, '3/5/2016')
insert into @a(admits,day)
 values(2, '3/6/2016')

 Select * from @A

 select d.myDate, sum (admits) as numAdmits
 from @date d
 inner join @a a
 on a.day between dateadd (day, -2, d.myDate) and DATEADD(day, -1, d.myDate)
 group by d.myDate