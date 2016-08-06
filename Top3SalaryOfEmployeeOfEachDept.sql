declare @Employee TABLE (EmployeeID int, EmployeeName varchar(20), DepartmentID int, Salary money)

insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N1', 1, 1000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N2', 1, 2000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N3', 1, 3000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N4', 1, 4000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N5', 1, 5000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N6', 1, 6000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N7', 1, 7000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N8', 1, 8000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N9', 1, 9000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N10', 1, 10000)

insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N1', 2, 1000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N2', 2, 2000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N3', 2, 3000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N4', 2, 4000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N5', 2, 5000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N6', 2, 6000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N7', 2, 7000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N8', 2, 8000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N9', 2, 9000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N10',2, 10000)


insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N1', 3, 1000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N2', 3, 2000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N3', 3, 3000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N4', 3, 4000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N5', 3, 5000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N6', 4, 6000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N7', 4, 7000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N8', 4, 8000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N9', 4, 9000)
insert into @Employee(EmployeeName, DepartmentID, Salary) Values ('N10',4, 10000)



;with cte as
(
select *,(select COUNT(*) from @Employee where e.salary<=salary and departmentID=e.departmentID) as r from @Employee	  e
)

select * from cte where r<=3



Select * From (SELECT    A.*, 
(SELECT COUNT(DISTINCT(B.salary))
FROM @Employee B
WHERE B.salary >= A.salary and A.departmentID=B.departmentID) as Rank FROM  @Employee A) Emp
Where Emp.Rank <=3 




