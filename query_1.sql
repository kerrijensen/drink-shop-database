SELECT
    co.OrderID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    co.OrderDateTime,
    co.Status,
    m.Name as DrinkName,
    oi.Quantity,
    oi.UnitPrice,
    oi.Quantity * oi.UnitPrice AS LineTotal,
    p.Amount AS OrderPaymentAmount,
    COALESCE(p.PaymentMethod, 'Not recorded') AS PaymentMethod

FROM CUSTOMER_ORDER AS co
INNER JOIN CUSTOMER AS c    
    ON co.CustomerID = c.CustomerID
INNER JOIN ORDER_ITEM AS oi
    ON co.OrderID = oi.OrderID
INNER JOIN MENU_ITEM AS m
    ON oi.MenuItemID = m.MenuItemID
LEFT JOIN PAYMENT AS p -- includes orders even w/o payment
    ON co.OrderID = p.OrderID
ORDER BY co.OrderID, m.MenuItemID;
