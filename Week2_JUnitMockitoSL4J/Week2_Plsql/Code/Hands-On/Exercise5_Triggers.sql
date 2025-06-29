-- Enable output
SET SERVEROUTPUT ON;

---------------------------------------------------
-- TABLES (Assumed already created earlier)
-- Customers, Accounts, Transactions
---------------------------------------------------

-- Create AuditLog table for Scenario 2
CREATE TABLE AuditLog (
    LogID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    TransactionID NUMBER,
    AccountID NUMBER,
    Action VARCHAR2(20),
    LogDate DATE
);

---------------------------------------------------
-- SCENARIO 1: Update Last Modified when customer is updated
---------------------------------------------------
CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    :NEW.LastModified := SYSDATE;
END;
/

-- Test Scenario 1
UPDATE Customers
SET Name = 'John D. Updated'
WHERE CustomerID = 1;

SELECT CustomerID, Name, LastModified FROM Customers;

---------------------------------------------------
-- SCENARIO 2: Log transaction insert into AuditLog
---------------------------------------------------
CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (TransactionID, AccountID, Action, LogDate)
    VALUES (:NEW.TransactionID, :NEW.AccountID, 'INSERT', SYSDATE);
END;
/

-- Test Scenario 2
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (3, 101, SYSDATE, 1000, 'Deposit');

SELECT * FROM AuditLog;

---------------------------------------------------
-- SCENARIO 3: Enforce transaction rules (withdrawals must not exceed balance, deposits must be positive)
---------------------------------------------------
CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
DECLARE
    v_Balance NUMBER;
BEGIN
    -- Withdrawals must not exceed account balance
    IF :NEW.TransactionType = 'Withdrawal' THEN
        SELECT Balance INTO v_Balance FROM Accounts WHERE AccountID = :NEW.AccountID;
        IF :NEW.Amount > v_Balance THEN
            RAISE_APPLICATION_ERROR(-20001, 'Withdrawal exceeds account balance.');
        END IF;
    ELSIF :NEW.TransactionType = 'Deposit' THEN
        -- Deposits must be positive
        IF :NEW.Amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Deposit amount must be positive.');
        END IF;
    END IF;
END;
/

-- Test Scenario 3 (valid withdrawal)
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (4, 101, SYSDATE, 100, 'Withdrawal');

-- Test Scenario 3 (invalid withdrawal - more than balance)
BEGIN
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (5, 101, SYSDATE, 999999, 'Withdrawal');
END;
/

-- Test Scenario 3 (invalid deposit - negative amount)
BEGIN
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (6, 101, SYSDATE, -100, 'Deposit');
END;
/
