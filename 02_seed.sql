-- Categories must exist before their menu items.
INSERT INTO CATEGORY (CategoryID, CategoryName)
VALUES
    (1, 'Coffee'),
    (2, 'Tea'),
    (3, 'Soda');

-- Include one unavailable drink to represent a sold-out item.
INSERT INTO MENU_ITEM
    (MenuItemID, CategoryID, Name, Description, Price, IsAvailable)
VALUES
    (1, 1, 'Americano', 'Espresso with hot water', 3.00, TRUE),
    (2, 1, 'Latte', 'Espresso with steamed milk', 4.50, TRUE),
    (3, 1, 'Mocha', 'Espresso with chocolate and milk', 5.00, FALSE),
    (4, 2, 'Black Tea', 'Hot black tea', 2.50, TRUE),
    (5, 2, 'Iced Green Tea', 'Green tea served over ice', 3.00, TRUE),
    (6, 3, 'Diet Coke', 'Classic diet coke soda', 2.00, TRUE),
    (7, 3, 'Dr. Pepper', 'Classic dr. pepper soda', 2.00, TRUE),
    (8, 3, 'Root Beer', 'Classic root beer', 2.50, TRUE);

    -- Employees: one manager and two baristas.
INSERT INTO EMPLOYEE
    (EmployeeID, FirstName, LastName, JobTitle, ManagerID)
VALUES
    (1, 'Alex', 'Rivera', 'Manager', NULL);

INSERT INTO EMPLOYEE
    (EmployeeID, FirstName, LastName, JobTitle, ManagerID)
VALUES
    (2, 'Jordan', 'Lee', 'Barista', 1),
    (3, 'Sam', 'Wilson', 'Barista', 1);

-- Jordan also has a customer record for employee purchases.
INSERT INTO CUSTOMER
    (CustomerID, FirstName, LastName, EmployeeID)
VALUES
    (1, 'Taylor', 'Brown', NULL),
    (2, 'Morgan', 'Davis', NULL),
    (3, 'Jordan', 'Lee', 2),
    (4, 'Casey', 'Garcia', NULL),
    (5, 'Riley', 'Smith', NULL);

INSERT INTO CUSTOMER_ORDER
    (OrderID, CustomerID, EmployeeID, OrderDateTime, Status)
VALUES
    (1, 1, 2, '2026-11-08 09:00:00', 'Completed'),
    (2, 2, 3, '2026-11-08 09:15:00', 'Completed'),
    (3, 3, 3, '2026-11-08 09:30:00', 'Completed'),
    (4, 4, 2, '2026-11-08 09:45:00', 'Pending'),
    (5, 5, 2, '2026-11-08 10:00:00', 'Cancelled');

-- Prices reflect what was charged at the time of ordering.
INSERT INTO ORDER_ITEM
    (OrderID, MenuItemID, Quantity, UnitPrice)
VALUES
    (1, 1, 1, 3.00),
    (1, 2, 2, 4.50),
    (2, 4, 1, 2.50),
    (2, 6, 1, 2.00),
    (3, 2, 1, 0.00),
    (4, 5, 2, 3.00),
    (5, 8, 1, 2.50);

-- Only completed orders have payment records in this dataset.
INSERT INTO PAYMENT
    (PaymentID, OrderID, Amount, PaymentMethod, PaymentDateTime)
VALUES
    (1, 1, 12.00, 'Card', '2026-11-08 09:02:00'),
    (2, 2, 4.50, 'Cash', '2026-11-08 09:17:00'),
    (3, 3, 0.00, 'Employee', '2026-11-08 09:32:00');