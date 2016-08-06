/* https://social.msdn.microsoft.com/Forums/sqlserver/en-US/7e187bcc-6cb1-4669-92d9-640739d6ee28/need-help-on-tsql-query?forum=transactsql */

-- row as columns but without using Pivot

DECLARE @TestTable TABLE (Branch VARCHAR(10), Period VARCHAR(10), Profit INT)
INSERT INTO @TestTable values
('Delhi', 'Q1', 123), ('Delhi', 'Q2', 323), ('Delhi', 'Q3', 433), ('Delhi', 'Q4', 767)
INSERT INTO @TestTable values
('Mumbai', 'Q1', 134), ('Mumbai', 'Q2', 401), ('Mumbai', 'Q3', 472), ('Mumbai', 'Q4', 795)

select branch,
min(case when Period='Q1' then Profit end) as 'Q1',
min(case when Period='Q2' then Profit end) as 'Q2',
min(case when Period='Q3' then Profit end) as 'Q3',
min(case when Period='Q4' then Profit end) as 'Q4'
from @TestTable
group by branch