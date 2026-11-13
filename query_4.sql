-- Project-defined target: payment recorded within 180 seconds. (3 mins)
-- Measures order-to-payment time, not drink preparation time.

SELECT
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    COUNT(*) AS CompletedOrders,

    SUM(CASE
        WHEN p.PaymentID IS NOT NULL
         AND TIMESTAMPDIFF(
             SECOND, co.OrderDateTime, p.PaymentDateTime
         ) BETWEEN 0 AND 180
        THEN 1 ELSE 0
    END) AS WithinTarget,

    SUM(CASE
        WHEN TIMESTAMPDIFF(
            SECOND, co.OrderDateTime, p.PaymentDateTime
        ) > 180
        THEN 1 ELSE 0
    END) AS LatePayments,

    SUM(CASE
        WHEN p.PaymentID IS NULL
        THEN 1 ELSE 0
    END) AS MissingPayments,

    SUM(CASE
        WHEN p.PaymentDateTime < co.OrderDateTime
        THEN 1 ELSE 0
    END) AS InvalidPaymentTimes,

    ROUND(
        100.0 * SUM(CASE
            WHEN p.PaymentID IS NOT NULL
             AND TIMESTAMPDIFF(
                 SECOND, co.OrderDateTime, p.PaymentDateTime
             ) BETWEEN 0 AND 180
            THEN 1 ELSE 0
        END) / COUNT(*),
        2
    ) AS WithinTargetPercentage

FROM EMPLOYEE AS e
INNER JOIN CUSTOMER_ORDER AS co
    ON e.EmployeeID = co.EmployeeID
INNER JOIN CUSTOMER AS c
    ON co.CustomerID = c.CustomerID
LEFT JOIN PAYMENT AS p
    ON co.OrderID = p.OrderID

WHERE co.Status = 'Completed'

GROUP BY
    e.EmployeeID,
    e.FirstName,
    e.LastName

ORDER BY
    WithinTargetPercentage DESC,
    e.EmployeeID;