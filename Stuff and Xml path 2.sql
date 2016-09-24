DECLARE @Heroes TABLE (
    [HeroName]      VARCHAR(20)
)

INSERT INTO @Heroes ( [HeroName] )
VALUES ( 'Superman' ), ( 'Batman' ), ('Ironman'), ('Wolverine')

SELECT STUFF((SELECT ',' + [HeroName]
			  FROM @Heroes
			  ORDER BY [HeroName]
			  FOR XML PATH('')), 1, 1, '') AS [Output]