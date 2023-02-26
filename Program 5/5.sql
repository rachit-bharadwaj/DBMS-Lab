CREATE DATABASE CUSTOMER_SALE_SCENARIO;

USE CUSTOMER_SALE_SCENARIO;

CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(255)
);

INSERT INTO Customer (customer_id, customer_name) VALUES
(1, 'John'),
(2, 'Jane'),
(3, 'Mike');

CREATE TABLE Item (
  item_id INT PRIMARY KEY,
  item_name VARCHAR(255),
  item_price DECIMAL(10, 2)
);

INSERT INTO Item (item_id, item_name, item_price) VALUES
(1, 'Shirt', 19.99),
(2, 'Jeans', 29.99),
(3, 'Sneakers', 39.99);

CREATE TABLE Sale (
  bill_no INT PRIMARY KEY,
  bill_date DATE,
  customer_id INT,
  item_id INT,
  quantity_sold INT,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

INSERT INTO Sale (bill_no, bill_date, customer_id, item_id, quantity_sold) VALUES
(1, '2023-01-01', 1, 1, 2),
(2, '2023-01-02', 2, 2, 1),
(3, '2023-02-27', 1, 3, 1),
(4, '2023-02-27', 3, 2, 3);


-- Operation 1
SELECT s.bill_no, c.customer_name, s.item_id
FROM Sale s
JOIN Customer c ON s.customer_id = c.customer_id
WHERE s.bill_date = CURDATE();

-- Operation 2
SELECT s.bill_no, c.customer_name, i.item_name, s.quantity_sold, i.item_price, s.quantity_sold * i.item_price AS final_amount
FROM Sale s
JOIN Customer c ON s.customer_id = c.customer_id
JOIN Item i ON s.item_id = i.item_id;

-- Operation 3
SELECT DISTINCT c.customer_id, c.customer_name
FROM Sale s
JOIN Customer c ON s.customer_id = c.customer_id
JOIN Item i ON s.item_id = i.item_id
WHERE i.item_price < 200;

-- Operation 4
SELECT i.item_id, i.item_name, s.quantity_sold, i.item_price
FROM Sale s
JOIN Item i ON s.item_id = i.item_id
WHERE s.customer_id = 2;

-- Operation 5
SELECT i.item_id, i.item_name, s.quantity_sold, i.item_price, s.bill_date
FROM Sale s
JOIN Item i ON s.item_id = i.item_id
WHERE s.bill_date = CURDATE();