-- This script will create the package for the case study

-- Enable output display on the DBMS line
SET SERVEROUTPUT ON;

-- First, I create the package specification with the code below:

CREATE OR REPLACE PACKAGE Acme_Accounts AS
    PROCEDURE Update_Payment(Inv_ID_P NUMBER, Amt_Paid_P NUMBER);
    PROCEDURE Late_Payment_Days(Inv_ID_P NUMBER);
    FUNCTION Return_Balance_Due (Inv_ID_P IN NUMBER) RETURN NUMBER;
END;
/
SHOW ERROR;

-- Creating Package body to hold procedures and function

CREATE OR REPLACE PACKAGE BODY Acme_Accounts AS


-- CREATING UPDATE_PAYMENT PROCEDURE

PROCEDURE Update_Payment(Inv_ID_P NUMBER, Amt_Paid_P NUMBER) AS 
    BEGIN
        UPDATE Invoices
        SET Payment_Total = Payment_Total + Amt_Paid_P,
            Payment_Date = SYSDATE
        WHERE Invoice_ID = Inv_ID_P; 
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
    END;


-- CREATING LATE_PAYMENT_DAYS PROCEDURE

PROCEDURE Late_Payment_Days(Inv_ID_P NUMBER) AS 
    due_date_P DATE;
    payment_date_P DATE;
    num_late_days_P NUMBER;

    BEGIN
        SELECT invoice_due_date, Payment_Date INTO due_date_P, payment_date_P
        FROM Invoices
        WHERE Invoice_ID = Inv_ID_P;

        IF payment_date_P IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('No Payment Received!');
        ELSE
            num_late_days_P := payment_date_P - due_date_P;

            IF num_late_days_P > 0 THEN
                DBMS_OUTPUT.PUT_LINE('Payment received ' || num_late_days_P || ' days late');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Payment received on time!');
            END IF;
        END IF;
    END;


-- CREATING THE RETURN_BALANCE_DUE FUNCTION

FUNCTION Return_Balance_Due(Inv_ID_P NUMBER) RETURN NUMBER AS 
    total_invoice_p NUMBER;
    total_payment_p NUMBER;
    total_credit_p NUMBER;
    balance_due_p NUMBER;

    BEGIN
        SELECT invoice_total, Payment_Total, credit_total INTO total_invoice_p, total_payment_p, total_credit_p
        FROM Invoices
        WHERE Invoice_ID = Inv_ID_P;

        balance_due_p := total_invoice_p - total_payment_p - total_credit_p;
        RETURN balance_due_p;
        DBMS_OUTPUT.PUT_LINE('Balance due for Invoice ID ' || Inv_ID_P || 'is : ' || balance_due_p);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;

END Acme_Accounts;
/
SHOW ERROR;
