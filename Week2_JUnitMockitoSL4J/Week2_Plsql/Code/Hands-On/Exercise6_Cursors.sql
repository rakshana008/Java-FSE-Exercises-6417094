-- Enable DBMS Output
SET SERVEROUTPUT ON;

---------------------------------------------------------
-- Assumed Tables: Transactions, Accounts, Loans
---------------------------------------------------------

-- Sample data for demonstration (if needed)
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (10, 101, SYSDATE, 500, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (11, 101, SYSDATE, 300, 'Withdrawal');

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (3, 1, 10000, 7, SYSDATE, ADD_MONTHS(SYSDATE, 60));

COMMIT;

---------------------------------------------------------
-- Scenario 1: GenerateMonthlyStatements
-- Description: Fetch and display this month’s transactions
---------------------------------------------------------
DECLARE
  CURSOR txn_cursor IS
    SELECT t.AccountID, t.TransactionDate, t.Amount, t.TransactionType
    FROM Transactions t
    WHERE TRUNC(t.TransactionDate, 'MM') = TRUNC(SYSDATE, 'MM');

  v_Record txn_cursor%ROWTYPE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- Monthly Statement ---');
  OPEN txn_cursor;
  LOOP
    FETCH txn_cursor INTO v_Record;
    EXIT WHEN txn_cursor%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('Account: ' || v_Record.AccountID ||
                         ', Date: ' || TO_CHAR(v_Record.TransactionDate, 'DD-MON-YYYY') ||
                         ', Amount: ₹' || v_Record.Amount ||
                         ', Type: ' || v_Record.TransactionType);
  END LOOP;
  CLOSE txn_cursor;
END;
/

---------------------------------------------------------
-- Scenario 2: ApplyAnnualFee
-- Description: Deduct maintenance fee from all accounts
---------------------------------------------------------
DECLARE
  CURSOR acc_cursor IS
    SELECT AccountID, Balance FROM Accounts;

  v_Account acc_cursor%ROWTYPE;
  v_Fee CONSTANT NUMBER := 100;
BEGIN
  OPEN acc_cursor;
  LOOP
    FETCH acc_cursor INTO v_Account;
    EXIT WHEN acc_cursor%NOTFOUND;

    UPDATE Accounts
    SET Balance = Balance - v_Fee
    WHERE AccountID = v_Account.AccountID;

    DBMS_OUTPUT.PUT_LINE('Annual fee of ₹' || v_Fee || ' applied to Account ID: ' || v_Account.AccountID);
  END LOOP;
  CLOSE acc_cursor;

  COMMIT;
END;
/

---------------------------------------------------------
-- Scenario 3: UpdateLoanInterestRates
-- Description: Update all loan interest rates based on new policy
---------------------------------------------------------
DECLARE
  CURSOR loan_cursor IS
    SELECT LoanID, InterestRate FROM Loans;

  v_Loan loan_cursor%ROWTYPE;
BEGIN
  OPEN loan_cursor;
  LOOP
    FETCH loan_cursor INTO v_Loan;
    EXIT WHEN loan_cursor%NOTFOUND;

    UPDATE Loans
    SET InterestRate = InterestRate + 0.5 -- Policy: increase by 0.5%
    WHERE LoanID = v_Loan.LoanID;

    DBMS_OUTPUT.PUT_LINE('Loan ID ' || v_Loan.LoanID || ' interest rate updated to ' || (v_Loan.InterestRate + 0.5));
  END LOOP;
  CLOSE loan_cursor;

  COMMIT;
END;
/
