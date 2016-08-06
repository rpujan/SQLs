DECLARE @StringInput  VARCHAR(100) = 'Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday'
DECLARE @StringValue  VARCHAR(100)
DECLARE @OutputTable TABLE ([StringValue] VARCHAR(100))

WHILE LEN(@StringInput) > 0
BEGIN
    SET @StringValue = LEFT(@StringInput, 
                            ISNULL(NULLIF(CHARINDEX(',', @StringInput) - 1, -1),
                            LEN(@StringInput)))
    SET @StringInput = SUBSTRING(@StringInput,
                                 ISNULL(NULLIF(CHARINDEX(',', @StringInput), 0),
                                 LEN(@StringInput)) + 1, LEN(@StringInput))

    INSERT INTO @OutputTable ( [StringValue] )
    VALUES ( @StringValue )
END

SELECT * FROM @OutputTable