CREATE DATABASE IF NOT EXISTS projeTest;
USE projeTest;

CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(100),
    amount DECIMAL(10, 2),
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE IF NOT EXISTS Orders_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    operation_type VARCHAR(10),
    order_id INT,
    customer_id INT,
    product VARCHAR(100),
    amount DECIMAL(10, 2),
    status VARCHAR(50),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_processed TINYINT DEFAULT 0 
);

DELIMITER $$ -- bitiş işaretini ; yerine $$ yaptık
CREATE TRIGGER after_order_insert
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Orders_Log (operation_type, order_id, customer_id, product, amount, status)
    VALUES ('INSERT', NEW.order_id, NEW.customer_id, NEW.product, NEW.amount, NEW.status);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER after_order_update
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Orders_Log (operation_type, order_id, customer_id, product, amount, status)
    VALUES ('UPDATE', NEW.order_id, NEW.customer_id, NEW.product, NEW.amount, NEW.status);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER after_order_delete
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Orders_Log (operation_type, order_id, customer_id, product, amount, status)
    VALUES ('DELETE', OLD.order_id, OLD.customer_id, OLD.product, OLD.amount, OLD.status);
END$$
DELIMITER ;
