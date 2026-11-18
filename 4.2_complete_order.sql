DROP PROCEDURE IF EXISTS sp_complete_order;

DELIMITER $$

CREATE PROCEDURE sp_complete_order(
    IN p_order_id INT,
    IN p_payment_method VARCHAR(20),
    OUT p_status_code INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_order_status VARCHAR(20) DEFAULT NULL;
    DECLARE v_customer_id INT;
    DECLARE v_amount DECIMAL(8, 2);
    DECLARE v_payment_method VARCHAR(20);
    DECLARE v_condition_count INT;

    -- If any SQL error occurs, undo the checkout and return the error.
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET STACKED DIAGNOSTICS v_condition_count = NUMBER;
        GET STACKED DIAGNOSTICS CONDITION v_condition_count
            p_message = MESSAGE_TEXT;
        ROLLBACK;
        SET p_status_code = 1;
    END;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_order_status = NULL;

    START TRANSACTION;

    -- Read and lock this order until COMMIT or ROLLBACK.
    SELECT Status, CustomerID
    INTO v_order_status, v_customer_id
    FROM CUSTOMER_ORDER
    WHERE OrderID = p_order_id
    FOR UPDATE;

    IF v_order_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order does not exist.';
    ELSEIF v_order_status <> 'Pending' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order is no longer pending.';
    END IF;

    -- Use the prices stored on the order.
    SELECT SUM(Quantity * UnitPrice)
    INTO v_amount
    FROM ORDER_ITEM
    WHERE OrderID = p_order_id;

    IF v_amount IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order has no items.';
    END IF;

    -- Check whether the customer is an employee making a purchase.
    SET v_payment_method = p_payment_method;

    IF EXISTS (
        SELECT 1
        FROM CUSTOMER
        WHERE CustomerID = v_customer_id AND EmployeeID IS NOT NULL
    ) THEN
        SET v_amount = 0.00;
        SET v_payment_method = 'Employee';
    ELSEIF p_payment_method IS NULL OR p_payment_method NOT IN ('Cash', 'Card') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Use Cash or Card for this order.';
    END IF;

    INSERT INTO PAYMENT (OrderID, Amount, PaymentMethod)
    VALUES (p_order_id, v_amount, v_payment_method);

    UPDATE CUSTOMER_ORDER
    SET Status = 'Completed'
    WHERE OrderID = p_order_id;

    COMMIT;

    SET p_status_code = 0;
    SET p_message = 'Order completed.';
END$$

DELIMITER ;