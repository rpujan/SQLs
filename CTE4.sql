DECLARE @Collections TABLE (CollectionID int)
declare @Items TABLE (ItemID int, ParentID int)

insert into @Collections values(101), (102), (103), (104), (105) 

insert into @Items values(201,101), (202,101), (203,101), (204,101), (205,101) 
insert into @Items values(211,102), (212,102), (213,102), (214,102), (215,102) 
insert into @Items values(221,103), (222,103), (223,103), (224,103), (225,103) 
insert into @Items values(231,104), (232,104), (233,104), (234,104), (235,104) 
insert into @Items values(241,105), (242,105), (243,105), (244,105), (245,105) 

insert into @Items values(301,201), (302,211), (303,221), (304,231), (305,241) 
insert into @Items values(311,202), (312,212), (313,222), (314,232), (315,242) 
insert into @Items values(321,203), (322,213), (323,223), (324,233), (325,243) 
insert into @Items values(331,204), (332,214), (333,224), (334,234), (335,244) 
insert into @Items values(341,205), (342,215), (343,225), (344,235), (345,245) 

;with cte as (
select i.ItemID, i.ParentID from @Collections c
join @Items i on c.CollectionID=i.ParentID
where c.CollectionID=102
)

select * from @Items i where i.ParentID in (select ItemID from cte)
union ALL
select * from cte
