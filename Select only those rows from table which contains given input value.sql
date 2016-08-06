/*
Select only those rows from table which contains given input value
https://social.msdn.microsoft.com/Forums/sqlserver/en-US/232427f1-e931-4819-9870-baa0a66a7fe1/select-only-those-rows-from-table-which-contains-given-input-value?forum=transactsql
*/
DECLARE @tmp TABLE ( IDs NVARCHAR(MAX) );

DECLARE @id INT = 2;

INSERT  INTO @tmp
VALUES  ( '1,2,3,4,5,6' ),
        ( '22,34,64,46,767,534,355,2' ),
        ( '32,45,76,34,8,7,97,9,9,777' ),
        ( '2,65,87,35,34,2,45,6,7,45,55,434,0' ),
        ( '43,54,76,47,03,356,76,8' ),
        ( '7,43,54,,76,47,03,356,76,8' ),
        ( '8,43,54,,76,47,03,356,76,7' );

SELECT  *
FROM    @tmp
WHERE   ',' + IDs + ',' LIKE '%,' + CAST(@id AS VARCHAR(255)) + ',%';