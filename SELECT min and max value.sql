/*
https://social.msdn.microsoft.com/Forums/sqlserver/en-US/bbce16ce-5a68-449a-8e4e-c40e539dd18b/select-min-and-max-value?forum=transactsql
*/

DECLARE @GroupingDetails TABLE
(
 GroupID INT,
 SequenceID INT,
 MainStatus VARCHAR(10),
 Status INT)
 
 INSERT INTO @GroupingDetails 
 VALUES 
 (1,1,'Denied',0),
 (1,4,'Denied',0),
 (11,1,'Approved',0),
 (11,4,'Approved',0),
 (9,1,'Pending',1),
 (9,2,'Pending',1),
 (9,3,'Pending',1),
 (9,4,'Pending',0),
 (10,1,'Pending',0)

 select * from @GroupingDetails

 SELECT *
   FROM @GroupingDetails gd
  WHERE (mainStatus NOT IN ('Approved','Denied') AND sequenceID = (SELECT MAX(SequenceID) FROM @GroupingDetails WHERE groupID = gd.groupID AND status = 0))
     OR (mainStatus     IN ('Approved','Denied') AND sequenceID = (SELECT MIN(SequenceID) FROM @GroupingDetails WHERE groupID = gd.groupID AND status = 0))