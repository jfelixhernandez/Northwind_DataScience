USE NORTHWIND2015;
GO

-- VERIFY IF PROCEDURE EXIST, IF SO DELETED AND CREATED AGAIN

IF OBJECT_ID('Sp_Get_Historical_Purchases') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].Sp_Get_Historical_Purchases
END
GO

CREATE PROCEDURE dbo.Sp_Get_Historical_Purchases
AS 
-- TEMPLATE
GO


/********************************************************************************************* 
Author: Tony  
   Date: 07.04.2020
   Description: this code creates the Historical purchase information 
   History:
   07.04.2020 nw007- Sp_get_Historical_Purchases for HistoricalPurchases
**********************************************************************************************/
ALTER PROCEDURE Sp_Get_Historical_Purchases 
AS 
BEGIN

IF OBJECT_ID('HistoricalPurchases') IS NOT NULL BEGIN
	DROP TABLE [dbo].[HistoricalPurchases]
END


SELECT C.CategoryName, P.ProductName, O.ShipCountry, O.ShipRegion, S.CompanyName as Supplier_Company, S.Country AS Supplier_Country, 
	CU.CompanyName AS CUSTOMER_COMPANY, CU.Country AS CUSTOMER_COUNTRY, CU.City AS CUSTOMER_CITY, CU.Region AS CUSTOMER_REGION, 
	YEAR(O.OrderDate) AS [YEAR], MONTH(O.OrderDate) AS [MONTH], DATEPART(WK,O.OrderDate) AS [WEEK],  
	OD.OrderID, OD.Quantity, OD.ProductID,BP.MaxPrice, OD.UnitPrice, OD.Discount, 
	SUM(OD.UnitPrice-OD.Discount) AS PRODUCT_TOTAL,
	SUM(OD.UnitPrice*OD.Quantity) AS Product_Before_Discount, SUM(OD.Discount*OD.Quantity) AS Total_Discount, 
	SUM((OD.UnitPrice*OD.Quantity)-(OD.Discount*OD.Quantity)) AS Total_After_Discount, SUM(OD.UnitPrice-BP.MaxPrice) AS SAVINGSper_disc_not_included, 
	SUM(OD.UnitPrice-BP.MaxPrice-od.Discount) AS SAVINGSPER_W_DISCOUNT, SUM((OD.UnitPrice-BP.MaxPrice-od.Discount)*OD.Quantity) AS NET_SAVINGS
INTO [dbo].[HistoricalPurchases]
FROM [dbo].[OrderDetails] AS OD 
	JOIN [dbo].[Orders] AS O ON OD.OrderID=O.OrderID
	JOIN [DBO].[BaselinePrices] AS BP ON YEAR(O.OrderDate)=YEAR(BP.BaselineDate) 
		AND OD.ProductID=BP.ProductID
	JOIN [dbo].[Products] AS p ON OD.ProductID=P.ProductID
	JOIN [dbo].[Categories] AS C ON C.CategoryID=P.CategoryID
	JOIN [dbo].[Suppliers] AS S ON P.SupplierID=S.SupplierID
	JOIN [dbo].[Customers] AS CU ON O.CustomerID=CU.CustomerID
GROUP BY OD.OrderID , OD.UnitPrice, OD.Quantity, OD.Discount, OD.Discount, OD. ProductID, BP.MaxPrice, C.CategoryName, P.ProductName, 
	O.ShipCountry, O.ShipRegion, S.CompanyName, S.Country, CU.CompanyName, CU.Country, CU.City, CU.Region,
	YEAR(O.OrderDate), MONTH(O.OrderDate), DATEPART(WK,O.OrderDate)
--ORDER BY OD.ProductID, OD.OrderID
END
