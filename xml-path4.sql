declare @t table (Dt date)

insert into @t
values('01-01-2013'),('01-02-2013'),('01-03-2013'),('01-04-2013'),('01-06-2013'),('01-08-2013'),
('02-05-2013'),('02-03-2013'),('02-02-2013'),('02-07-2013'),
('12-08-2013'),('12-09-2013'),('12-10-2013')


select DISTINCT SUBSTRING(DATENAME(mm,dt),1,3) as [MOnth] , STUFF((select ',' + datename(dd,dt)
	from @t  t
	where MONTH(t.dt) = MONTH(t1.dt)
	for XML path('')
	),1,1,'')
	Days
FROM @t t1
--ORDER BY 