SELECT Account_ID,Account_Name,CAST(a.NR+YEAR(GETDATE())-3 AS CHAR(4)) + 'Q' + b.NR  AS Year_Quarter

FROM

(

SELECT 1 AS Account_ID, 'COGS'  as Account_Name

UNION ALL

SELECT 2, 'Sales'

) t

cross join 

( select '1' AS NR union all

  select '2' AS NR union all

  select '3' AS NR  ) a

cross join

( select '1' AS NR union all

  select '2' AS NR union all

  select '3' AS NR union all

  select '4' AS NR  ) b

ORDER BY 1,2,3