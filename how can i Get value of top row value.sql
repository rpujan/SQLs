/*
https://social.msdn.microsoft.com/Forums/sqlserver/en-US/4e022b73-da66-4b86-9f5c-78864b2ca900/how-can-i-get-value-of-top-row-value?forum=transactsql
*/
;with CTE As (

Select 1  as Id , 'Advance' as Name
union all 
Select 2  as Id , NULL as Name
union all 
Select 3  as Id , NULL as Name
union all 
Select 4  as Id , NULL as Name
union all 
Select 5  as Id , 'Payment' as Name
union all 
Select 6  as Id , NULL as Name
union all 
Select 7  as Id , NULL as Name
union all 
Select 8  as Id , 'Receipt' as Name
union all 
Select 9  as Id , NULL as Name
union all 
Select 10  as Id , NULL as Name
union all 
Select 11  as Id , NULL as Name
) 
--select * from cte;
SELECT ID, ISNULL(NAME, (SELECT TOP 1 NAME FROM CTE CTE2 WHERE CTE2.ID<CTE.ID AND CTE2.NAME IS NOT NULL ORDER BY ID DESC)) AS Name FROM CTE 