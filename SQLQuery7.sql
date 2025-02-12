CREATE TABLE Categories (
    ID INT PRIMARY KEY IDENTITY,            
    CategoryName VARCHAR(100) NOT NULL,    
    Description TEXT                       
);

CREATE TABLE Books (
    ID INT PRIMARY KEY IDENTITY,               
    Title VARCHAR(255) NOT NULL,             
    Author VARCHAR(100),                    
    Genre VARCHAR(100),                     
    PublicationYear INT,                    
    AvailabilityStatus VARCHAR(50),
    CategoriesID INT,
    FOREIGN KEY (CategoriesID) REFERENCES Categories(ID)
);

CREATE TABLE Members (
    ID INT PRIMARY KEY IDENTITY,             
    Name VARCHAR(100) NOT NULL,              
    ContactInformation VARCHAR(255),        
    MembershipType VARCHAR(50),             
    RegistrationDate DATE                   
);

CREATE TABLE MemberBook (
    ID INT PRIMARY KEY IDENTITY,                                         
    BorrowingDate DATE,                     
    DueDate DATE,                        
    ReturnDate DATE, 
    MemberID INT,                          
    BookID INT,
    FOREIGN KEY (MemberID) REFERENCES Members(ID), 
    FOREIGN KEY (BookID) REFERENCES Books(ID)        
);

CREATE TABLE Reservations (
    ID INT PRIMARY KEY IDENTITY,                                           
    ReservationDate DATE,                     
    Status VARCHAR(50), 
    MemberID INT,                              
    BookID INT,
    FOREIGN KEY (MemberID) REFERENCES Members(ID),  
    FOREIGN KEY (BookID) REFERENCES Books(ID)         
);

CREATE TABLE LibraryStaff (
    ID INT PRIMARY KEY IDENTITY,                 
    Name VARCHAR(100) NOT NULL,            
    ContactInfo VARCHAR(255),             
    AssignedSection VARCHAR(100),              
    EmploymentDate DATE                        
);







--START INSERT DATA--


--INSERT CATEGORY--
INSERT INTO Categories (CategoryName, Description)
VALUES 
    ('Fiction', 'Books that contain stories created from the imagination.'),
    ('Non-Fiction', 'Books based on real facts, people, and events.'),
    ('Science Fiction', 'Books that explore futuristic concepts and technologies.'),
    ('Mystery', 'Books that focus on solving a crime or uncovering a secret.'),
    ('Biography', 'Books that tell the life story of a person, typically based on real events.');

