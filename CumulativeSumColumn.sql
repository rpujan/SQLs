declare @table TABLE (rowid int, rowvalue int)

insert into @table select 1, 4
insert into @table select 2, 8
insert into @table select 3, 9
insert into @table select 4, 3
insert into @table select 5, 2
insert into @table select 6, 6
insert into @table select 7, 7
insert into @table select 8, 1

 

select t1.rowid, t1.rowvalue, sum(t2.rowvalue)
from @table t1
join @table t2 on t2.rowid <= t1.rowid
group by t1.rowid, t1.rowvalue
order by t1.rowid