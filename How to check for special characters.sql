DECLARE @specials TABLE (char CHAR(1))
INSERT INTO @specials (char) VALUES
('`'),('~'),('!'),('@'),('#'),('$'),('%'),('^'),('&'),('*'),('('),(')'),('-'),('_'),('+'),('='),('{'),('['),(']'),('}'),(':'),(';'),('"'),(''''),('<'),('>'),('?'),(','),('.'),('/'),('?')

DECLARE @table TABLE (value VARCHAR(50))
INSERT INTO @table (value) VALUES
('hfkdhfdfdfhds'),('4vfgdfgfgf'),('GT&%^&*G')

SELECT value, SUM(CASE WHEN CHARINDEX(char,value) > 1 THEN 1 ELSE 0 END) AS specials
  FROM @table
    CROSS APPLY @specials
 GROUP BY value