DECLARE @Inits TABLE ( initials VARCHAR(10) );

DECLARE @Full TABLE ( fullname VARCHAR(500) );

INSERT  INTO @Inits
VALUES  ( 'BB' ),
        ( 'JJ' ),
        ( 'RR' ),
        ( 'MM' ),
        ( 'NN' );

INSERT  INTO @Full
VALUES  ( 'James Johnson' ),
        ( 'Bob Blue' ),
        ( 'Ricardo Red' ),
        ( 'Manly Man' ),
        ( 'New Ned' ),
        ( 'Robert Redford' );

SELECT  *
FROM    @Inits I
        INNER JOIN @Full F ON I.initials = SUBSTRING(F.fullname, 1, 1) + SUBSTRING(F.fullname, CHARINDEX(' ', F.fullname) + 1, 1);