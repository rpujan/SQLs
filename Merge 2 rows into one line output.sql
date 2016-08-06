declare @Table1 TABLE ([SiteID] varchar(5), [SiteIncomeID] int, [EDateTime] datetime, [Income] varchar(8))

    
INSERT INTO @Table1 ([SiteID], [SiteIncomeID], [EDateTime], [Income])
VALUES
    ('L0020', 1572, '2015-05-19 05:00:26', '85.98'),
    ('L0020', 1573, '2015-05-20 05:00:28', '145.98'),
    ('L0101', 1574, '2015-05-19 22:07:43', '1,936.08'),
    ('L0101', 1575, '2015-05-20 22:14:00', '1,438.89'),
    ('L0102', 1576, '2015-05-20 21:16:26', '143.65'),
    ('L0102', 1577, '2015-05-19 21:48:06', '243.50')

select SiteID, 
	Min(EDateTime) as ReadStartDate,
	Max(EDateTime) as ReadEndDate,
	(select Min([Income]) from @Table1 t1 where t1.EDateTime = Min(t2.EDateTime) and t1.SiteID = t2.SiteID) as ReadStartIncome,
	(select Min([Income]) from @Table1 t1 where t1.EDateTime = Max(t2.EDateTime) and t1.SiteID = t2.SiteID) as ReadEndIncome
from @Table1 t2
group by SiteID

