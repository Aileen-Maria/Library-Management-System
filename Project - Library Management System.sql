CREATE DATABASE library;

USE library;

CREATE TABLE Branch (
Branch_no INT PRIMARY KEY,
Managaer_Id INT,
Branch_address VARCHAR(100),
Contact_no VARCHAR(15)
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
(1, 101, 'Downtown', '1234567890'),
(2, 102, 'Uptown', '0987654321'),
(3, 103, 'Eastside', '1122334455');

ALTER TABLE Branch
RENAME COLUMN Managaer_Id TO Manager_Id;


CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) 
VALUES 
    (201, 'Alice', 'Manager', 55000, 1),
    (202, 'Bob', 'Assistant', 45000, 1),
    (203, 'Charlie', 'Manager', 60000, 2),
    (204, 'Daisy', 'Librarian', 40000, 3),
    (205, 'Eve', 'Assistant', 42000, 2);
    
    
    CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(225),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
    );

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) 
VALUES 
    (1001, 'Introduction to Python', 'Programming', 30, 'yes', 'John Doe', 'TechBooks'),
    (1002, 'World History', 'History', 25, 'no', 'Jane Smith', 'EduPress'),
    (1003, 'Advanced SQL', 'Database', 35, 'yes', 'Alice Green', 'TechBooks'),
    (1004, 'Modern Literature', 'Literature', 20, 'yes', 'Paul Brown', 'ReadWell'),
    (1005, 'Data Science 101', 'Data Science', 40, 'no', 'Nancy White', 'DataPress');


CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) 
VALUES 
    (301, 'John Carter', '123 Main St', '2021-12-15'),
    (302, 'Emily Stone', '456 Oak St', '2023-05-10'),
    (303, 'Michael Green', '789 Maple St', '2020-11-05'),
    (304, 'Sarah Blue', '101 Pine St', '2022-02-20');
    
    
    CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) 
VALUES 
    (401, 301, 'Introduction to Python', '2023-06-10', 1001),
    (402, 302, 'Advanced SQL', '2023-06-15', 1003);


CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) 
VALUES 
    (501, 301, 'Introduction to Python', '2023-06-20', 1001),
    (502, 302, 'Advanced SQL', '2023-06-25', 1003);
    
    
SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'yes';


SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;


SELECT Books.Book_title, Customer.Customer_name 
FROM IssueStatus 
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN 
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;


SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;


SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;


SELECT Customer_name 
FROM Customer 
WHERE Reg_date < '2022-01-01' 
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);


SELECT Branch_no, COUNT(Emp_Id) AS Employee_Count 
FROM Employee 
GROUP BY Branch_no;


SELECT Customer.Customer_name 
FROM IssueStatus 
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id 
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';


SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%history%';


SELECT Branch_no, COUNT(Emp_Id) AS Employee_Count 
FROM Employee 
GROUP BY Branch_no 
HAVING Employee_Count > 5;
    

SELECT Employee.Emp_name, Branch.Branch_address 
FROM Employee 
JOIN Branch ON Employee.Branch_no = Branch.Branch_no 
WHERE Employee.Position = 'Manager';

SELECT Customer.Customer_name 
FROM IssueStatus 
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN 
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id 
WHERE Books.Rental_Price > 25;

