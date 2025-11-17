
CREATE DATABASE IF NOT EXISTS library_automation;
USE library_automation;


DROP TABLE IF EXISTS Author;
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


DROP TABLE IF EXISTS Books;
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


DROP TABLE IF EXISTS Students;
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


DROP TABLE IF EXISTS Teachers;
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


DROP TABLE IF EXISTS Librarian;
CREATE TABLE Librarian (
    librarian_id INT AUTO_INCREMENT PRIMARY KEY,
    librarian_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255) NOT NULL
);

INSERT INTO Librarian (librarian_name, username, password) VALUES
('Wadood Swaleh', 'wadood_admin', 'hashed_password1'),
('Warda Nasir', 'warda_admin', 'hashed_password2'),
('Awais Malik', 'awais_admin', 'hashed_password3');


DROP TABLE IF EXISTS BorrowRecords;
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



CREATE INDEX idx_book_title ON Books(title);
CREATE INDEX idx_author_name ON Author(author_name);
CREATE INDEX idx_student_email ON Students(email);
CREATE INDEX idx_teacher_email ON Teachers(email);


DELIMITER //
CREATE TRIGGER after_borrow_insert
AFTER INSERT ON BorrowRecords
FOR EACH ROW
BEGIN
    UPDATE Books
    SET copies_available = copies_available - 1
    WHERE book_id = NEW.book_id;
END //
DELIMITER ;



-- Join Books and Author
SELECT b.book_id, b.title, a.author_name, b.genre, b.publication_year
FROM Books b
JOIN Author a ON b.author_id = a.author_id;

-- Join BorrowRecords with Students and Books
SELECT br.record_id, s.student_name, b.title, br.borrow_date, br.return_date, l.librarian_name
FROM BorrowRecords br
JOIN Books b ON br.book_id = b.book_id
JOIN Students s ON br.borrower_id = s.student_id
JOIN Librarian l ON br.librarian_id = l.librarian_id
WHERE br.borrower_type = 'Student';


SELECT * FROM Author;
SELECT * FROM Books;
SELECT * FROM Students;
SELECT * FROM Teachers;
SELECT * FROM Librarian;
SELECT * FROM BorrowRecords;


