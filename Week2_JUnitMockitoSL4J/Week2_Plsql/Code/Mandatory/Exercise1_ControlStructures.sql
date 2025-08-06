-- exercise1_control_structures.sql--

-- Enable output--
SET SERVEROUTPUT ON;

----------------------------------------
-- CREATE TABLES --
----------------------------------------
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

----------------------------------------
-- INSERT SAMPLE DATA
----------------------------------------
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (1, 'John Doe', TO_DATE('1950-05-15', 'YYYY-MM-DD'), 1000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 15000, SYSDATE);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 2, 7000, 6, SYSDATE, ADD_MONTHS(SYSDATE, 10));

COMMIT;

----------------------------------------
-- SCENARIO 1: Apply 1% Discount for Customers > 60 Years Old
----------------------------------------
BEGIN
  FOR cust IN (
    SELECT c.CustomerID, l.LoanID, l.InterestRate, c.DOB
    FROM Customers c
    JOIN Loans l ON c.CustomerID = l.CustomerID
  ) LOOP
    IF MONTHS_BETWEEN(SYSDATE, cust.DOB) / 12 > 60 THEN
      UPDATE Loans
      SET InterestRate = cust.InterestRate - 1
      WHERE LoanID = cust.LoanID;

      DBMS_OUTPUT.PUT_LINE('1% discount applied for Customer ID: ' || cust.CustomerID);
    END IF;
  END LOOP;
END;
/

----------------------------------------
-- SCENARIO 2: Promote Customers to VIP if Balance > 10000
----------------------------------------
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE Customers ADD IsVIP VARCHAR2(5)';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -01430 THEN -- Column already exists
      RAISE;
    END IF;
END;
/

BEGIN
  UPDATE Customers SET IsVIP = 'FALSE';
  COMMIT;
END;
/

BEGIN
  FOR cust IN (SELECT CustomerID, Balance FROM Customers) LOOP
    IF cust.Balance > 10000 THEN
      UPDATE Customers
      SET IsVIP = 'TRUE'
      WHERE CustomerID = cust.CustomerID;

      DBMS_OUTPUT.PUT_LINE('Customer ID ' || cust.CustomerID || ' promoted to VIP.');
    END IF;
  END LOOP;
END;
/

----------------------------------------
-- SCENARIO 3: Loan Reminders Due in Next 30 Days
----------------------------------------
BEGIN
  FOR loan_rec IN (
    SELECT l.LoanID, l.CustomerID, c.Name, l.EndDate
    FROM Loans l
    JOIN Customers c ON l.CustomerID = c.CustomerID
    WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
  ) LOOP
    DBMS_OUTPUT.PUT_LINE(
      'Reminder: Loan ID ' || loan_rec.LoanID ||
      ' for customer ' || loan_rec.Name ||
      ' (Customer ID ' || loan_rec.CustomerID || ')' ||
      ' is due on ' || TO_CHAR(loan_rec.EndDate, 'DD-MON-YYYY')
    );
  END LOOP;
END;
/
