-- Drop tables if they exist (in reverse order of creation to avoid foreign key constraints)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS delivery;
DROP TABLE IF EXISTS distributor;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS wine;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS employee;

-- Create tables
CREATE TABLE supplier (
    supplier_id INT NOT NULL AUTO_INCREMENT,
    supplier_name VARCHAR(75) NOT NULL,
    PRIMARY KEY(supplier_id)
);

CREATE TABLE wine (
    wine_id INT NOT NULL AUTO_INCREMENT,
    wine_name VARCHAR(75) NOT NULL,
    wine_sold INT NOT NULL DEFAULT 0,
    PRIMARY KEY(wine_id)
);

CREATE TABLE inventory (
    inventory_id INT NOT NULL AUTO_INCREMENT,
    inventory_name VARCHAR(75) NOT NULL,
    PRIMARY KEY(inventory_id)
);

CREATE TABLE distributor (
    distributor_id INT NOT NULL AUTO_INCREMENT,
    distributor_name VARCHAR(75) NOT NULL,
    PRIMARY KEY(distributor_id)
);

CREATE TABLE delivery (
    delivery_id INT NOT NULL AUTO_INCREMENT,
    distributor_id INT NOT NULL,
    supplier_id INT NOT NULL,
    delivery_name VARCHAR(75) NOT NULL,
    expected_date DATE NOT NULL,
    actual_date DATE NOT NULL,
    PRIMARY KEY(delivery_id),
    CONSTRAINT fk_distributor_delivery FOREIGN KEY(distributor_id) REFERENCES distributor(distributor_id),
    CONSTRAINT fk_supplier_delivery FOREIGN KEY(supplier_id) REFERENCES supplier(supplier_id)
);

CREATE TABLE orders (
    orders_id INT NOT NULL AUTO_INCREMENT,
    inventory_id INT NOT NULL,
    supplier_id INT NOT NULL,
    order_date DATE NOT NULL,
    delivery_id INT NOT NULL,
    wine_id INT NOT NULL,
    PRIMARY KEY(orders_id),
    CONSTRAINT fk_inventory_order FOREIGN KEY(inventory_id) REFERENCES inventory(inventory_id),
    CONSTRAINT fk_supplier_order FOREIGN KEY(supplier_id) REFERENCES supplier(supplier_id),
    CONSTRAINT fk_delivery_order FOREIGN KEY(delivery_id) REFERENCES delivery(delivery_id),
    CONSTRAINT fk_wine_order FOREIGN KEY(wine_id) REFERENCES wine(wine_id)
);

CREATE TABLE employee (
    employee_id INT NOT NULL AUTO_INCREMENT,
    employee_position VARCHAR(75) NOT NULL,
    employee_hours INT NOT NULL,
    employee_firstname VARCHAR(75) NOT NULL,
    employee_lastname VARCHAR(75) NOT NULL,
    PRIMARY KEY(employee_id)
);

CREATE TABLE department (
    department_id INT NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(75) NOT NULL,
    employee_id INT NOT NULL,
    PRIMARY KEY(department_id),
    CONSTRAINT fk_employee_department FOREIGN KEY(employee_id) REFERENCES employee(employee_id)
);

-- Insert sample data
INSERT INTO supplier (supplier_id, supplier_name) VALUES
(12133, 'Supplier A'),
(12134, 'Supplier B'),
(12135, 'Supplier C'),
(12136, 'Supplier D');

INSERT INTO wine (wine_id, wine_name, wine_sold) VALUES
(12096, 'Merlot', 42503),
(12097, 'Cabernet', 31907),
(12098, 'Chablis', 29999),
(12099, 'Chardonnay', 44856);

INSERT INTO inventory (inventory_id, inventory_name) VALUES
(12643, 'Inventory A'),
(12644, 'Inventory B'),
(12645, 'Inventory C'),
(12646, 'Inventory D'),
(12647, 'Inventory E');

-- Insert distributor records
INSERT INTO distributor (distributor_id, distributor_name) VALUES
(1, 'Wine Factions'),
(2, 'Best Wines'),
(3, 'The Wine Euporium'),
(4, 'Wine World');

