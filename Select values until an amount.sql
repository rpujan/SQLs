/* https://social.msdn.microsoft.com/Forums/sqlserver/en-US/6c5eec83-be5b-45cb-8392-4055a5cbbbbe/select-values-until-an-amount?forum=transactsql */

DECLARE @Balances TABLE(Client INTEGER, Balance MONEY);

INSERT INTO
 @Balances (Client, Balance)
VALUES
(1, 896),
(2, 847),
(3, 1501);

DECLARE @Payments TABLE(Client INT, Row TINYINT, Payment MONEY);

INSERT INTO
 @Payments(Client, Row, Payment)
VALUES
(1, 1, 4332),
(1, 2, 8338),
(1, 3, 12019),
(2, 1, 248),
(2, 2, 248),
(2, 3, 248),
(3, 1, 148),
(3, 2, 26),
(3, 3, 1282),
(3, 4, 50);

select p.Client,Row,CASE WHEN Balance - COALESCE(TotalPayment,0) < Payment THEN Balance - COALESCE(TotalPayment,0)
WHEN Payment + COALESCE(TotalPayment,0)  < Balance  THEN Payment 
ELSE Balance - COALESCE(TotalPayment,0)
END AS Payment
from @Payments p
OUTER APPLY
(
SELECT SUM(Payment) AS TotalPayment
FROM @Payments
WHERE Client = p.Client
AND Row < p.Row
)p1
INNER JOIN @Balances b
ON b.Client = p.Client 
WHERE   COALESCE(TotalPayment,0)  <= b.Balance
OR  b.Balance BETWEEN COALESCE(TotalPayment,0) AND COALESCE(TotalPayment,0) + Payment