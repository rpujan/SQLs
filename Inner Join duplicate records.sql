-- http://social.msdn.microsoft.com/Forums/sqlserver/en-US/318b5b04-a7bc-4c8d-8e48-f5be4161132b/how-can-i-create-a-view-from-same-table-where-i-need-columns-details-from-different-rows-in-the-same?forum=transactsql
-- HOW CAN I CREATE A VIEW FROM SAME TABLE WHERE I NEED COLUMNS DETAILS FROM DIFFERENT ROWS IN THE SAME TABLE

/*

i have a table1 on the top, but i want to create a view from table 1 as  view mentioned beneath the table 2. Could any of you please help me.
table1
ID 	office 	employee 	activity
1 	246 	-9999 		698
2 	-99 	21480 		698
3 	104 	-9999 		7025
4 	-99 	88908 		7025
5 	108 	-9999 		2415
6 	-99 	17135 		2415
7 	246 	-9999 		698
8 	-99 	21480 		698
9 	104 	-9999 		7025
10 	-99 	88908 		7025
11 	108 	-9999 		2415
12 	-99 	17135 		2415

view
ID 	office 	ID1 	employee 	activity
1 	246 	2 		21480 		698
3 	104 	4 		88908 		7025
5 	108 	6 		17135 		2415
7 	246 	8 		21480 		698
9 	104 	10 		88908 		7025
11 	108 	12 		17135 		2415

*/


declare @forumsTable table (ID int, activityID int)
insert into @forumsTable (ID, activityID)
values 

 (1	, 698 )
,(2	, 698 )
,(3	, 698 ) 
--,(4	, 7025) 
--,(5	, 2415) 
--,(6	,-99,	17135, 2415) 
--,(7	,246,	-9999, 698 )
--,(8	,-99,	21480, 698 )
--,(9	,104,	-9999, 7025) 
--,(10	,-99,	88908, 7025) 
--,(11	,108,	-9999, 2415) 
--,(12	,-99,	17135, 2415)


select f1.ID--, f1.officeID, f2.ID as ID1, f1.employeeID, f1.activityID
  from @forumsTable f1
    inner join @forumsTable f2
	  on f1.activityID = f2.activityID
	  --and f1.officeID > 0
	  --and f2.employeeID > 0
	  --and f1.id - f2.id = -1

