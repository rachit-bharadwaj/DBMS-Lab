CREATE DATABASE student_library;

USE student_library;

CREATE TABLE student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    mob_no VARCHAR(15)
);

INSERT INTO student (roll_no, name, mob_no) VALUES
(1, 'John Doe', '9876543210'),
(2, 'Jane Doe', '1234567890'),
(3, 'Bob Smith', '5555555555'),
(4, 'Alice Brown', '9999999999');

CREATE TABLE membership (
    membership_no INT PRIMARY KEY,
    roll_no INT,
    FOREIGN KEY (roll_no) REFERENCES student (roll_no)
);

INSERT INTO membership (membership_no, roll_no) VALUES
(101, 1),
(102, 2),
(103, 3),
(104, 4);

CREATE TABLE book (
    book_no INT PRIMARY KEY,
    name VARCHAR(50),
    author VARCHAR(50)
);

INSERT INTO book (book_no, name, author) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee'),
(2, 'Pride and Prejudice', 'Jane Austen'),
(3, '1984', 'George Orwell'),
(4, 'The Great Gatsby', 'F. Scott Fitzgerald');

CREATE TABLE issue_record (
    issue_no INT PRIMARY KEY,
    issue_date DATE,
    membership_no INT,
    book_no INT,
    FOREIGN KEY (membership_no) REFERENCES membership (membership_no),
    FOREIGN KEY (book_no) REFERENCES book (book_no)
);

INSERT INTO issue_record (issue_no, issue_date, membership_no, book_no) VALUES
(1, '2023-02-21', 101, 1),
(2, '2023-02-22', 102, 2),
(3, '2023-02-23', 103, 3),
(4, '2023-02-24', 104, 4);



-- Operation 1 
SELECT student.name, membership.membership_no
FROM student
JOIN membership
ON student.roll_no = membership.roll_no;

-- Operation 2
SELECT issue_record.issue_no, student.name AS student_name, book.name AS book_name
FROM issue_record
JOIN membership ON issue_record.membership_no = membership.membership_no
JOIN student ON membership.roll_no = student.roll_no
JOIN book ON issue_record.book_no = book.book_no
WHERE issue_record.issue_date = CURDATE(); 

-- Operation 3
SELECT student.name AS student_name, book.name AS book_name, book.author
FROM issue_record
JOIN membership ON issue_record.membership_no = membership.membership_no
JOIN student ON membership.roll_no = student.roll_no
JOIN book ON issue_record.book_no = book.book_no
JOIN book AS book_author ON book.author = book_author.author
ORDER BY student.name;

-- Operation 4
SELECT s.name, COUNT(*) AS num_books_bought
FROM student s
JOIN membership m ON s.roll_no = m.roll_no
JOIN issue_record i ON m.membership_no = i.membership_no
JOIN book b ON i.book_no = b.book_no
GROUP BY s.name;

-- Operation 5
SELECT s.roll_no, b.name
FROM student s
JOIN membership m ON s.roll_no = m.roll_no
JOIN issue_record ir ON m.membership_no = ir.membership_no
JOIN book b ON ir.book_no = b.book_no;