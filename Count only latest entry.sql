DECLARE @table TABLE (ID INT, date DATE, Event CHAR(3), CountryCode INT, TxnID INT)
INSERT INTO @table (ID, date, event, CountryCode, TxnID) VALUES 
(1,   '2015-05-22', 'ABC', 123, 111),
(2,   '2015-05-23', 'XYZ', 123, 111),
(3,   '2015-05-20', 'XYZ', 123, 222),
(4,   '2015-05-21', 'ABC', 123, 222),
(5,   '2015-04-12', 'PQY', 456, 444),
(6,   '2015-03-05', 'PQY', 456, 444);


SELECT
	d.id,
	d.date,
	d.[Event],
	d.CountryCode,
	d.TxnID
FROM (
		SELECT 
			id,
			ROW_NUMBER() OVER(PARTITION BY CountryCode,[Event] ORDER BY [date] desc) AS RW, 
			[date],
			[Event],
			CountryCode,
			TxnID
		FROM @table
		) d
WHERE d.RW= 1;