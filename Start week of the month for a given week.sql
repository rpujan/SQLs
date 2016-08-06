-- Start week of the month for a given week

--SELECT DATENAME(wk, DATEFROMPARTS(YEAR(getdate()), MONTH(getdate()), 1))
--SELECT DATENAME(wk, getdate())
SELECT DATENAME(wk, DATEFROMPARTS(YEAR(getdate()), MONTH(getdate()), 1)), DATENAME(wk, getdate())
