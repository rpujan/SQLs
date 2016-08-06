declare @tb table(str1 varchar(150))
insert into @tb (str1 ) values

('1168 - ABCD Street'),
('1256 - EFGH Street'),
('Street1 - 1234'),
('Tenth - 45565'),
('Woods'),
('Minneapolis')

select stuff(str1,case when patindex('%[0-9]%',str1)<2 then 1 else patindex('%[ - ]%',str1) end
,case when patindex('%[0-9]%',str1)=0 then 0 when patindex('%[0-9]%',str1)=1 then patindex('%[A-Z]%',str1)-1 else len(str1) end,'') from @tb

-- detail
select
	--stuff(
    str1,
	case when patindex('%[0-9]%',str1)<2 then 1 
	     else patindex('%[ - ]%',str1) end
   ,case when patindex('%[0-9]%',str1)=0 then 0 
         when patindex('%[0-9]%',str1)=1 then patindex('%[A-Z]%',str1)-1 
		 else len(str1) end,''
   --)
from @tb

--select patindex('%[0-9]%','Woods')