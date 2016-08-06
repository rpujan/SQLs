create table #Request (Request nvarchar(50), RequestCount int)

declare @columns nvarchar(max)
declare @result nvarchar(max)

insert into #Request(Request, RequestCount) Values ('Games', 5)
insert into #Request(Request, RequestCount) Values ('Prizes', 2)
insert into #Request(Request, RequestCount) Values ('Candy', 4)
insert into #Request(Request, RequestCount) Values ('Books', 1)

insert into #Request(Request, RequestCount) Values ('Games', 3)
insert into #Request(Request, RequestCount) Values ('Prizes', 5)
insert into #Request(Request, RequestCount) Values ('Candy', 2)
insert into #Request(Request, RequestCount) Values ('Books', 3)

insert into #Request(Request, RequestCount) Values ('Games', 2)
insert into #Request(Request, RequestCount) Values ('Prizes', 6)
insert into #Request(Request, RequestCount) Values ('Candy', 1)
insert into #Request(Request, RequestCount) Values ('Books', 3)

--select * from #Request

select @columns = stuff((select distinct '],[' + Request from #Request for xml path('')),1,2,'') + ']'

set @result = '
select ' + @columns + ' from (select request, requestcount from #Request) r
pivot (sum(requestcount) for Request in (' + @columns + ')) as pv'

select @result
execute sp_executesql @result

drop table #Request