-- Insert delivery records
INSERT INTO delivery (distributor_id, supplier_id, delivery_name, expected_date, actual_date) VALUES
(1, 12134, 'Black', '2024-09-15', '2024-09-13'),
(2, 12133, 'Smith', '2024-10-07', '2024-10-10'),
(3, 12135, 'Permudez', '2024-08-22', '2024-08-23'),
(4, 12136, 'Johnson', '2024-08-30', '2024-08-28'),
(1, 12134, 'Jimenez', '2024-08-23', '2024-08-19'),
(3, 12135, 'April', '2024-08-19', '2024-08-09'),
(2, 12133, 'Lund', '2024-09-05', '2024-09-05'),
(4, 12136, 'Garcia', '2024-09-10', '2024-09-12');

-- Insert orders
INSERT INTO orders (orders_id, inventory_id, supplier_id, order_date, delivery_id, wine_id) VALUES
(931, 12647, 12134, '2024-08-31', 1, 12096),
(935, 12643, 12133, '2024-09-30', 2, 12097),
(939, 12645, 12135, '2024-08-19', 3, 12098),
(940, 12646, 12136, '2024-08-25', 4, 12099),
(937, 12647, 12133, '2024-08-05', 5, 12099),
(936, 12647, 12135, '2024-08-04', 6, 12096),
(932, 12643, 12134, '2024-08-15', 7, 12097),
(941, 12644, 12136, '2024-09-01', 8, 12098);

-- Insert employee records
INSERT INTO employee (employee_id, employee_position, employee_hours, employee_firstname, employee_lastname) VALUES
    (24, 'Accounting Lead', 40, 'Janet', 'Collins'),
    (23, 'Marketing Department Head', 40, 'Roz', 'Murphy'),
    (22, 'Marketing Department assistant', 32, 'Bob', 'Ulrich'),
    (25, 'Production staff Lead', 38, 'Henry', 'Doyle'),
    (1, 'Production staff', 42, 'Jane', 'Doe'),
    (2, 'Production staff', 40, 'Mark', 'Garcia'),
    (3, 'Production staff', 16, 'Mark' , 'Twain'),
    (4, 'Production staff', 40, 'Lisa', 'Mcronald'),
    (5, 'Production staff', 40, 'Ralph', 'George'),
    (6, 'Production staff', 40, 'Sieana', 'Wrangler'),
    (7, 'Production staff', 40, 'Elizabeth', 'Gomez'),
    (8, 'Production staff', 45, 'Tyler', 'Scott'),
    (9, 'Production staff', 24, 'Tiffany', 'Huntson'),
    (10, 'Production staff', 40, 'Rachel', 'Sun'),
    (11, 'Production staff', 16, 'Besty', 'Elias'),
    (12, 'Production staff', 40, 'Odalys', 'Agurrie'),
    (13, 'Production staff', 40, 'Nathaniel', 'Huenemeyer'),
    (14, 'Production staff', 32, 'Myrna', 'Barajas'),
    (15, 'Production staff', 28, 'Tommy', 'Gonzales'),
    (16, 'Production staff', 32, 'Andrew', 'Gonzales'),
    (17, 'Production staff', 32, 'Janet', 'Jimenez'),
    (18, 'Production staff', 32, 'Roxie', 'Clingger'),
    (19, 'Production staff', 32, 'Sarah', 'Jones'),
    (20, 'Production staff', 32, 'Tish', 'Johnson'),
    (21, 'Distribution Lead', 40, 'Maria', 'Costanza');

-- Insert department records
INSERT INTO department (department_id, department_name, employee_id) VALUES
    (15672, 'Production', 25),
    (15692, 'Distribution', 21),
    (15620, 'Marketing', 23),
    (15646, 'Accounting', 24);

-- Additional INSERT statements to associate other employees with departments
INSERT INTO department (department_name, employee_id)
SELECT 'Production', employee_id FROM employee WHERE employee_position = 'Production staff';

INSERT INTO department (department_name, employee_id)
SELECT 'Marketing', employee_id FROM employee WHERE employee_position = 'Marketing Department assistant';