-- Reset project tables before rebuilding.
-- This deletes existing records in these seven tables.

DROP TABLE IF EXISTS PAYMENT;
DROP TABLE IF EXISTS ORDER_ITEM;
DROP TABLE IF EXISTS CUSTOMER_ORDER;
DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS MENU_ITEM;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS CATEGORY;

CREATE TABLE CATEGORY ( 
    CategoryID INT AUTO_INCREMENT PRIMARY KEY, -- assigns each category unique ID automatically
    CategoryName VARCHAR(50) NOT NULL, -- requires category name, up to 50 chars
    CONSTRAINT uq_category_name UNIQUE (CategoryName) -- prevents duplicate category names
);

CREATE TABLE MENU_ITEM (
    MenuItemID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255),
    Price DECIMAL(8,2) NOT NULL, -- stores correct dec. prices
    IsAvailable BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT chk_menu_price CHECK (Price >= 0), -- no negative prices
    CONSTRAINT chk_menu_available CHECK (IsAvailable IN (0, 1)),

    CONSTRAINT fk_menu_category
        FOREIGN KEY (CategoryID)
        REFERENCES CATEGORY(CategoryID)
        ON DELETE RESTRICT -- dont let it delete if the category is referenced
        ON UPDATE CASCADE -- updates drink references if category ID changes
);

CREATE TABLE EMPLOYEE (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    JobTitle VARCHAR(50) NOT NULL,
    ManagerID INT,

    CONSTRAINT fk_employee_manager
        FOREIGN KEY (ManagerID)
        REFERENCES EMPLOYEE(EmployeeID)
        ON DELETE SET NULL
        ON UPDATE RESTRICT
);

CREATE TABLE CUSTOMER (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    EmployeeID INT,

    CONSTRAINT uq_customer_employee UNIQUE (EmployeeID),

    CONSTRAINT fk_customer_employee
        FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEE(EmployeeID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE CUSTOMER_ORDER (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    OrderDateTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) NOT NULL DEFAULT 'Pending',

    CONSTRAINT chk_order_status
        CHECK (Status IN ('Pending', 'Completed', 'Cancelled')),

    CONSTRAINT fk_order_customer
        FOREIGN KEY (CustomerID)
        REFERENCES CUSTOMER(CustomerID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_order_employee
        FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEE(EmployeeID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE ORDER_ITEM (
    OrderID INT NOT NULL,
    MenuItemID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(8,2) NOT NULL,

    PRIMARY KEY (OrderID, MenuItemID),

    CONSTRAINT chk_order_item_quantity CHECK (Quantity > 0),
    CONSTRAINT chk_order_item_price CHECK (UnitPrice >= 0),

    CONSTRAINT fk_order_item_order
        FOREIGN KEY (OrderID)
        REFERENCES CUSTOMER_ORDER(OrderID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_order_item_menu
        FOREIGN KEY (MenuItemID)
        REFERENCES MENU_ITEM(MenuItemID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE PAYMENT (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    Amount DECIMAL(8,2) NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    PaymentDateTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_payment_order UNIQUE (OrderID),

    CONSTRAINT chk_payment_amount CHECK (Amount >= 0),

    CONSTRAINT chk_payment_method
        CHECK (PaymentMethod IN ('Cash', 'Card', 'Employee')),

    CONSTRAINT fk_payment_order
        FOREIGN KEY (OrderID)
        REFERENCES CUSTOMER_ORDER(OrderID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);