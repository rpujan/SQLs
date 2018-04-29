/* https://social.msdn.microsoft.com/Forums/sqlserver/en-US/85560ebf-34f9-4154-8509-6c49d3251142/previous-record-of-maxdate?forum=transactsql */

declare @temp table (CodeA varchar(20), CodeB varchar(20), CodeC varchar(20), date1 datetime,Remk varchar(20))
Insert into @temp values ('A1','AA','1','2016-07-09',NULL)
Insert into @temp values ('A1','AA','1','2017-05-09',NULL)
Insert into @temp values ('A1','AA','1','2018-04-09',NULL)
Insert into @temp values ('A1','BB','1','2018-04-04',NULL)
Insert into @temp values ('A1','CC','2','2018-02-04',NULL)
Insert into @temp values ('A1','CC','2','2018-04-01',NULL)
Insert into @temp values ('A2','BA','1','2017-06-04',NULL)
Insert into @temp values ('A3','BA','2','2016-07-01',NULL)
Insert into @temp values ('A3','BA','2','2018-03-04',NULL)
Insert into @temp values ('A3','CC','1','2018-02-04',NULL)

--Select * from @temp

--Select CodeA, CodeB, CodeC, date1,
--  Row_Number() Over(Partition By CodeA, CodeB, CodeC Order By date1 Desc) As rn
--From @temp

;With cte As
(Select CodeA, CodeB, CodeC, date1,
  Row_Number() Over(Partition By CodeA, CodeB, CodeC Order By date1 Desc) As rn
From @temp)
Select CodeA, CodeB, CodeC, date1
From cte
Where rn = 2;