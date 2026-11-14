-- QUERY 3
SELECT
    DATE(p.PaymentDateTime) AS Pay_Date,
    SUM(p.Amount) AS DailyRevenue,
    SUM(SUM(p.Amount)) OVER (
        ORDER BY DATE(p.PaymentDateTime)
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeRevenue
FROM PAYMENT AS p
GROUP BY DATE(p.PaymentDateTime)
ORDER BY Pay_Date;
