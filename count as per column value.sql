/*
* count as per column value
*/

declare @test table (col1 char(1), volume int)
Insert into @test values('A',22),('B',28),('C',1),('E',3),('D',4)

select * from @test


select case when col1 not in ('A','B') then 'Other' else col1 end as col1, sum(volume) as volume from @test
group by case when col1 not in ('A','B') then 'Other' else col1 end

--SELECT col1 ,volume FROM @test WHERE col1 in ('A','B')
--UNION ALL
--SELECT distinct 'Others', sum(volume) OVER () FROM @test WHERE col1 not in ('A','B')