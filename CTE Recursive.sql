WITH DirectReports (ManagerID, EmployeeID, Title, DeptID, Level)
AS
(
-- Anchor member definition
    SELECT e.ManagerID, e.EmployeeID, e.Title, edh.DepartmentID, 
        0 AS Level
    FROM dbo.MyEmployees AS e
    INNER JOIN AdventureWorks.HumanResources.EmployeeDepartmentHistory AS edh
        ON e.EmployeeID = edh.EmployeeID AND edh.EndDate IS NULL
    WHERE ManagerID IS NULL
    UNION ALL
-- Recursive member definition
    SELECT e.ManagerID, e.EmployeeID, e.Title, edh.DepartmentID,
        Level + 1
    FROM dbo.MyEmployees AS e
    INNER JOIN AdventureWorks.HumanResources.EmployeeDepartmentHistory AS edh
        ON e.EmployeeID = edh.EmployeeID AND edh.EndDate IS NULL
    INNER JOIN DirectReports AS d
        ON e.ManagerID = d.EmployeeID
)
-- Statement that executes the CTE
SELECT ManagerID, EmployeeID, Title, Level
FROM DirectReports
INNER JOIN AdventureWorks.HumanResources.Department AS dp
    ON DirectReports.DeptID = dp.DepartmentID
WHERE dp.GroupName = N'Sales and Marketing' OR Level = 0;
GO
