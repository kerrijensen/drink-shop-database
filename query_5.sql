-- query 5
-- buy five drinks (customer only), get one free
-- not by transaction, but by number of drinks purchased

WITH CustomerPurchases AS (
    SELECT
        c.CustomerID,
        COALESCE(SUM(oi.Quantity), 0) AS PaidDrinks,
        COALESCE(SUM(oi.Quantity * oi.UnitPrice), 0.00) AS DrinkRevenue
    FROM CUSTOMER AS c
    LEFT JOIN CUSTOMER_ORDER AS co
        ON co.CustomerID = c.CustomerID
        AND co.Status = 'Completed'
    LEFT JOIN ORDER_ITEM AS oi
        ON oi.OrderID = co.OrderID
        AND oi.UnitPrice > 0
    WHERE c.EmployeeID IS NULL
    GROUP BY c.CustomerID
),
CustomerRewards AS (
    SELECT
        PaidDrinks,
        DrinkRevenue,
        PaidDrinks DIV 5 AS RewardsEarned,
        CASE
            WHEN PaidDrinks >= 5 THEN 'Reward Earned'
            WHEN PaidDrinks > 0 THEN 'In Progress'
            ELSE 'No Paid Drinks'
        END AS RewardStatus
    FROM CustomerPurchases
)
SELECT
    RewardStatus,
    COUNT(*) AS TotalCustomers,
    SUM(PaidDrinks) AS TotalPaidDrinks,
    SUM(RewardsEarned) AS TotalRewardsEarned,
    SUM(DrinkRevenue) AS TotalDrinkRevenue
FROM CustomerRewards
GROUP BY RewardStatus
ORDER BY TotalDrinkRevenue DESC;
