-- TRIGGER FOR OVERPAYMENT

CREATE OR REPLACE TRIGGER Over_Payment_Trig
BEFORE UPDATE ON Invoices
FOR EACH ROW
DECLARE
    T_Invoice_Total NUMBER;
    T_Excess_Payment NUMBER;
BEGIN
    -- Get the invoice total from the current row
    T_Invoice_Total := :NEW.invoice_total;

    -- Check if the new payment total plus credit total exceeds the invoice total
    IF (:NEW.payment_total + :NEW.credit_total) > T_Invoice_Total THEN
        -- Calculate the excess payment
        T_Excess_Payment := (:NEW.payment_total + :NEW.credit_total) - T_Invoice_Total;

        -- Adjust the payment total to match the invoice total
        :NEW.payment_total := T_Invoice_Total;

        -- Add the excess to the credit total
        :NEW.credit_total := T_Excess_Payment;

        -- Issue a warning message
        DBMS_OUTPUT.PUT_LINE('Your payment plus credit is more than your invoice total. You have paid off your invoice. Your credit total is adjusted.');
  END IF;
END;
/
SHOW ERROR;