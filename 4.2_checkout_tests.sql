-- Section 2 execution verification
CALL sp_complete_order(4, 'Card', @status_code, @message);
SELECT @status_code AS StatusCode, @message AS Message;

SELECT co.OrderID, co.Status, p.Amount, p.PaymentMethod
FROM CUSTOMER_ORDER AS co
LEFT JOIN PAYMENT AS p ON p.OrderID = co.OrderID
WHERE co.OrderID = 4;