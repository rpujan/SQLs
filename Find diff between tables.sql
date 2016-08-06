-- http://social.msdn.microsoft.com/Forums/sqlserver/en-US/6a6641ee-4375-4228-93eb-5cbc5185fd20/sql-query-to-find-differences-changes-between-tables-from-one-table-where-field-names-are?forum=transactsql

--SQL query to find differences (changes) between tables (from one table) where field names are different 

-- I am looking to create a view which returns new or modified data (differences) based on a comparison between two tables.
-- The EMP_SOURCE table stores all employee data including duplicate staff numbers (STAFFNO)

declare @EMP table ([EMP_ID] int,[EMP_NAME] varchar(255),[EMP_TITLE] varchar(255),[EMP_OFFICE] varchar(255),[EMP_COUNTRY] varchar(255),[EMP_NUMBER] varchar(255))
declare @EMP_SOURCE table ([FULLNAME] varchar(255),[JOBTITLE] varchar(255),[LOCATION] varchar(255),[COUNTRY] varchar(255),[STAFFNO] varchar(255))

INSERT INTO @EMP (EMP_ID, EMP_NAME, EMP_TITLE, EMP_OFFICE, EMP_COUNTRY, EMP_NUMBER) 
VALUES (1, 'John Smith', 'Manager', 'London', 'UK', '1087');
INSERT INTO @EMP (EMP_ID, EMP_NAME, EMP_TITLE, EMP_OFFICE, EMP_COUNTRY, EMP_NUMBER) 
VALUES (2, 'Beth King', 'Analyst', 'New York', 'USA', '2095');
INSERT INTO @EMP (EMP_ID, EMP_NAME, EMP_TITLE, EMP_OFFICE, EMP_COUNTRY, EMP_NUMBER) 
VALUES (3, 'Karl Bent', 'Manager', 'Washington', 'USA', '1106');

INSERT INTO @EMP_SOURCE (FULLNAME, JOBTITLE, LOCATION, COUNTRY, STAFFNO) 
VALUES ('John Smith', 'Manager', 'London', 'UK', '1087');
INSERT INTO @EMP_SOURCE (FULLNAME, JOBTITLE, LOCATION, COUNTRY, STAFFNO) 
VALUES ('Beth King', 'Analyst', 'New York', 'USA', '2095');
INSERT INTO @EMP_SOURCE (FULLNAME, JOBTITLE, LOCATION, COUNTRY, STAFFNO) 
VALUES ('Karl Bent', 'Manager', 'Chicago', 'USA', '1106');
INSERT INTO @EMP_SOURCE (FULLNAME, JOBTITLE, LOCATION, COUNTRY, STAFFNO) 
VALUES ('Beth King', 'Junior', 'Washington', 'USA', '2095');
INSERT INTO @EMP_SOURCE (FULLNAME, JOBTITLE, LOCATION, COUNTRY, STAFFNO) 
VALUES ('Harry Kline', 'Consultant', 'Manchester', 'UK', '2341');



SELECT	*
FROM		@EMP_SOURCE as emp_source
LEFT JOIN	(
				SELECT	StaffNo
				FROM	@EMP_SOURCE
				GROUP BY	StaffNo
				HAVING COUNT(1) > 1
			) Temp
ON			emp_source.StaffNo = Temp.StaffNo
LEFT JOIN	@EMP as emp
ON			emp_source.StaffNo = emp.EMP_NUMBER
AND			COALESCE(emp_source.FullName, '') = COALESCE(emp.EMP_NAME,'')
AND			COALESCE(emp_source.JobTitle, '') = COALESCE(emp.EMP_TITLE, '')
AND			COALESCE(emp_source.Location, '') = COALESCE(emp.EMP_OFFICE, '')
AND			COALESCE(emp_source.Country, '')  = COALESCE(emp.EMP_COUNTRY, '')
WHERE	emp.EMP_ID IS NULL
AND		Temp.StaffNo IS NULL