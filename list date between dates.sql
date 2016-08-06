DECLARE @Test TABLE (FromDate DATE,ToDate DATE)
insert into @Test VALUES ('2015-08-08','2015-08-11')
insert into @Test VALUES ('2015-08-13','2015-08-16')
insert into @Test VALUES ('2015-08-19','2015-08-21')

--select * from @Test

;With cteMinMax As
(Select Min(FromDate) As FromDate, Max(ToDate) As ToDate
From @Test),
cteCalendar As
(Select FromDate As dt
From cteMinMax
Union All
Select DateAdd(day, 1, c.dt) As dt
From cteCalendar c
Inner Join cteMinMax m On c.dt < m.ToDate)
Select Distinct c.dt As ResDate
From cteCalendar c
Inner Join @Test t On c.dt Between t.FromDate And t.ToDate
Order By c.dt;