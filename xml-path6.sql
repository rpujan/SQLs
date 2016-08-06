USE Northwind
GO

Select
Distinct(Country),STUFF(
(Select ',' + City From Customers WHERE Country='Germany' For XML Path ('')),1,1,'')
From
Customers WHERE Country='Germany'



Select
Distinct(C1.Country),STUFF(
(Select ',' + C2.City From Customers C2 Where C1.Country = C2.Country Order by C2.City For XML Path ('')),1,1,'')
From
Customers C1