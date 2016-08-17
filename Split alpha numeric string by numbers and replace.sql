/* https://social.msdn.microsoft.com/Forums/sqlserver/en-US/18cfaf0a-9986-4d5a-b02b-90d0182e0889/split-alpha-numeric-string-by-numbers-and-replace?forum=transactsql */

Declare @s  varchar(1000)

Set @s = '1: Yes, No; 2: Yes, No'

declare @Student table (Id int, Name varchar(10))
insert into @Student (id, name) values (1,'John'), (2,'Alan');

;with cte as 
(
	select S.ID, S.Name, X.String as OriginalString, replace(' ' + X.String, ' ' + cast(S.Id as varchar(10)) + ':', ' ' + S.Name + ':') as ChangedString, cast(0 as int) as Lvl
	from @Student S 
	inner join  (select @s as String) X on ' ' + X.String like   '% ' + cast(S.Id as varchar(10)) + ':%'
	UNION ALL
	select S.ID, S.Name, cte.OriginalString, replace(' ' + cte.ChangedString, ' ' + cast(S.Id as varchar(10)) + ':', ' ' + S.Name +  ':') as ChangedString, cte.lvl + 1 as Lvl
	from cte inner join @Student S on ' ' + cte.ChangedString like   '% ' + cast(S.Id as varchar(10)) + ':%'
)

select top 1 OriginalString, ChangedString from cte order by lvl desc