CREATE OR REPLACE VIEW do_live_order_tracking AS
SELECT
	co.OrderID,
	CONCAT (c.FirstName, ' ', c.LastName) AS CustomerName,
	co.Status,
	co.OrderDateTime,
	menu.Name AS DrinkName,
	oi.Quantity
FROM CUSTOMER_ORDER AS co
INNER JOIN CUSTOMER AS c ON co.CustomerID = c.CustomerID
INNER JOIN ORDER_ITEM AS oi ON co.OrderID = oi.OrderID
INNER JOIN MENU_ITEM AS menu ON oi.MenuItemID = menu.MenuItemID
WHERE co.status = 'Pending';
-- ORDER BY CONCAT (c.FirstName, ' ', c.LastName AS Name, co.OrderDateTime, m.Name AS Name, co.Status;)

SELECT *
FROM do_live_order_tracking
ORDER BY OrderDateTime, OrderID, DrinkName;
