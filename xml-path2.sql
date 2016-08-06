declare @TestTable table (StudentName VARCHAR(100), Course VARCHAR(100), Instructor VARCHAR(100), RoomNo VARCHAR(100))

-- Populate table
INSERT INTO @TestTable (StudentName, Course, Instructor, RoomNo)
SELECT 'Mark', 'Algebra', 'Dr. James', '101'
UNION ALL
SELECT 'Mark', 'Maths', 'Dr. Jones', '201'
UNION ALL
SELECT 'Joe', 'Algebra', 'Dr. James', '101'
UNION ALL
SELECT 'Joe', 'Science', 'Dr. Ross', '301'
UNION ALL
SELECT 'Joe', 'Geography', 'Dr. Lisa', '401'
UNION ALL
SELECT 'Jenny', 'Algebra', 'Dr. James', '101'

-- Check orginal data
SELECT * FROM @TestTable

-- Group by Data using column and XML PATH
SELECT
StudentName,
STUFF((
SELECT ', ' + Course + ' by ' + CAST(Instructor AS VARCHAR(MAX)) + ' in Room No ' + CAST(RoomNo AS VARCHAR(MAX))
FROM @TestTable
WHERE (StudentName = StudentCourses.StudentName)
FOR XML PATH (''))
,1,2,'') AS NameValues
FROM @TestTable StudentCourses
GROUP BY StudentName
