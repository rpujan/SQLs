/* 
* https://social.msdn.microsoft.com/Forums/sqlserver/en-US/c213af7f-4094-4248-be62-694970f76a64/query-to-display-one-row-per-group-based-on-highest-value?forum=transactsql
*/

/*
* Query to display one row per group based on highest value
*/
DECLARE @YourTable TABLE (
	Acode varchar(128),
	Aname varchar(128),
	Anumber int
)
INSERT INTO @YourTable(Acode, Aname, Anumber)
VALUES
('a', 'Jim', 40), ('a', 'Jim', 23), ('a', 'Jim', 12), 
('b', 'Sal', 42), ('b', 'Sal', 12), ('b', 'Sal', 3)

SELECT Acode, Aname, MAX(Anumber) AS Anumber
FROM @YourTable
GROUP BY Acode, Aname