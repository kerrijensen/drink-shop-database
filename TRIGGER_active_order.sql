CREATE TRIGGER active_order
ON EMPLOYEE
WHILE CUSTOMER_ORDER.Status = "Pending"
WHERE CUSTOMER_ORDER.EmployeeID = EMPLOYEE.EmployeeID
BEFORE DELETE
AS
BEGIN
	"This employee is creating an order. Please do not fire them.";
	ROLLBACK;
END;

-- Makes it so an employee cannot be fired while in the middle of an order. In this job you finish things out and stick to them
