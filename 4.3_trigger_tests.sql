--active_order test
-- section 1 of part 3
SELECT OrderID, EmployeeID, Status
FROM CUSTOMER_ORDER
WHERE EmployeeID = 2 AND Status = 'Pending';

START TRANSACTION;

-- cannot delete employee with an active order
DELETE FROM EMPLOYEE WHERE EmployeeID = 2;

ROLLBACK;


-- audit_order_status test
-- section 2 of part 3
START TRANSACTION;

UPDATE CUSTOMER_ORDER
SET Status = 'Cancelled'
WHERE OrderID = 22 AND Status = 'Pending';

SELECT OrderID, OldStatus, NewStatus
FROM ORDER_STATUS_AUDIT
WHERE OrderID = 22
ORDER BY AuditID DESC;

ROLLBACK;