--INSERT BOOKS--
INSERT INTO Books (Title, Author, Genre, PublicationYear, AvailabilityStatus, CategoriesID)
VALUES 
    ('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, 'Available', 1), 
    ('Database Fundamentals', 'Yuval Noah Harari', 'Non-Fiction', 2011, 'Checked Out', 2),  
    ('Dune', 'Frank Herbert', 'Science Fiction', 1965, 'Available', 3),  
    ('The Girl with the Dragon Tattoo', 'Stieg Larsson', 'Mystery', 2005, 'Available', 4),  
    ('SQL for Beginners', 'Anne Frank', 'Biography', 1947, 'Checked Out', 5);  

--INSERT MEMBERS--
INSERT INTO Members (Name, ContactInformation, MembershipType, RegistrationDate)
VALUES
    ('John Doe', 'john.doe@example.com', 'Student', '2023-01-15'),
    ('Jane Smith', 'jane.smith@example.com', 'Teacher', '2022-09-12'),
    ('Mark Johnson', 'mark.johnson@example.com', 'Visitor', '2023-02-05'),
    ('Emily Davis', 'emily.davis@example.com', 'Student', '2021-11-22'),
    ('Michael Brown', 'michael.brown@example.com', 'Teacher', '2020-08-19');

--INSERT MEMBER BOOK--
INSERT INTO MemberBook (BorrowingDate, DueDate, ReturnDate, MemberID, BookID)
VALUES
    ('2023-01-15', '2023-02-15', '2023-02-10', 1, 1),  
    ('2023-09-12', '2023-10-12', NULL, 2, 2),          
    ('2023-02-05', '2023-03-05', NULL, 3, 3),          
    ('2021-11-22', '2021-12-22', '2021-12-10', 4, 4), 
    ('2020-08-19', '2020-09-19', NULL, 5, 5);          

--INSERT RESERVATION--
INSERT INTO Reservations (ReservationDate, Status, MemberID, BookID)
VALUES
    ('2023-01-10', 'Pending', 1, 1),  -- John Doe reserved "The Great Gatsby"
    ('2025-01-01', 'Completed', 2, 2),  -- Jane Smith reserved "Sapiens"
    ('2023-02-03', 'Cancelled', 3, 3),  -- Mark Johnson reserved "Dune" but cancelled
    ('2021-11-10', 'Pending', 4, 4),  -- Emily Davis reserved "The Girl with the Dragon Tattoo"
    ('2020-08-10', 'Completed', 5, 5);  -- Michael Brown reserved "The Diary of a Young Girl"


--INSERT LIBRARYSTAFF--
INSERT INTO LibraryStaff (Name, ContactInfo, AssignedSection, EmploymentDate)
VALUES
    ('Alice Johnson', 'alice.johnson@library.com', 'Fiction', '2020-05-01'),
    ('Bob Williams', 'bob.williams@library.com', 'Non-Fiction', '2019-08-15'),
    ('Catherine Lee', 'catherine.lee@library.com', 'Science Fiction', '2021-02-10'),
    ('David Brown', 'david.brown@library.com', 'Mystery', '2018-12-05'),
    ('Emma Wilson', 'emma.wilson@library.com', 'Biography', '2022-07-20');

DROP TABLE Books;
DROP TABLE Members;
DROP TABLE Categories;
DROP TABLE LibraryStaff;
DROP TABLE Reservations;
DROP TABLE MemberBook;

--Q1--
SELECT * FROM Reservations WHERE ReservationDate = '2025-01-01';
--Q2--
SELECT * FROM Books where Title='Database Fundamentals';
--Q3--
ALTER TABLE Members ADD Email varchar(40);
--Q4--
INSERT INTO Members (Name, ContactInformation, MembershipType, RegistrationDate)
VALUES ('Omar', '9876543210', 'Student', '2024-06-05');

--Q5--
SELECT *
FROM Members  
INNER JOIN Reservations ON Members.ID = Reservations.MemberID;

--Q6--
INSERT INTO Books (Title, Author, Genre, PublicationYear, AvailabilityStatus, CategoriesID)
VALUES ('SQL for Beginners', 'John Doe', 'Programming', 2024, 'Available', 1);



SELECT * FROM Members
SELECT * FROM MemberBook

SELECT * FROM Books

SELECT * 
FROM Members
INNER JOIN MemberBook ON Members.ID = MemberBook.MemberID
INNER JOIN Books ON MemberBook.BookID = Books.ID
WHERE Books.Title = 'The Great Gatsby';


--Q7--
SELECT *
FROM Members
INNER JOIN MemberBook ON  Members.ID = MemberBook.MemberID
INNER JOIN Books ON MemberBook.BookID = Books.ID
WHERE Books.Title = 'The Great Gatsby'
 AND MemberBook.ReturnDate IS NOT NULL;

 --Q8--

 UPDATE MemberBook
SET DueDate = '2020-06-01'  
WHERE MemberID = 1 AND BookID = 1; 

 UPDATE MemberBook
SET DueDate = '2020-02-11'  
WHERE MemberID = 4 AND BookID = 4; 


SELECT *
FROM Members
INNER JOIN MemberBook ON  Members.ID = MemberBook.MemberID
INNER JOIN Books ON MemberBook.BookID = Books.ID
WHERE MemberBook.ReturnDate > MemberBook.DueDate;

--Q9--
 
 
 UPDATE MemberBook
SET BookID = '3'  
WHERE  BookID = 3; 

 UPDATE MemberBook
SET BookID = '3'  
WHERE  BookID = 4;

 UPDATE MemberBook
SET BookID = '3'  
WHERE  BookID = 5;

 UPDATE MemberBook
SET BookID = '3'  
WHERE  BookID = 2;


SELECT Books.Title, COUNT(MemberBook.BookID) AS BorrowedTimes
FROM MemberBook
INNER JOIN Books ON MemberBook.BookID = Books.ID
GROUP BY Books.Title
HAVING COUNT(MemberBook.BookID) > 3;

--Q10--
UPDATE MemberBook
SET BorrowingDate = '2024-01-01'  
WHERE  BookID = 1;

UPDATE MemberBook
SET BorrowingDate = '2024-01-01'  
WHERE  BookID = 2;

UPDATE MemberBook
SET ReturnDate = '2024-01-10'  
WHERE  BookID = 1;

UPDATE MemberBook
SET ReturnDate = '2024-01-10'  
WHERE  BookID = 2;

SELECT Members.Name, MemberBook.BorrowingDate, Books.Title
FROM MemberBook
INNER JOIN Members ON MemberBook.MemberID = Members.ID
INNER JOIN Books ON MemberBook.BookID = Books.ID
WHERE MemberBook.BorrowingDate BETWEEN '2024-01-01' AND '2024-01-10';

--Q11--
SELECT COUNT(*) AS TotalBooks
FROM Books;




 