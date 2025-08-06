-- Enable output
SET SERVEROUTPUT ON;

----------------------------------------
-- TABLE CREATION
----------------------------------------

-- Customers table
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE
);

-- Accounts table
CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Transactions table
CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Employees table
CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

----------------------------------------
-- SEQUENCE FOR TRANSACTIONS
----------------------------------------
CREATE SEQUENCE Transactions_seq START WITH 1 INCREMENT BY 1;

----------------------------------------
-- SAMPLE DATA INSERTION
----------------------------------------

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (1, 'John Doe', TO_DATE('1980-01-01', 'YYYY-MM-DD'), 1200, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (2, 'Jane Smith', TO_DATE('1992-08-21', 'YYYY-MM-DD'), 3000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (101, 1, 'Savings', 1200, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (102, 2, 'Checking', 3000, SYSDATE);

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

COMMIT;

----------------------------------------
-- PROCEDURE 1: SafeTransferFunds
----------------------------------------
CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    p_FromAccountID IN NUMBER,
    p_ToAccountID   IN NUMBER,
    p_Amount        IN NUMBER
) IS
    v_FromBalance NUMBER;
BEGIN
    SELECT Balance INTO v_FromBalance
    FROM Accounts
    WHERE AccountID = p_FromAccountID;

    IF v_FromBalance < p_Amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in source account.');
    END IF;

    UPDATE Accounts SET Balance = Balance - p_Amount WHERE AccountID = p_FromAccountID;
    UPDATE Accounts SET Balance = Balance + p_Amount WHERE AccountID = p_ToAccountID;

    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (Transactions_seq.NEXTVAL, p_FromAccountID, SYSDATE, p_Amount, 'Withdrawal');

    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (Transactions_seq.NEXTVAL, p_ToAccountID, SYSDATE, p_Amount, 'Deposit');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Funds transferred successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error during fund transfer: ' || SQLERRM);
END;
/

----------------------------------------
-- PROCEDURE 2: UpdateSalary
----------------------------------------
CREATE OR REPLACE PROCEDURE UpdateSalary(
    p_EmployeeID IN NUMBER,
    p_Percent    IN NUMBER
) IS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_Percent / 100)
    WHERE EmployeeID = p_EmployeeID;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Employee ID not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Salary updated for Employee ID: ' || p_EmployeeID);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating salary: ' || SQLERRM);
END;
/

----------------------------------------
-- PROCEDURE 3: AddNewCustomer
----------------------------------------
CREATE OR REPLACE PROCEDURE AddNewCustomer(
    p_CustomerID IN NUMBER,
    p_Name       IN VARCHAR2,
    p_DOB        IN DATE,
    p_Balance    IN NUMBER
) IS
BEGIN
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
    VALUES (p_CustomerID, p_Name, p_DOB, p_Balance, SYSDATE);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Customer added: ' || p_Name);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Customer ID already exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('General error adding customer: ' || SQLERRM);
END;
/

----------------------------------------
-- TEST CALLS
----------------------------------------

-- 1. SafeTransferFunds - Successful
BEGIN
  SafeTransferFunds(101, 102, 500);
END;
/

-- 2. SafeTransferFunds - Insufficient Funds
BEGIN
  SafeTransferFunds(101, 102, 100000);
END;
/

-- 3. UpdateSalary - Valid Employee
BEGIN
  UpdateSalary(2, 10);
END;
/

-- 4. UpdateSalary - Invalid Employee
BEGIN
  UpdateSalary(999, 10);
END;
/

-- 5. AddNewCustomer - New Customer
BEGIN
  AddNewCustomer(3, 'Charlie Black', TO_DATE('1982-03-12', 'YYYY-MM-DD'), 5000);
END;
/

-- 6. AddNewCustomer - Duplicate ID
BEGIN
  AddNewCustomer(3, 'Charlie Black', TO_DATE('1982-03-12', 'YYYY-MM-DD'), 5000);
END;
/
