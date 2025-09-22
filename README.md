# Library Management Database (MySQL)

## 📌 Description
This project is a relational database schema for a **Library Management System**.  
It includes entities for **Users, Books, Authors, Borrow Records**, and supports relationships like:
- One-to-Many (Users → Borrow_Records)
- Many-to-Many (Books ↔ Authors)
- One-to-Many (Books → Borrow_Records)

## 📂 Files
- `library.sql` → Contains all SQL commands to create the database, tables, constraints, and sample data.

## ⚙️ How to Run in MySQL Workbench

1. Open **MySQL Workbench**.
2. Create a new connection (if not already).
3. Open the `library.sql` file in the query editor.
4. Run the script (`⚡ Execute` button).
5. Verify the database:
   ```sql
   SHOW DATABASES;
   USE LibraryDB;
   SHOW TABLES;
   ```
## Testing Queries

- After creating the schema, try some test queries:
# View all users:

``` SELECT * FROM Users;
```

# Check borrowed books:

``` SELECT U.full_name, B.title, R.borrow_date
FROM Borrow_Records R
JOIN Users U ON R.user_id = U.user_id
JOIN Books B ON R.book_id = B.book_id;
```

# Find all authors of a book:

```SELECT B.title, A.author_name
FROM Books B
JOIN Book_Authors BA ON B.book_id = BA.book_id
JOIN Authors A ON BA.author_id = A.author_id;
```

## Requirements

- MySQL (8.x recommended)
- MySQL Workbench  