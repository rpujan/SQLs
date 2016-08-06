/*
* 
* http://www.sqlservercentral.com/Forums/Topic1702129-392-1.aspx
* 
*/

declare @BookTest table
(
	BookID int NOT NULL,
	BookTitle varchar(50) NULL,
	BookGenre varchar(50) NULL
)

declare @TitleTest table
(
	TitleID int NOT NULL,
	BookID int NOT NULL,
	TitleName varchar(50) NULL
)

INSERT INTO @BookTest VALUES(1, 'BookTitle1', 'BookGenre1')
INSERT INTO @BookTest VALUES(2, 'BookTitle2', 'BookGenre2')
INSERT INTO @BookTest VALUES(3, 'BookTitle3', 'BookGenre3')
INSERT INTO @BookTest VALUES(4, 'BookTitle4', 'BookGenre4')
INSERT INTO @BookTest VALUES(5, 'BookTitle5', 'BookGenre5')

INSERT INTO @TitleTest VALUES(1,  1,  'TitleName1')
INSERT INTO @TitleTest VALUES(2,  1,  'TitleName2')
INSERT INTO @TitleTest VALUES(3,  1,  'TitleName3')
INSERT INTO @TitleTest VALUES(4,  1,  'TitleName4')
INSERT INTO @TitleTest VALUES(5,  1,  'TitleName5')
INSERT INTO @TitleTest VALUES(6,  2,  'TitleName6')
INSERT INTO @TitleTest VALUES(7,  2,  'TitleName7')
INSERT INTO @TitleTest VALUES(8,  2,  'TitleName8')
INSERT INTO @TitleTest VALUES(9,  2,  'TitleName9')
INSERT INTO @TitleTest VALUES(10, 2, 'TitleName10')
INSERT INTO @TitleTest VALUES(11, 3, 'TitleName11')
INSERT INTO @TitleTest VALUES(12, 3, 'TitleName12')
INSERT INTO @TitleTest VALUES(13, 3, 'TitleName13')
INSERT INTO @TitleTest VALUES(14, 3, 'TitleName14')
INSERT INTO @TitleTest VALUES(15, 3, 'TitleName15')
INSERT INTO @TitleTest VALUES(16, 4, 'TitleName16')
INSERT INTO @TitleTest VALUES(17, 4, 'TitleName17')
INSERT INTO @TitleTest VALUES(18, 4, 'TitleName18')
INSERT INTO @TitleTest VALUES(19, 4, 'TitleName19')
INSERT INTO @TitleTest VALUES(20, 4, 'TitleName20')
INSERT INTO @TitleTest VALUES(21, 5, 'TitleName21')
INSERT INTO @TitleTest VALUES(22, 5, 'TitleName22')
INSERT INTO @TitleTest VALUES(23, 5, 'TitleName23')
INSERT INTO @TitleTest VALUES(24, 5, 'TitleName24')
INSERT INTO @TitleTest VALUES(25, 5, 'TitleName25')

;with cte as
(
	select BT.BookID, -2 as TitleID, BT.BookTitle as Out_Put from @BookTest BT
	union all
	select BT.BookID, -1 as TitleID, BT.BookGenre as Out_Put from @BookTest BT
	union all
	select TT.BookID, TT.TitleID, TT.TitleName as Out_Put from @TitleTest TT inner join @BookTest BT on TT.BookID = BT.BookID
)
select Out_Put from cte order by BookID, TitleID 


-- original solution

--;WITH BASE_DATA AS
--(
--SELECT
--    BT.BookID
--   ,0 AS TitleID
--   ,BT.BookTitle    AS OUT_TEXT
--FROM @BookTest BT
--UNION ALL   
--SELECT
--    BT.BookID
--   ,0 AS TitleID
--   ,BT.BookGenre    AS OUT_TEXT
--FROM @BookTest BT
--UNION ALL
--SELECT
--    BT.BookID
--   ,TT.TitleID AS TitleID
--   ,TT.TitleName AS OUT_TEXT
--FROM @BookTest BT
--INNER JOIN  @TitleTest TT
--ON BT.BookID = TT.BookID
--)

----select * from BASE_DATA


--select
--	BD.BookID,
--	BD.TitleID,
--    BD.OUT_TEXT
--FROM BASE_DATA BD
--ORDER BY BD.BookID,BD.TitleID;

