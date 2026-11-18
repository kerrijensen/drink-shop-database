DROP TRIGGER IF EXISTS active_order;

DELIMITER $$

CREATE TRIGGER active_order
BEFORE DELETE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM CUSTOMER_ORDER
        WHERE EmployeeID = OLD.EmployeeID
          AND Status = 'Pending'
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot delete an employee with a pending order.';
    END IF;
END$$

DELIMITER ;


-- CREATE TRIGGER active_order
-- ON EMPLOYEE
-- WHILE CUSTOMER_ORDER.Status = "Pending"
-- WHERE CUSTOMER_ORDER.EmployeeID = EMPLOYEE.EmployeeID
-- BEFORE DELETE
-- AS
-- BEGIN
-- 	"This employee is creating an order. Please do not fire them.";
-- 	ROLLBACK;
-- END;

-- Makes it so an employee cannot be fired while in the middle of an order. In this job you finish things out and stick to them
