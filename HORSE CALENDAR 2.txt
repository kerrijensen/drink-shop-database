CREATE PROCEDURE `3.1 Printable Multi-Table Receipt Report` ()
BEGIN
SELECT CO.OrderID, CONCAT (CUSTOMER.FirstName, ' ', CUSTOMER.LastName) AS Name, CO.OrderDateTime, PAYMENT.Amount
FROM CUSTOMER_ORDER CO
INNER JOIN ORDER_ITEM Item ON PAYMENT.OrderID = Item.OrderID
LEFT JOIN CO ON CO.OrderID = EMPLOYEE.EmployeeID;
CASE
	WHEN CO.CustomerID = EMPLOYEE.EmployeeID THEN Payment.Amount = 0
    END AS Payment.Amount
;
END
