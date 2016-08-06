/*
* http://www.sqlservercentral.com/Forums/Topic1698693-392-1.aspx
* Count of consecutive years of participation
* 
*/

declare @temp table 
(
	ID INT NOT NULL,
	[Date] DATE NOT NULL 
)

INSERT @temp (ID, [Date]) VALUES
(1, '2000-05-03'),
(1, '2001-06-10'),
(1, '2002-04-02'),
(1, '2005-07-29'),
(1, '2010-12-15'),
(4, '2001-05-07'),
(4, '1999-08-01'),
(4, '2000-07-05'),
(4, '2001-08-01'),
(9, '2002-05-01'),
(9, '2000-04-02');

;WITH AddRN AS 
(
	SELECT t.ID, t.Date, ROW_NUMBER() OVER (PARTITION BY t.ID ORDER BY t.Date) AS RN
	FROM @temp t
)
SELECT 
	a.ID,
	SUM(CASE WHEN DATEDIFF(yy, b.Date, a.Date) = 1 THEN 1 ELSE 0 END) AS ConsecYears		
FROM 
	AddRN a
	LEFT JOIN AddRN b
		ON a.ID = b.ID
		AND a.RN = b.RN + 1
GROUP BY a.ID