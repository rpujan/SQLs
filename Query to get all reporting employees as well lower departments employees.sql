/* https://social.msdn.microsoft.com/Forums/sqlserver/en-US/4113c320-1fb8-4d53-98b5-086d834ec6ed/query-to-get-all-reporting-employees-as-well-lower-departments-employees?forum=transactsql  */

Declare @org table
(
	org_id int,
	org_name Varchar(20),
	parent_org_id int
)
Insert into @org
Select 1,'Global',NULL
union all
Select 2,'ETL',1
union all
Select 3,'Java',1
union all
Select 4,'PTO',3
union all
Select 5,'PS',3

Declare @usr table
(
	usr_id int,
	usr_usrnm Varchar(20),
	org_id int
)
Insert into @usr
Select 1,'John',1
union all
Select 2,'Sam',2
union all
Select 3,'Maria',3
union all
Select 4,'David',4
union all
Select 5,'Fred',5

;with cte(org_id, org_name, parent_org_id, root_org_id) as
(
	select org_id, org_name, parent_org_id, parent_org_id
	from @org
	where parent_org_id is not null
	union all
	select b.org_id, b.org_name, b.parent_org_id, a.root_org_id
	from cte a
	join @org b on a.org_id = b.parent_org_id
)
select u.usr_usrnm AS manager, o.org_name AS orgname, r.usr_usrnm AS resourcename
from @usr u
join cte o on u.org_id = o.root_org_id
left join @usr r on o.org_id = r.org_id
order by u.usr_id