-- Creating A Database
CREATE SCHEMA mybank_db;

-- Creating a table in a database
CREATE TABLE Customers(
-- Using the database
CustomerID integer auto_increment primary key,
FirstName VARCHAR(255) NOT NULL,
LastName varchar(255) Not null, 
City varchar (255) Not Null,
State varchar (255) Not Null);

-- Creating a table in a database
CREATE TABLE Branches(
-- Using the database
BranchID integer auto_increment primary key,
BranchName VARCHAR(255) NOT NULL, 
City varchar (255) Not Null,
State varchar (255) Not Null);

CREATE TABLE Accounts(
-- Using the database
AccountID integer auto_increment primary key,
CustomerID integer (11) NOT NULL,
BranchID integer(11) Not null,
AccountType varchar (255) Not Null,
Balance varchar (255) Not Null,

CONSTRAINT FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
CONSTRAINT FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

CREATE TABLE Transactions(
-- Using the database
TransactionID integer auto_increment primary key,
AccountID integer (11) NOT NULL,
TransactionDate DATE,
Amount varchar (255) Not Null,

CONSTRAINT FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           

-- Inserting Data Into A Table 
INSERT INTO Customers(FirstName, LastName, City, State)
VALUES ("John", "Doe", "New York", "NY"),
("Jane", "Doe", "New York", "NY"),
("Bob", "Smith", "San Francisco", "CA"),
("Alice", "Johnson", "San Francisco", "CA"),
("Michael", "Lee", "Los Angeles", "CA"),
("Jennifer", "Wand", "Los Angeles", "CA");

-- Inserting Data Into A Table 
INSERT INTO Branches(BranchName, City, State)
VALUES ("Main", "New York", "NY"),
("Downtown", "San Francisco", "CA"),
("West LA", "Los Angeles", "CA"),
("East LA", "Los Angeles", "CA"),
("Uptown", "New York", "NY"),
("Financial District", "San Francisco", "CA"),
("Midtown", "New York", "NY"),
("South Bay", "San Francisco", "CA"),
("Downtown", "Los Angeles", "CA"),
("Chinatown", "New York", "NY"),
("Marina", "San Francisco", "CA"),
("Beverly Hills", "Los Angeles", "CA"),
("Brooklyn", "New York", "NY"),
("North Beach", "San Francisco", "CA"),
("Pasadena", "Los Angeles", "CA");

-- Inserting Data Into A Table 
INSERT INTO Accounts(CustomerID, BranchID, AccountType, Balance)
VALUES (1, 5, "Checking", 1000),
(1, 5, "Savings", 5000),
(2, 1, "Checking", 2500),
(2, 1, "Savings", 10000),
(3, 2, "Checking", 7500),
(3, 2, "Savings", 15000),
(4, 8, "Checking", 5000),
(4, 8, "Savings", 20000),
(5, 14, "Checking", 10000),
(5, 14, "Savings", 50000),
(6, 2, "Checking", 5000),
(6, 2, "Savings", 10000),
(1, 5, "Credit Card", -500),
(2, 1, "Credit Card", -1000),
(3, 2, "Credit Card", -2000);

-- Inserting Data Into A Table 
INSERT INTO Transactions(AccountID, TransactionDate, Amount)
VALUES
    ("1", "2022-01-01", "-500"),
("1", "2022-01-02", "-250"),
("2", "2022-01-03", "1000"),
("3", "2022-01-04", "-1000"),
("3", "2022-01-05", "500"),
("4", "2022-01-06", "1000"),
("4", "2022-01-07", "-500"),
("5", "2022-01-08", "-2500"),
("6", "2022-01-09", "500"),
("6", "2022-01-10", "-1000"),
("7","2022-01-11", "-500"),
("7", "2022-01-12", "-250"),
("8", "2022-01-13", "1000"),
("8", "2022-01-14", "-1000"),
("9", "2022-01-15", "-500");

-- QUESTION 1: What are the names of all the customers who live in New York? 
select FirstName, LastName, City
from customers
where city = "New York";

-- QUESTION 2: What is the total number of accounts in the Accounts table? 
SELECT COUNT(*) AS TotalAccounts
FROM Accounts;

-- QUESTION 3: What is the total balance of all checking accounts? 
select sum(balance) as TotalCheckingBalance
from accounts
where AccountType = "checking";

-- QUESTION 4: What is the total balance of all accounts associated with customers who live in Los Angeles?
select sum(Balance) as TotalBalanceOfCAaccounts
from accounts
join customers
on accounts.customerID = customers.customerID
where city = "Los Angeles";

-- QUESTION 5: Which branch has the highest average account balance? 
SELECT Branches.BranchID, BranchName, AVG(Balance) AS AverageBalance
FROM Accounts
join Branches
on Accounts.BranchID = Branches.BranchID
GROUP BY BranchID
ORDER BY AverageBalance DESC
LIMIT 1;

-- QUESTION 6: Which customer has the highest current balance in their accounts?
SELECT FirstName, LastName, SUM(Balance) AS TotalCurrentBalance
FROM accounts
JOIN customers 
ON accounts.CustomerID = customers.CustomerID
GROUP BY customers.CustomerID
ORDER BY TotalCurrentBalance DESC
LIMIT 1;

FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Products ON Orders.ProductID = Products.ProductID;

-- QUESTION 7: Which customer has made the most transactions in the Transactions table?
SELECT Customers.CustomerID, FirstName, LastName, COUNT(*) AS TransactionCount
FROM Transactions
join Accounts On transactions.accountID = accounts.accountID
join customers on accounts.customerID = customers.customerID
GROUP BY CustomerID
ORDER BY TransactionCount DESC
LIMIT 1;

-- QUESTION 8: Which branch has the highest total balance across all of its accounts?
select sum(Balance) as TotalBalance, branches.BranchName
from accounts
join branches
on branches.BranchID = accounts.BranchID
group by branches.BranchID
order by TotalBalance desc
limit 1;

-- QUESTION 9: Which customer has the highest total balance across all of their accounts, including savings and checking accounts?
SELECT SUM(accounts.Balance) AS CustHighBalance, customers.FirstName, customers.LastName
FROM accounts
JOIN customers ON accounts.CustomerID = customers.CustomerID
WHERE accounts.AccountType IN ('savings', 'checkings')
GROUP BY customers.CustomerID, customers.FirstName, customers.LastName
ORDER BY CustHighBalance DESC
LIMIT 1;

-- QUESTION 10: Which branch has the highest number of transactions in the Transactions table?
SELECT Branches.BranchID, BranchName, COUNT(*) AS TransactionCount
FROM Transactions
join Accounts On transactions.accountID = accounts.accountID
join Branches on accounts.branchID = branches.branchID
GROUP BY Branches.BranchID
ORDER BY TransactionCount DESC
LIMIT 1;