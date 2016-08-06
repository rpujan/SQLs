DECLARE @chains TABLE (chainid int, ChainName nvarchar(100))
insert into @chains VALUES (1, 'Chain 1')
insert into @chains VALUES (2, 'Chain 2')
insert into @chains VALUES (3, 'Chain 3')
insert into @chains VALUES (4, 'Chain 4')

DECLARE @stores TABLE (ChainName nvarchar(100), StoreName nvarchar(100))
insert into @stores VALUES ('Chain 1', 'Store 1')
insert into @stores VALUES ('Chain 1', 'Store 2')
insert into @stores VALUES ('Chain 4', 'Store 3')
insert into @stores VALUES ('Chain 4', 'Store 4')


Select Distinct c.ChainName,
  (Select Stuff(
    (Select Distinct ',' + s.StoreName From @Stores s Where c.ChainName = s.ChainName Order By ',' + s.StoreName 
	For XML Path(''),Type)
    .value('text()[1]','nvarchar(max)'),1,1,'')) As StoreNames
From @Chains c;