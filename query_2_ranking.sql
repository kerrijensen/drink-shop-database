SELECT
    c.CategoryName,
    m.Name AS DrinkName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue,
    DENSE_RANK() OVER (
        PARTITION BY c.CategoryID
        ORDER BY SUM(oi.Quantity * oi.UnitPrice) DESC
    ) AS RankInCategory
FROM CATEGORY AS c
INNER JOIN MENU_ITEM AS m
    ON c.CategoryID = m.CategoryID
INNER JOIN ORDER_ITEM AS oi
    ON m.MenuItemID = oi.MenuItemID
INNER JOIN CUSTOMER_ORDER AS co
    ON oi.OrderID = co.OrderID
WHERE co.Status = 'Completed'
GROUP BY
    c.CategoryID,
    c.CategoryName,
    m.MenuItemID,
    m.Name
ORDER BY
    c.CategoryName,
    RankInCategory,
    m.Name;