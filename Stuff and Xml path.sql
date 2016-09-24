DECLARE @Tickets TABLE (
    [TicketID] char(5) NOT NULL,
    [Person] nvarchar(15) NOT NULL
)

INSERT INTO @Tickets VALUES
    ('T0001', 'Alice'),
    ('T0001', 'Bob'),
    ('T0002', 'Catherine'),
    ('T0002', 'Doug'),
    ('T0003', 'Elaine')

SELECT t.TicketID, stuff((select ',' + tt.Person from @Tickets tt where tt.TicketID = t.TicketID for xml path('')),1,1,'') as Person
FROM @Tickets t
group by TicketID
