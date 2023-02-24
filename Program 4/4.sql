CREATE DATABASE student_lab;

USE student_lab;

CREATE TABLE Student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    branch VARCHAR(50),
    mob_no VARCHAR(15)
);

INSERT INTO Student (roll_no, name, branch, mob_no) VALUES
(1, 'John Doe', 'Computer Science', '9876543210'),
(2, 'Jane Doe', 'Electronics', '1234567890'),
(3, 'Bob Smith', 'Mechanical', '5555555555'),
(4, 'Alice Brown', 'Civil', '9999999999');

CREATE TABLE Branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_desc VARCHAR(100)
);

INSERT INTO Branch (branch_name, branch_desc) VALUES
('Computer Science', 'Study of computers and computational systems'),
('Electronics', 'Study of electronic devices and circuits'),
('Mechanical', 'Study of machines and mechanics'),
('Civil', 'Study of infrastructure and construction');

CREATE TABLE Lab (
    lab_no INT PRIMARY KEY,
    lab_name VARCHAR(50),
    lab_desc VARCHAR(100),
    machine_no INT
);

INSERT INTO Lab (lab_no, lab_name, lab_desc, machine_no) VALUES
(1, 'Computer Lab', 'Lab for computer science students', 50),
(2, 'Electronics Lab', 'Lab for electronics students', 30),
(3, 'Mechanical Lab', 'Lab for mechanical students', 40),
(4, 'Civil Lab', 'Lab for civil students', 25);

CREATE TABLE Lab_Allotment (
    roll_no INT,
    lab_no INT,
    PRIMARY KEY (roll_no, lab_no),
    FOREIGN KEY (roll_no) REFERENCES Student (roll_no),
    FOREIGN KEY (lab_no) REFERENCES Lab (lab_no)
);

INSERT INTO Lab_Allotment (roll_no, lab_no) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);


-- Operation 1
SELECT s.roll_no, s.name, COUNT(la.lab_no) as total_labs_allotted
FROM student s
LEFT JOIN lab_allotment la ON s.roll_no = la.roll_no
GROUP BY s.roll_no;

-- Operation 2
SELECT Student.branch, Lab.machine_no, COUNT(DISTINCT Student.roll_no) AS total_students
FROM Student
INNER JOIN Lab_Allotment ON Student.roll_no = Lab_Allotment.roll_no
INNER JOIN Lab ON Lab_Allotment.lab_no = Lab.lab_no
GROUP BY Student.branch, Lab.machine_no;

-- Operation 3
SELECT Branch.branch_name, COUNT(Lab.machine_no) AS machines_allocated
FROM Branch
JOIN Student ON Branch.branch_name = Student.branch
JOIN Lab_Allotment ON Student.roll_no = Lab_Allotment.roll_no
JOIN Lab ON Lab_Allotment.lab_no = Lab.lab_no
GROUP BY Branch.branch_name;