declare @table1 TABLE (id int, salary int)

insert into @table1 select 1, 100
insert into @table1 select 2, 110
insert into @table1 select 3, 150
insert into @table1 select 4, 125


declare @table2 TABLE (id int, salary int)

insert into @table2 select 1, 100
insert into @table2 select 2, 130
insert into @table2 select 3, 140
insert into @table2 select 4, 125


;with
Table3 as (
SELECT salary from @table1
union
SELECT salary from @table2
),
Table4 as (
SELECT salary,
       Seq= row_number() over (order by Salary desc)
  from Table3
)
SELECT salary
  from Table4
  where Seq between 2 and 3;