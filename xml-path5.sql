declare @temp table(id int, [name] char(1))
insert into @temp values (1,'x')
insert into @temp values (1,'a')
insert into @temp values (1,'c')
insert into @temp values (3,'x')
insert into @temp values (3,'u')
SELECT [id], 
       Stuff((SELECT ',' + [name] 
              FROM   @temp 
              WHERE  [id] = a.[id] 
              FOR xml path('')), 1, 1, '') --[name]
FROM   @TEMP a 
GROUP  BY  [id]