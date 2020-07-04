-- BROKEN DOWN PER ORDER AND PRODUCT 
SELECT OD.OrderID, OD.Quantity, OD.ProductID , OD.UnitPrice, OD.Discount,(OD.UnitPrice-OD.Discount) AS PRODUCT_TOTAL  ,(OD.UnitPrice*OD.Quantity) AS Product_Before_Discount, 
(OD.Discount*OD.Quantity) AS Total_Discount, ((OD.UnitPrice*OD.Quantity)-(OD.Discount*OD.Quantity)) AS Total_After_Discount, O.OrderDate
FROM [dbo].[OrderDetails] AS OD 
JOIN [dbo].[Orders] AS O ON OD.OrderID=O.OrderID
GROUP BY OD.OrderID , OD.UnitPrice, OD.Quantity, OD.Discount, OD.Discount, OD. ProductID, O.OrderDate
ORDER BY OD.ProductID, OD.OrderID 

-- BROKEN DOWN PER ORDER
SELECT OD.OrderID, SUM((OD.UnitPrice*OD.Quantity)-(OD.Discount*OD.Quantity)) AS Total_After_Discount, SUM(OD.Discount*OD.Quantity) AS TOTAL_DISCOUNT,
SUM(OD.UnitPrice*OD.Quantity) AS TOTAL_BEFORE_DISCOUNT
FROM [dbo].[OrderDetails] AS OD
GROUP BY OD.OrderID




SELECT *
FROM [dbo].[Orders]


