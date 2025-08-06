-- Enable output
SET SERVEROUTPUT ON;

---------------------------------------------------------
-- Scenario 1: CustomerManagement Package
-- Includes: Add, Update, GetBalance
---------------------------------------------------------
CREATE OR REPLACE PACKAGE CustomerManagement AS
  PROCEDURE AddCustomer(p_ID NUMBER, p_Name VARCHAR2, p_DOB DATE, p_Balance NUMBER);
  PROCEDURE UpdateCustomer(p_ID NUMBER, p_Name VARCHAR2, p_Balance NUMBER);
  FUNCTION GetCustomerBalance(p_ID NUMBER) RETURN NUMBER;
END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement AS
  PROCEDURE AddCustomer(p_ID NUMBER, p_Name VARCHAR2, p_DOB DATE, p_Balance NUMBER) IS
  BEGIN
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
    VALUES (p_ID, p_Name, p_DOB, p_Balance, SYSDATE);
    DBMS_OUTPUT.PUT_LINE('Customer added: ' || p_Name);
  END;

  PROCEDURE UpdateCustomer(p_ID NUMBER, p_Name VARCHAR2, p_Balance NUMBER) IS
  BEGIN
    UPDATE Customers
    SET Name = p_Name, Balance = p_Balance, LastModified = SYSDATE
    WHERE CustomerID = p_ID;
    DBMS_OUTPUT.PUT_LINE('Customer updated: ' || p_ID);
  END;

  FUNCTION GetCustomerBalance(p_ID NUMBER) RETURN NUMBER IS
    v_Balance NUMBER;
  BEGIN
    SELECT Balance INTO v_Balance FROM Customers WHERE CustomerID = p_ID;
    RETURN v_Balance;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN -1;
  END;
END CustomerManagement;
/

-- Test
BEGIN
  CustomerManagement.AddCustomer(10, 'Charlie Black', TO_DATE('1980-11-11','YYYY-MM-DD'), 8000);
  CustomerManagement.UpdateCustomer(10, 'Charles Black', 9000);
  DBMS_OUTPUT.PUT_LINE('Balance: ₹' || CustomerManagement.GetCustomerBalance(10));
END;
/

---------------------------------------------------------
-- Scenario 2: EmployeeManagement Package
-- Includes: Hire, Update, CalculateAnnualSalary
---------------------------------------------------------
CREATE OR REPLACE PACKAGE EmployeeManagement AS
  PROCEDURE HireEmployee(p_ID NUMBER, p_Name VARCHAR2, p_Position VARCHAR2, p_Salary NUMBER, p_Dept VARCHAR2, p_HireDate DATE);
  PROCEDURE UpdateEmployee(p_ID NUMBER, p_Salary NUMBER);
  FUNCTION GetAnnualSalary(p_ID NUMBER) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS
  PROCEDURE HireEmployee(p_ID NUMBER, p_Name VARCHAR2, p_Position VARCHAR2, p_Salary NUMBER, p_Dept VARCHAR2, p_HireDate DATE) IS
  BEGIN
    INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
    VALUES (p_ID, p_Name, p_Position, p_Salary, p_Dept, p_HireDate);
    DBMS_OUTPUT.PUT_LINE('Employee hired: ' || p_Name);
  END;

  PROCEDURE UpdateEmployee(p_ID NUMBER, p_Salary NUMBER) IS
  BEGIN
    UPDATE Employees
    SET Salary = p_Salary
    WHERE EmployeeID = p_ID;
    DBMS_OUTPUT.PUT_LINE('Employee salary updated for ID: ' || p_ID);
  END;

  FUNCTION GetAnnualSalary(p_ID NUMBER) RETURN NUMBER IS
    v_Salary NUMBER;
  BEGIN
    SELECT Salary INTO v_Salary FROM Employees WHERE EmployeeID = p_ID;
    RETURN v_Salary * 12;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN -1;
  END;
END EmployeeManagement;
/

-- Test
BEGIN
  EmployeeManagement.HireEmployee(5, 'Nina Patel', 'Tester', 50000, 'QA', SYSDATE);
  DBMS_OUTPUT.PUT_LINE('Annual Salary: ₹' || EmployeeManagement.GetAnnualSalary(5));
END;
/

---------------------------------------------------------
-- Scenario 3: AccountOperations Package
-- Includes: Open, Close, GetTotalBalance
---------------------------------------------------------
CREATE OR REPLACE PACKAGE AccountOperations AS
  PROCEDURE OpenAccount(p_AccountID NUMBER, p_CustomerID NUMBER, p_Type VARCHAR2, p_Balance NUMBER);
  PROCEDURE CloseAccount(p_AccountID NUMBER);
  FUNCTION GetTotalBalance(p_CustomerID NUMBER) RETURN NUMBER;
END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations AS
  PROCEDURE OpenAccount(p_AccountID NUMBER, p_CustomerID NUMBER, p_Type VARCHAR2, p_Balance NUMBER) IS
  BEGIN
    INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
    VALUES (p_AccountID, p_CustomerID, p_Type, p_Balance, SYSDATE);
    DBMS_OUTPUT.PUT_LINE('Account opened for Customer ID: ' || p_CustomerID);
  END;

  PROCEDURE CloseAccount(p_AccountID NUMBER) IS
  BEGIN
    DELETE FROM Accounts WHERE AccountID = p_AccountID;
    DBMS_OUTPUT.PUT_LINE('Account closed: ' || p_AccountID);
  END;

  FUNCTION GetTotalBalance(p_CustomerID NUMBER) RETURN NUMBER IS
    v_Total NUMBER;
  BEGIN
    SELECT NVL(SUM(Balance), 0) INTO v_Total FROM Accounts WHERE CustomerID = p_CustomerID;
    RETURN v_Total;
  END;
END AccountOperations;
/

-- Test
BEGIN
  AccountOperations.OpenAccount(200, 10, 'Savings', 5000);
  DBMS_OUTPUT.PUT_LINE('Total Balance: ₹' || AccountOperations.GetTotalBalance(10));
  AccountOperations.CloseAccount(200);
END;
/
