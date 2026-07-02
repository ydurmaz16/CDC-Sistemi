USE projeTest;

INSERT INTO Customers (name, email) VALUES 
('Adem Elma', 'adem@mail.com'),
('Sude Deniz', 'sude@mail.com');

INSERT INTO Orders (customer_id, product, amount, status) VALUES 
(9, 'Ekran', 3000.00, 'Onay Bekliyor'),
(9, 'Kutu', 250.00, 'Hazirlaniyor'),
(10, 'Saat', 4000.00, 'Hazirlaniyor'),
(10, 'Lamba', 500.00, 'Kargolandi');

UPDATE Orders SET status = 'Hazirlaniyor' WHERE product = 'Ekran';
UPDATE Orders SET status = 'Kargolandi' WHERE product = 'Saat';
UPDATE Orders SET amount = 200.00 WHERE product = 'Kutu'; 

DELETE FROM Orders WHERE product = 'Saat';
DELETE FROM Orders WHERE product = 'Lamba';
