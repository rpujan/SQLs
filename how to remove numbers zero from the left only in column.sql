/*
* how to remove numbers zero from the left only in column 
*/


declare @test as table (id int, numbercar char(8))

insert into @test values (1,'00122011'),(2,'00042010'),(3,'03102012')

select ID, numbercar, Cast(numbercar as int) numbercar, REPLACE(LTRIM(REPLACE(numbercar, '0', ' ')), ' ', '0') AS numbercar2
from @test


--select replace('00123045', '0', ' ')
--select ltrim(replace('00123045', '0', ' '))
--select replace(ltrim(replace('00123045', '0', ' ')),' ','0')


