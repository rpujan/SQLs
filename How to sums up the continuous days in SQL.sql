CREATE TABLE [dbo].[temp_example](
	[person_id] [int] NULL,
	[absence_id] [int] NULL,
	[date_date] [datetime] NULL,
	[Absenct days] [int] NULL,
	[Absenct hours] [int] NULL
) ON [PRIMARY]

GO
INSERT [dbo].[temp_example] ([person_id], [absence_id], [date_date], [Absenct days], [Absenct hours]) VALUES (8, 3, CAST(N'2016-07-20 00:00:00.000' AS DateTime), 1, 7)
GO
INSERT [dbo].[temp_example] ([person_id], [absence_id], [date_date], [Absenct days], [Absenct hours]) VALUES (11, 3, CAST(N'2016-07-18 00:00:00.000' AS DateTime), 1, 7)
GO
INSERT [dbo].[temp_example] ([person_id], [absence_id], [date_date], [Absenct days], [Absenct hours]) VALUES (16, 2, CAST(N'2016-07-21 00:00:00.000' AS DateTime), 1, 6)
GO
INSERT [dbo].[temp_example] ([person_id], [absence_id], [date_date], [Absenct days], [Absenct hours]) VALUES (16, 2, CAST(N'2016-07-22 00:00:00.000' AS DateTime), 1, 6)
GO
INSERT [dbo].[temp_example] ([person_id], [absence_id], [date_date], [Absenct days], [Absenct hours]) VALUES (18, 3, CAST(N'2016-07-18 00:00:00.000' AS DateTime), 1, 7)
GO
INSERT [dbo].[temp_example] ([person_id], [absence_id], [date_date], [Absenct days], [Absenct hours]) VALUES (19, 3, CAST(N'2016-07-22 00:00:00.000' AS DateTime), 1, 7)
GO
INSERT [dbo].[temp_example] ([person_id], [absence_id], [date_date], [Absenct days], [Absenct hours]) VALUES (19, 3, CAST(N'2016-07-25 00:00:00.000' AS DateTime), 1, 7)
GO
INSERT [dbo].[temp_example] ([person_id], [absence_id], [date_date], [Absenct days], [Absenct hours]) VALUES (19, 3, CAST(N'2016-07-26 00:00:00.000' AS DateTime), 1, 7)
GO
INSERT [dbo].[temp_example] ([person_id], [absence_id], [date_date], [Absenct days], [Absenct hours]) VALUES (19, 4, CAST(N'2016-07-27 00:00:00.000' AS DateTime), 1, 7)
GO



select * from temp_example

SELECT person_id,absence_id,MIN(date_date) As 'Absence_Startdate',MAX(date_date) 'Absence_Enddate',SUM([Absenct hours]),SUM([Absenct days]) 
 FROM [temp_example] 
GROUP BY person_id,absence_id
ORDER BY person_id

drop table temp_example