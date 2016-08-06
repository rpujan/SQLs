/*
Row Constructor (or Table-Valued Constructor) as Derived Table
http://www.sql-server-helper.com/sql-server-2008/row-value-constructor-as-derived-table.aspx
*/

SELECT * 
FROM (VALUES ('USD', 'U.S. Dollar'),
             ('EUR', 'Euro'),
             ('CAD', 'Canadian Dollar'),
             ('JPY', 'Japanese Yen')) AS [Currency] ( [CurrencyCode], [CurrencyName] )

/*             
CurrencyCode   CurrencyName
-------------- --------------------
USD            U.S. Dollar
EUR            Euro
CAD            Canadian Dollar
JPY            Japanese Yen
*/

SELECT [MetricPrefix].[Prefix] + [Measure].[Unit] AS [Measurement], [MetricPrefix].[Multiplier]
FROM (VALUES ('milli', 0.001),
             ('centi', 0.01),
             ('deci', 0.1),
             ('kilo', 1000)) AS [MetricPrefix] ( [Prefix], [Multiplier] ),
     (VALUES ('gram'),
             ('liter'),
             ('meter')) AS [Measure] ( [Unit] )
GO

/*
Measurement   Multiplier
------------  ------------
milligram     0.001
centigram     0.010
decigram      0.100
kilogram      1000.000
milliliter    0.001
centiliter    0.010
deciliter     0.100
kiloliter     1000.000
millimeter    0.001
centimeter    0.010
decimeter     0.100
kilometer     1000.000
*/