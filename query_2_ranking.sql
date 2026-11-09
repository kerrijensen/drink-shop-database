SELECT
    c.CategoryName, -- in CATEGORY
    m.Name AS DrinkName, -- name in MENU_ITEM
    SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue, -- oi is ORDER_ITEM
    DENSE_RANK() OVER ( 
        PARTITION BY c.CategoryID -- in CATEGORY
        ORDER BY SUM(oi.Quantity * oi.UnitPrice) DESC
    ) AS RankInCategory
FROM CATEGORY AS c
INNER JOIN MENU_ITEM AS m
    ON c.CategoryID = m.CategoryID
INNER JOIN ORDER_ITEM AS oi
    ON m.MenuItemID = oi.MenuItemID
GROUP BY
    c.CategoryID,
    c.CategoryName,
    m.MenuItemID,
    m.Name
ORDER BY
    c.CategoryName,
    RankInCategory,
    m.Name;