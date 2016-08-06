/*
 * http://sqlandme.com/2011/04/27/tsql-concatenate-rows-using-for-xml-path/
 */
 
 USE AdventureWorks

SELECT      CAT.Name AS [Category],
            SUB.Name AS [Sub Category]
FROM        Production.ProductCategory CAT
INNER JOIN  Production.ProductSubcategory SUB
            ON CAT.ProductCategoryID = SUB.ProductCategoryID
            
--We can achieve this by using FOR XML PATH(), the above query needs to be modified to concatenate the rows:          

--USE AdventureWorks2012

SELECT      CAT.Name AS [Category],
            STUFF((    SELECT ',' + SUB.Name AS [text()]
                        -- Add a comma (,) before each value
                        FROM Production.ProductSubcategory SUB
                        WHERE
                        SUB.ProductCategoryID = CAT.ProductCategoryID
                        FOR XML PATH('') -- Select it as XML
                        ), 1, 1, '' )
                        -- This is done to remove the first character (,) from the result
            AS [Sub Categories]
FROM  Production.ProductCategory CAT  