CREATE DATABASE library_automation;
USE library_automation;

CREATE TABLE Author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50),
    birth_year INT
);

INSERT INTO Author (author_name, nationality, birth_year) VALUES
('J.K. Rowling', 'British', 1965),
('George Orwell', 'British', 1903),
('Paulo Coelho', 'Brazilian', 1947);


CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author_id INT,
    genre VARCHAR(50),
    publication_year INT,
    copies_available INT,
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);

INSERT INTO Books (title, author_id, genre, publication_year, copies_available) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, 'Fantasy', 1997, 5),
('1984', 2, 'Dystopian', 1949, 4),
('The Alchemist', 3, 'Adventure', 1988, 6);


CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

INSERT INTO Students (student_name, department, email, phone) VALUES
('Ali Raza', 'Computer Science', 'ali.raza@bbsul.edu.pk', '03120000001'),
('Fatima Khan', 'English Literature', 'fatima.khan@bbsul.edu.pk', '03120000002'),
('Ahmed Malik', 'Business Administration', 'ahmed.malik@bbsul.edu.pk', '03120000003');



CREATE TABLE Teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

INSERT INTO Teachers (teacher_name, department, email, phone) VALUES
('Dr. Anwar', 'Computer Science', 'anwar.cs@bbsul.edu.pk', '03210000001'),
('Ms. Sana', 'English Literature', 'sana.el@bbsul.edu.pk', '03210000002'),
('Mr. Bilal', 'Business Administration', 'bilal.ba@bbsul.edu.pk', '03210000003');



CREATE TABLE Librarian (
    librarian_id INT AUTO_INCREMENT PRIMARY KEY,
    librarian_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);


INSERT INTO Librarian (librarian_name, username, password) VALUES
('Wadood Swaleh', 'wadood_admin', 'admin123'),
('Warda Nasir', 'warda_admin', 'admin456'),
('Awais Malik', 'awais_admin', 'admin789');



CREATE TABLE BorrowRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    borrower_type ENUM('Student', 'Teacher'),
    borrower_id INT,
    borrow_date DATE,
    return_date DATE,
    librarian_id INT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (librarian_id) REFERENCES Librarian(librarian_id)
);

INSERT INTO BorrowRecords (book_id, borrower_type, borrower_id, borrow_date, return_date, librarian_id) VALUES
(1, 'Student', 1, '2025-10-20', '2025-10-30', 1),
(2, 'Teacher', 1, '2025-10-22', '2025-11-01', 2),
(3, 'Student', 2, '2025-10-25', '2025-11-05', 3);


SHOW TABLES;

SELECT * FROM Author;
SELECT * FROM Books;
SELECT * FROM Students;
SELECT * FROM Teachers;
SELECT * FROM Librarian;
SELECT * FROM BorrowRecords;






