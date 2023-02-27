CREATE DATABASE employee_payment_scenario;

USE employee_payment_scenario;

CREATE TABLE Employee (
  employee_id INT PRIMARY KEY,
  employee_name VARCHAR(50),
  designation VARCHAR(50)
);

INSERT INTO Employee (employee_id, employee_name, designation)
VALUES
  (1, 'John Doe', 'Manager'),
  (2, 'Jane Smith', 'Developer'),
  (3, 'Bob Johnson', 'Designer'),
  (4, 'Alice Lee', 'Marketer');

CREATE TABLE Department (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(50)
);

INSERT INTO Department (department_id, department_name)
VALUES
  (1, 'Marketing'),
  (2, 'Design'),
  (3, 'Engineering'),
  (4, 'Sales');

CREATE TABLE PayDetail (
  pay_id INT PRIMARY KEY,
  employee_id INT,
  department_id INT,
  basic_pay DECIMAL(10,2),
  addition DECIMAL(10,2),
  deduction DECIMAL(10,2),
  in_hand_pay DECIMAL(10,2),
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
  FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

INSERT INTO PayDetail (pay_id, employee_id, department_id, basic_pay, addition, deduction, in_hand_pay)
VALUES
  (1, 1, 1, 18000.00, 2000.00, 1000.00, 19000.00),
  (2, 2, 3, 22000.00, 3000.00, 1500.00, 23500.00),
  (3, 3, 2, 17000.00, 1500.00, 500.00, 18000.00),
  (4, 4, 1, 19000.00, 2500.00, 2000.00, 19500.00);

-- Operation 1
SELECT e.employee_id, e.employee_name, e.designation, d.department_name 
FROM Employee e 
INNER JOIN PayDetail p ON e.employee_id = p.employee_id 
INNER JOIN Department d ON p.department_id = d.department_id 
ORDER BY d.department_name;

-- Operation 2
SELECT e.employee_id, e.employee_name, e.designation, p.basic_pay 
FROM Employee e 
INNER JOIN PayDetail p ON e.employee_id = p.employee_id 
WHERE p.basic_pay BETWEEN 10000 AND 20000;

-- Operation 3
SELECT e.employee_name
FROM Employee e 
INNER JOIN PayDetail p ON e.employee_id = p.employee_id 
WHERE p.in_hand_pay > 20000;

-- Operation 4
SELECT * FROM Employee WHERE employee_id IN (1, 2, 3);