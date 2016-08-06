/*
Here are my tables:

departments: deparmentid, parentdeptid, name
employees:   emplid, departmentid, name

I am trying to select all employees with their names and department names. It is very possible that I might have departments like subdivisions that wont have employees working there.
Dept1
     Subdept1
         Subdept2
             Actual Employee
*/


DECLARE @departments TABLE ( deparmentid INT, parentdeptid INT, name NVARCHAR(255) );
DECLARE @employees TABLE ( emplid INT, departmentid INT, name NVARCHAR(255) );

INSERT INTO @departments
VALUES	( 1, NULL, 'Company' ),
		( 2, 1, 'Sales/Key Account' ),
		( 3, 2, 'Sales' ),
		( 4, 2, 'Key Account' ),
		( 5, 1, 'Marketing' );

INSERT INTO @employees
VALUES	( 1, 3, 'Homer' ),
		( 2, 4, 'Moe' ),
		( 3, 5, 'Ned' ),
		( 3, 5, 'Otto' );

WITH Hierarchy AS
	(
		SELECT	A.*,
				A.deparmentid AS RootId,
				0 AS [Level],
 				'\\' + CAST(A.name AS NVARCHAR(MAX)) + '\' AS NamePath,
				'\\' + CAST(A.deparmentid AS VARCHAR(MAX)) + '\' AS IdPath
		FROM	@departments A 
		WHERE	A.parentdeptid IS NULL
		UNION ALL
		SELECT	C.*,
				P.RootId,
				P.[Level] + 1,
				P.NamePath + C.name + '\',
				P.IdPath + CAST(C.deparmentid AS VARCHAR(MAX)) + '\'
		FROM	@departments C
			INNER JOIN Hierarchy P ON P.deparmentid = C.parentdeptid
	)
	SELECT	*
	FROM	Hierarchy H
		LEFT JOIN @employees E ON E.departmentid = H.deparmentid
	ORDER BY H.NamePath, E.name;