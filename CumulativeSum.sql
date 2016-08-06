/*
 * http://social.msdn.microsoft.com/Forums/sqlserver/en-US/29b83c4e-3052-4b2a-a8d7-21042bcf05ce/efficient-cumulative-sum-calculation
 */
 
 DECLARE @TestPurchases AS TABLE (
 	CustomerID INT,
 	ProductID INT,
 	PurchaseOrderID INT,
 	Quantity INT
 )
 
insert @TestPurchases
values  (1, 1, 1, 12),
        (1, 1, 2, 67),
        (1, 1, 3, 12),
        (1, 2, 1, 7),
        (1, 2, 2, 65),
        (1, 2, 3, 48),
        (2, 2, 1, 20),
        (2, 2, 2, 29),
        (2, 2, 3, 24),
        (2, 2, 4, 32),
        (2, 3, 1, 12),
        (2, 3, 2, 88),
        (2, 3, 3, 19)
        
SELECT 
	dt.CustomerID, 
	dt.ProductID, 
	dt.PurchaseOrderID, 
	dt.Quantity,
	SUM(dt.Quantity) OVER (PARTITION BY dt.CustomerID,dt.ProductID ORDER BY PurchaseOrderID ROWS unbounded preceding) AS CumulativeTotal 
FROM @TestPurchases AS dt