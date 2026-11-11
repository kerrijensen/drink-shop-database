SELECT DATE(P.PaymentDateTime) AS Pay_Date, SUM(P.Amount) AS SUM(SUM(P.Amount)) OVER (ORDER BY DATE(P.PaymentDateTime) AS cumulative_rev
FROM PAYMENT P GROUP BY DATE(P.PaymentDateTime);
