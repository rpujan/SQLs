declare @table TABLE (rowid int, datevalue varchar(20))

insert into @table select 1, 'January-2013'
insert into @table select 2, 'February-2014'
insert into @table select 3, 'June-2012'

 

;with
Table2 as (
SELECT Month_value= case upper(left(datevalue, (charindex('-', datevalue)-1)))
         when 'JANUARY' then '1'
         when 'FEBRUARY' then '2'
         when 'MARCH' then '3'
         when 'APRIL' then '4'
         when 'MAY' then '5'
         when 'JUNE' then '6'
         when 'JULY' then '7'
         when 'AUG' then '8'
         when 'SEP' then '9'
         when 'OCT' then '10'
         when 'NOV' then '11'
         when 'DECEMBER' then '12' end,
        Year_value= right(datevalue, 4)
  from @table
)
SELECT Convert(date, (Month_value + '/1/' + Year_value), 101)
  from Table2;

