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

-- Additional customers:
-- Avery has no orders; Sam is another employee purchaser.
INSERT INTO CUSTOMER
    (CustomerID, FirstName, LastName, EmployeeID)
VALUES
    (6, 'Avery', 'Chen', NULL),
    (7, 'Sam', 'Wilson', 3);

-- Additional orders across multiple dates.
INSERT INTO CUSTOMER_ORDER
    (OrderID, CustomerID, EmployeeID, OrderDateTime, Status)
VALUES
    (6, 1, 2, '2026-11-09 08:00:00', 'Completed'),
    (7, 2, 3, '2026-11-09 08:15:00', 'Completed'),
    (8, 4, 2, '2026-11-09 09:00:00', 'Completed'),
    (9, 1, 3, '2026-11-09 10:00:00', 'Completed'),
    (10, 3, 3, '2026-11-09 10:30:00', 'Completed'),
    (11, 5, 2, '2026-11-10 08:00:00', 'Completed'),
    (12, 4, 3, '2026-11-10 09:00:00', 'Completed'),
    (13, 2, 2, '2026-11-10 10:00:00', 'Completed'),
    (14, 1, 3, '2026-11-07 08:00:00', 'Completed'),
    (15, 5, 2, '2026-11-11 08:00:00', 'Completed'),
    (16, 4, 3, '2026-11-11 09:00:00', 'Completed'),
    (17, 2, 2, '2026-11-11 10:00:00', 'Completed'),
    (18, 7, 2, '2026-11-11 10:30:00', 'Completed'),
    (19, 1, 3, '2026-11-12 08:00:00', 'Completed'),
    (20, 5, 2, '2026-11-12 09:00:00', 'Completed'),
    (21, 2, 3, '2026-11-12 10:00:00', 'Completed'),
    (22, 4, 2, '2026-11-12 10:15:00', 'Pending'),
    (23, 5, 3, '2026-11-12 10:20:00', 'Cancelled'),
    (24, 1, 2, '2026-11-12 10:25:00', 'Pending'),
    (25, 2, 3, '2026-11-12 10:30:00', 'Cancelled');

INSERT INTO ORDER_ITEM
    (OrderID, MenuItemID, Quantity, UnitPrice)
VALUES
    (6, 1, 2, 3.00),
    (6, 2, 1, 4.50),
    (7, 4, 2, 2.50),
    (7, 5, 1, 3.00),
    (8, 6, 2, 2.00),
    (8, 7, 3, 2.00),
    (9, 2, 3, 4.50),

    -- Free employee latte.
    (10, 2, 1, 0.00),

    (11, 1, 3, 3.00),
    (11, 4, 1, 2.50),
    (12, 6, 1, 2.00),
    (12, 7, 2, 2.00),
    (13, 5, 2, 3.00),

    -- Historical latte price differs from today's menu price.
    (14, 2, 2, 4.00),

    (15, 1, 1, 3.00),
    (15, 2, 2, 4.50),
    (16, 6, 1, 2.00),
    (17, 4, 4, 2.50),
    (17, 5, 1, 3.00),

    -- Free employee tea.
    (18, 5, 1, 0.00),

    (19, 1, 2, 3.00),
    (20, 2, 1, 4.50),
    (20, 4, 1, 2.50),
    (21, 1, 1, 3.00),
    (21, 5, 1, 3.00),

    -- Pending and cancelled items must not count as sales.
    (22, 2, 2, 4.50),
    (23, 8, 2, 2.50),
    (24, 4, 1, 2.50),
    (25, 6, 5, 2.00);

-- Payments match completed order totals.
-- Pending and cancelled orders have no payments.
INSERT INTO PAYMENT
    (PaymentID, OrderID, Amount, PaymentMethod, PaymentDateTime)
VALUES
    (4, 6, 10.50, 'Card', '2026-11-09 08:02:00'),
    (5, 7, 8.00, 'Cash', '2026-11-09 08:17:00'),
    (6, 8, 10.00, 'Card', '2026-11-09 09:02:00'),
    (7, 9, 13.50, 'Card', '2026-11-09 10:02:00'),
    (8, 10, 0.00, 'Employee', '2026-11-09 10:32:00'),
    (9, 11, 11.50, 'Cash', '2026-11-10 08:02:00'),
    (10, 12, 6.00, 'Card', '2026-11-10 09:02:00'),
    (11, 13, 6.00, 'Cash', '2026-11-10 10:02:00'),
    (12, 14, 8.00, 'Card', '2026-11-07 08:02:00'),
    (13, 15, 12.00, 'Card', '2026-11-11 08:02:00'),
    (14, 16, 2.00, 'Cash', '2026-11-11 09:02:00'),
    (15, 17, 13.00, 'Card', '2026-11-11 10:02:00'),
    (16, 18, 0.00, 'Employee', '2026-11-11 10:32:00'),
    (17, 19, 6.00, 'Cash', '2026-11-12 08:02:00'),
    (18, 20, 7.00, 'Card', '2026-11-12 09:02:00'),
    (19, 21, 6.00, 'Cash', '2026-11-12 10:02:00');