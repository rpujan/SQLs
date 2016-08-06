declare @test table (id int, Msg_text varchar(100))
insert into @test values(1,'00000001 abc'),(2,'00000002 abc'),(3,'00000003 abc'),(4,'00000004 abc'),(5,'00000005 abc'),(6,'00000006 abc'),
(7,'00000007 abc'),(8,'00000008 abc'),(9,'00000009 abc'),(10,'000000010 abc'),

(11,'00000001 abc'),(12,'00000002 abc'),(13,'00000003 abc'),(14,'00000004 abc'),(15,'00000005 abc'),(16,'00000006 abc'),
(17,'00000007 abc'),(18,'00000008 abc'),(19,'00000009 abc'),(20,'000000010 abc')

;with mycte as (Select id,Msg_text ,((Row_number() Over(Order by ID ) -1)  / 3 )  rn from @test)

SELECT t1.rn,
       Stuff(( SELECT ',' + Msg_text
           FROM mycte t2
          WHERE t2.rn = t1.rn  
          ORDER BY id
            FOR XML PATH(''), TYPE).value('.', 'varchar(max)'),1,1,'')  AS ids
  FROM mycte t1
 GROUP BY t1.rn
