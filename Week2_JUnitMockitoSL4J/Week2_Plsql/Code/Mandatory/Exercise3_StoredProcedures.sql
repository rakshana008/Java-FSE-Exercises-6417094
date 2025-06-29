-- Enable output
SET SERVEROUTPUT ON;

---------------------------------------------------
-- TABLES (assumed already created in Exercise 1/2)
-- Customers, Accounts, Employees
---------------------------------------------------

-- Sample data for demonstration (skip if already inserted)
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (103, 1, 'Savings', 5000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (104, 2, 'Savings', 8000, SYSDATE);

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (3, 'Carol Thomas', 'Tester', 55000, 'QA', TO_DATE('2018-01-10', 'YYYY-MM-DD'));

COMMIT;

---------------------------------------------------
-- PROCEDURE 1: ProcessMonthlyInterest
-- Apply 1% interest to all savings accounts
---------------------------------------------------
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
  FOR acc IN (
    SELECT AccountID, Balance
    FROM Accounts
    WHERE AccountType = 'Savings'
  ) LOOP
    UPDATE Accounts
    SET Balance = Balance + (acc.Balance * 0.01)
    WHERE AccountID = acc.AccountID;

    DBMS_OUTPUT.PUT_LINE('Interest applied to Account ID: ' || acc.AccountID);
  END LOOP;

  COMMIT;
END;
/

---------------------------------------------------
-- PROCEDURE 2: UpdateEmployeeBonus
-- Give bonus to employees in a department
---------------------------------------------------
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_Department IN VARCHAR2,
    p_BonusPercent IN NUMBER
) IS
BEGIN
  UPDATE Employees
  SET Salary = Salary + (Salary * p_BonusPercent / 100)
  WHERE Department = p_Department;

  IF SQL%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No employees found in department: ' || p_Department);
  ELSE
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' employee(s) received bonus in ' || p_Department || ' department.');
  END IF;

  COMMIT;
END;
/

---------------------------------------------------
-- PROCEDURE 3: TransferFunds
-- Transfer amount between two accounts after balance check
---------------------------------------------------
CREATE OR REPLACE PROCEDURE TransferFunds(
    p_SourceAccountID IN NUMBER,
    p_DestAccountID   IN NUMBER,
    p_Amount          IN NUMBER
) IS
    v_SourceBalance NUMBER;
BEGIN
    -- Check balance
    SELECT Balance INTO v_SourceBalance
    FROM Accounts
    WHERE AccountID = p_SourceAccountID;

    IF v_SourceBalance < p_Amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance in source account.');
    END IF;

    -- Perform transfer
    UPDATE Accounts SET Balance = Balance - p_Amount WHERE AccountID = p_SourceAccountID;
    UPDATE Accounts SET Balance = Balance + p_Amount WHERE AccountID = p_DestAccountID;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transfer of ' || p_Amount || ' successful from ' || p_SourceAccountID || ' to ' || p_DestAccountID);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error in TransferFunds: ' || SQLERRM);
END;
/

---------------------------------------------------
-- TESTING PROCEDURES
---------------------------------------------------

-- 1. Apply 1% interest to savings accounts
BEGIN
  ProcessMonthlyInterest;
END;
/

-- 2. Give 10% bonus to QA department
BEGIN
  UpdateEmployeeBonus('QA', 10);
END;
/

-- 3. Transfer ₹1000 from account 103 to 104
BEGIN
  TransferFunds(103, 104, 1000);
END;
/
