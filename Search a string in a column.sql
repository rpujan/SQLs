/*
* Search a string in a column which are enclosed by "_"
*/

declare @test as table (n varchar(30))

insert into @test values
('sql_2012'),
('ssis_msbi_'),
('ssrs_msbi'),
('ssasmsbi_')

select * from @test


select n, 
	case 
		when  n like '%[_]msbi[_]%' then 'yes' 
		else 'no' 
	end as type 
from @test