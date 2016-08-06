/* https://social.msdn.microsoft.com/Forums/sqlserver/en-US/324c8b0d-bd20-4281-a9f4-4cbd29f1949d/getting-stale-records-same-value-for-n-days?forum=transactsql  */

Create Table #Prices(
  ID int,
  TradeDate date,
  Product varchar(50),
  Price float
  )

Insert into #Prices(ID,Tradedate,Product,Price) Values(1,'01-May-2016', 'Cabbage',1.99)
Insert into #Prices(ID,Tradedate,Product,Price) Values(2,'01-May-2016', 'Carrots',1.06)
Insert into #Prices(ID,Tradedate,Product,Price) Values(3,'01-May-2016', 'Tomato',1.35)
Insert into #Prices(ID,Tradedate,Product,Price) Values(4,'01-May-2016', 'Onion',1.47)
Insert into #Prices(ID,Tradedate,Product,Price) Values(5,'02-May-2016', 'Cabbage',1.07)
Insert into #Prices(ID,Tradedate,Product,Price) Values(6,'02-May-2016', 'Carrots',1.35)
Insert into #Prices(ID,Tradedate,Product,Price) Values(7,'02-May-2016', 'Tomato',1.85)
Insert into #Prices(ID,Tradedate,Product,Price) Values(8,'02-May-2016', 'Onion',1.69)
Insert into #Prices(ID,Tradedate,Product,Price) Values(9,'03-May-2016', 'Cabbage',1.75)
Insert into #Prices(ID,Tradedate,Product,Price) Values(10,'03-May-2016', 'Tomato',1.85)
Insert into #Prices(ID,Tradedate,Product,Price) Values(11,'03-May-2016', 'Onion',1.51)
Insert into #Prices(ID,Tradedate,Product,Price) Values(12,'04-May-2016', 'Cabbage',1.97)
Insert into #Prices(ID,Tradedate,Product,Price) Values(13,'04-May-2016', 'Tomato',1.85)
Insert into #Prices(ID,Tradedate,Product,Price) Values(14,'04-May-2016', 'Onion',1.81)
Insert into #Prices(ID,Tradedate,Product,Price) Values(15,'05-May-2016', 'Cabbage',1.39)
Insert into #Prices(ID,Tradedate,Product,Price) Values(16,'05-May-2016', 'Tomato',1.85)
Insert into #Prices(ID,Tradedate,Product,Price) Values(17,'05-May-2016', 'Onion',1.98)
Insert into #Prices(ID,Tradedate,Product,Price) Values(18,'06-May-2016', 'Cabbage',1.49)
Insert into #Prices(ID,Tradedate,Product,Price) Values(19,'06-May-2016', 'Carrots',1.35)
Insert into #Prices(ID,Tradedate,Product,Price) Values(20,'06-May-2016', 'Tomato',1.85)
Insert into #Prices(ID,Tradedate,Product,Price) Values(21,'06-May-2016', 'Onion',1.48)
Insert into #Prices(ID,Tradedate,Product,Price) Values(22,'07-May-2016', 'Cabbage',1.56)
Insert into #Prices(ID,Tradedate,Product,Price) Values(23,'07-May-2016', 'Carrots',1.35)
Insert into #Prices(ID,Tradedate,Product,Price) Values(24,'07-May-2016', 'Tomato',1.85)
Insert into #Prices(ID,Tradedate,Product,Price) Values(25,'07-May-2016', 'Onion',1.46)

Declare @StaleBoundary int = 5;

select p.*
, case when exists (select * from #Prices p2 where p2.Product = p.Product
  and p2.Price <> p.Price 
  and DATEDIFF(day, p2.TradeDate, p.TradeDate) < @StaleBoundary)
  then 0 else 1 end as IsStale
from #Prices p

drop table #Prices