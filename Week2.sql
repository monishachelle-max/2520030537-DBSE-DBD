-- Week2 (Continue of Week1 querys)
-- Already created bookflow_db

-- [Your exsiting bookflow_db , Books, and Members  are from 
-- Week1,so don't recreate them.Week 2  starts by creating 
-- Lones.]

USE bookflow_db;

CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    loan_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);


-- Here in Insert 10 loan records member_id is 101,102,103 but wee are using the week1 
-- so in that we have member_id is 1,2,3) so we are changing 

-- INSERT INTO Loans (loan_id, member_id, book_id, loan_date) VALUES
-- (1, 101, 1, '2025-01-05'),
-- (2, 102, 2, '2025-01-08'),
-- (3, 103, 3, '2025-01-10'),
-- (4, 101, 2, '2025-02-01'),
-- (5, 102, 1, '2025-02-05'),
-- (6, 103, 2, '2025-02-12'),
-- (7, 101, 3, '2025-03-01'),
-- (8, 102, 3, '2025-03-07'),
-- (9, 103, 1, '2025-03-15'),
-- (10, 101, 1, '2025-04-01');


INSERT INTO Loans (loan_id, member_id, book_id, loan_date) VALUES
(1, 1, 1, '2025-01-05'),
(2, 2, 2, '2025-01-08'),
(3, 3, 3, '2025-01-10'),
(4, 1, 2, '2025-02-01'),
(5, 2, 1, '2025-02-05'),
(6, 3, 2, '2025-02-12'),
(7, 1, 3, '2025-03-01'),
(8, 2, 3, '2025-03-07'),
(9, 3, 1, '2025-03-15'),
(10, 1, 1, '2025-04-01');


SELECT * FROM Loans;

SELECT 
    m.full_name AS Member_Name,
    b.title AS Book_Title
FROM Loans l
INNER JOIN Members m 
    ON l.member_id = m.member_id
INNER JOIN Books b 
    ON l.book_id = b.book_id;
    
  SELECT 
    published_year,
    COUNT(book_id) AS Total_Books
FROM Books
GROUP BY published_year
ORDER BY published_year;  

CREATE TABLE Donation_History (
    donation_id INT PRIMARY KEY,
    book_id INT,
    donor_name VARCHAR(100),
    donation_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

START TRANSACTION;

INSERT INTO Books 
(book_id, title, isbn, published_year)
VALUES 
(4, 'Animal Farm', '9780451526342', 1945);

INSERT INTO Donation_History 
(donation_id, book_id, donor_name, donation_date)
VALUES 
(1, 4, 'Raj Kumar', CURDATE());

COMMIT;

SELECT * FROM Books;

SELECT * FROM Donation_History;

CREATE INDEX idx_books_isbn
ON Books(isbn);

SELECT *
FROM Books
WHERE isbn = '9780451524935';

-- other 
SELECT *
FROM Books
WHERE isbn = '9780451526342';










