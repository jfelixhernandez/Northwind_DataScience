USE NORTHWIND2015;
GO

-- VERIFY IF PROCEDURE EXIST, IF SO DELETED AND CREATED AGAIN

IF OBJECT_ID('Sp_get_baselines') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].Sp_get_baselines
END
GO

CREATE PROCEDURE Sp_get_baselines
AS 
-- TEMPLATE
GO


/********************************************************************************************* 
Author: Duwani  
   Date: 07.04.2020
   Description: this code creates the Baseline Prices per product per supplier for all years 
   History:
   07.04.2020 nw006- Sp_get_baselines for BaselinePrices
**********************************************************************************************/
ALTER PROCEDURE Sp_get_baselines 
AS 
BEGIN

IF OBJECT_ID('BaselinePrices') IS NOT NULL BEGIN
DROP TABLE [dbo].[BaselinePrices]
END

SELECT SUP.SupplierID,SUP.ContactName, P.ProductID, P.ProductName, YEAR(O.OrderDate) AS Year,
MAX (O.OrderDate) AS BaselineDate, MAX (P.UnitPrice) AS MaxPrice
INTO [dbo].[BaselinePrices]
FROM [dbo].[Products] AS P
INNER JOIN [dbo].[Suppliers] AS SUP ON SUP.SupplierID=P.SupplierID
INNER JOIN [dbo].[OrderDetails] AS OD ON OD.ProductID=P.ProductID
INNER JOIN [dbo].[Orders] AS O ON O.OrderID=OD.OrderID
GROUP BY  SUP.SupplierID,SUP.ContactName, P.ProductID, P.ProductName,YEAR(O.OrderDate)
END

