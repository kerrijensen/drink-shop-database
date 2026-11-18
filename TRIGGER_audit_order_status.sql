CREATE TABLE IF NOT EXISTS ORDER_STATUS_AUDIT (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    OldStatus VARCHAR(20) NOT NULL,
    NewStatus VARCHAR(20) NOT NULL,
    ChangedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

-- Remove the earlier version so each status change is logged once.
DROP TRIGGER IF EXISTS we_like_money;
DROP TRIGGER IF EXISTS audit_order_status;

DELIMITER $$

CREATE TRIGGER audit_order_status
AFTER UPDATE ON CUSTOMER_ORDER
FOR EACH ROW
BEGIN
    IF OLD.Status <> NEW.Status THEN
        INSERT INTO ORDER_STATUS_AUDIT (OrderID, OldStatus, NewStatus)
        VALUES (NEW.OrderID, OLD.Status, NEW.Status);
    END IF;
END$$

DELIMITER ;

-- CREATE TRIGGER we_like_money
-- on DATABASE
-- FOR CREATE_TABLE, DROP_TABLE
-- AS
-- BEGIN
-- 	PRINT 'Stop messing with our stuff please';
-- 	ROLLBACK;
-- END;
