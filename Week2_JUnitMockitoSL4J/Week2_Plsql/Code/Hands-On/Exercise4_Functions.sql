-- Enable output
SET SERVEROUTPUT ON;

---------------------------------------------------
-- TABLES (Assumed already created earlier)
-- Customers, Accounts
---------------------------------------------------

-- Sample data for testing
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (3, 'Ethan Ray', TO_DATE('1975-09-10', 'YYYY-MM-DD'), 11000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (105, 3, 'Savings', 7000, SYSDATE);

COMMIT;

---------------------------------------------------
-- FUNCTION 1: CalculateAge
-- Input: DOB
-- Output: Age in years
---------------------------------------------------
CREATE OR REPLACE FUNCTION CalculateAge(p_DOB IN DATE)
RETURN NUMBER IS
    v_Age NUMBER;
BEGIN
    v_Age := TRUNC(MONTHS_BETWEEN(SYSDATE, p_DOB)/12);
    RETURN v_Age;
END;
/

-- Test
DECLARE
    v_Result NUMBER;
BEGIN
    v_Result := CalculateAge(TO_DATE('1980-01-01','YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Age: ' || v_Result);
END;
/

---------------------------------------------------
-- FUNCTION 2: CalculateMonthlyInstallment
-- Input: LoanAmount, InterestRate (annual %), DurationYears
-- Output: Monthly EMI
---------------------------------------------------
CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment(
    p_LoanAmount IN NUMBER,
    p_AnnualRate IN NUMBER,
    p_Years IN NUMBER
) RETURN NUMBER IS
    v_MonthlyRate NUMBER := p_AnnualRate / 12 / 100;
    v_NumPayments NUMBER := p_Years * 12;
    v_EMI NUMBER;
BEGIN
    v_EMI := (p_LoanAmount * v_MonthlyRate) / 
             (1 - POWER(1 + v_MonthlyRate, -v_NumPayments));
    RETURN ROUND(v_EMI, 2);
END;
/

-- Test
DECLARE
    v_Emi NUMBER;
BEGIN
    v_Emi := CalculateMonthlyInstallment(100000, 8.5, 5);
    DBMS_OUTPUT.PUT_LINE('Monthly Installment: ₹' || v_Emi);
END;
/

---------------------------------------------------
-- FUNCTION 3: HasSufficientBalance
-- Input: AccountID, Amount
-- Output: TRUE if account has sufficient funds
---------------------------------------------------
CREATE OR REPLACE FUNCTION HasSufficientBalance(
    p_AccountID IN NUMBER,
    p_Amount IN NUMBER
) RETURN BOOLEAN IS
    v_Balance NUMBER;
BEGIN
    SELECT Balance INTO v_Balance
    FROM Accounts
    WHERE AccountID = p_AccountID;

    RETURN v_Balance >= p_Amount;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;
/

-- Test
DECLARE
    v_Result BOOLEAN;
BEGIN
    v_Result := HasSufficientBalance(105, 6000);
    IF v_Result THEN
        DBMS_OUTPUT.PUT_LINE('Sufficient balance available.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient balance.');
    END IF;
END;
/
