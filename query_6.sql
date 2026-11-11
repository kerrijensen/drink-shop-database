CREATE OR REPLACE VIEW do_live_order_tracking AS
SELECT
	CONCAT (cus.FirstName, ' ', cus.LastName AS Name,
	cus_ord.Status,
	cus_ord.OrderDateTime,
	menu.Name AS Name,
FROM CUSTOMER_ORDER cus_ord	
INNER JOIN CUSTOMER cus ON cus_ord.OrderID = cus.OrderID
INNER JOIN MENU_ITEM menu ON cus_ord.OrderID = menu.MenuItemID
ORDER BY CONCAT (cus.FirstName, ' ', cus.LastName AS Name, cus_ord.OrderDateTime, menu.Name AS Name, cus_ord.Status;
