-- ==========================
-- Create Database
-- ==========================
CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;

-- ==========================
-- Users Table
-- ==========================
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    membership_date DATE NOT NULL
);

-- ==========================
-- Authors Table
-- ==========================
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);

-- ==========================
-- Books Table
-- ==========================
CREATE TABLE IF NOT EXISTS Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    published_year SMALLINT,
    available_copies INT DEFAULT 1
);

-- ==========================
-- Junction Table: Book_Authors
-- ==========================
CREATE TABLE IF NOT EXISTS Book_Authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- ==========================
-- Borrow Records Table
-- ==========================
CREATE TABLE IF NOT EXISTS Borrow_Records (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- ==========================
-- Sample Data Inserts
-- ==========================

-- Users
REPLACE INTO Users (user_id, full_name, email, membership_date) VALUES
(1, 'Alice Johnson', 'alice@example.com', '2025-01-15'),
(2, 'Bob Smith', 'bob@example.com', '2025-02-10'),
(3, 'Charlie Daniels', 'charlie@example.com', '2025-03-05'),
(4, 'Diana Prince', 'diana@example.com', '2025-04-12'),
(5, 'Ethan Hunt', 'ethan@example.com', '2025-05-20');

-- Authors
REPLACE INTO Authors (author_id, author_name) VALUES
(1, 'George Orwell'),
(2, 'J.K. Rowling'),
(3, 'Agatha Christie'),
(4, 'Mark Twain'),
(5, 'Jane Austen');

-- Books
REPLACE INTO Books (book_id, title, isbn, published_year, available_copies) VALUES
(1, '1984', '123-ABC-456', 1949, 3),
(2, 'Harry Potter', '987-ZYX-654', 1997, 5),
(3, 'Murder on the Orient Express', '111-AAA-111', 1934, 4),
(4, 'Adventures of Tom Sawyer', '222-BBB-222', 1876, 2),
(5, 'Pride and Prejudice', '333-CCC-333', 1813, 3);

-- Book_Authors (Many-to-Many)
REPLACE INTO Book_Authors (book_id, author_id) VALUES
(1, 1),  -- 1984 -> George Orwell
(2, 2),  -- Harry Potter -> J.K. Rowling
(3, 3),  -- Murder on the Orient Express -> Agatha Christie
(4, 4),  -- Adventures of Tom Sawyer -> Mark Twain
(5, 5);  -- Pride and Prejudice -> Jane Austen

-- Borrow Records
REPLACE INTO Borrow_Records (borrow_id, user_id, book_id, borrow_date, return_date) VALUES
(1, 1, 3, '2025-06-01', '2025-06-15'), -- Alice borrowed "Murder on the Orient Express"
(2, 2, 2, '2025-06-10', NULL),         -- Bob borrowed "Harry Potter" (not yet returned)
(3, 3, 1, '2025-07-05', NULL),         -- Charlie borrowed "1984"
(4, 4, 4, '2025-07-15', '2025-07-25'), -- Diana borrowed "Adventures of Tom Sawyer"
(5, 5, 5, '2025-08-01', NULL);         -- Ethan borrowed "Pride and Prejudice"
