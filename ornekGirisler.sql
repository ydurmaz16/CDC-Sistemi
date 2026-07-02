USE projeTest;

-- Customers
INSERT INTO Customers (name, email) VALUES 
('Yigit Durmaz', 'yigit@mail.com'),
('Sila Tekin', 'sila@mail.com'),
('Mehmet Demir', 'mehmet@mail.com'),
('Zeynep Celik', 'zeynep@mail.com'),
('Can Duygu', 'can@mail.com');

-- INSERT
INSERT INTO Orders (customer_id, product, amount, status) VALUES 
(1, 'Laptop', 35000.00, 'Onay Bekliyor'),
(1, 'Mouse', 750.00, 'Onay Bekliyor'),
(1, 'Akilli Saat', 5000.00, 'Teslim Edildi'),
(2, 'Kulaklik', 1300.00, 'Onay Bekliyor'),
(2, 'Monitor', 4500.00, 'Hazirlaniyor'),
(3, 'Klavye', 1000.00, 'Kargolandi'),
(3, 'Kulaklik', 1200.00, 'Onay Bekliyor'),
(3, 'Tablet', 7750.00, 'Teslim Edildi'),
(4, 'Oyun Konsolu', 24000.00, 'Hazirlaniyor'),
(4, 'Gamepad', 4000.00, 'Hazirlaniyor'),
(5, 'Tablet', 8000.00, 'Teslim Edildi'),
(5, 'Kilif', 400.00, 'Teslim Edildi');


-- UPDATE
UPDATE Orders SET status = 'Hazirlaniyor' WHERE product = 'Laptop';
UPDATE Orders SET status = 'Kargolandi' WHERE product = 'Monitor';
UPDATE Orders SET status = 'Teslim Edildi' WHERE product = 'Klavye';
UPDATE Orders SET amount = 20000.00 WHERE product = 'Oyun Konsolu'; 

-- DELETE
DELETE FROM Orders WHERE product = 'Mouse';
DELETE FROM Orders WHERE product = 'Kulaklik';


INSERT INTO Orders (customer_id, product, amount, status) VALUES (2, 'Kamera', 1500.00, 'Siparis Alindi');
INSERT INTO Orders (customer_id, product, amount, status) VALUES (3, 'Powerbank', 800.00, 'Siparis Alindi');
UPDATE Orders SET status = 'İptal Edildi' WHERE product = 'Kamera'; 