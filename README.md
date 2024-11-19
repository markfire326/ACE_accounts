# Ace Accounts Management System
## Overview
This project demonstrates the use of stored procedures, functions, and triggers to handle key tasks such as payment updates, overdue calculations, balance retrieval, and overpayment management.
This repository provides all necessary SQL scripts, test cases, and documentation for the system.

## Features
- Streamlined Payment Updates: Update payment amounts and dates efficiently using the Update_Payment procedure.
- Late Payment Calculation: Automatically determine how many days a payment is overdue using the Late_Payment_Days procedure.
- Outstanding Balance Retrieval: Calculate and return the outstanding balance for any invoice using the Return_Balance_Due function.
- Overpayment Management: Handle overpayments using the Over_Payment_Trig trigger, which adjusts credits and prevents inconsistencies.

## Business Use Cases
This system was developed to address common challenges in invoice and payment management, including:
- Automating manual processes.
- Improving data accuracy.
- Preventing overpayments and managing credits.
- Enhancing customer satisfaction by providing timely insights into payments and balances.

## Applications and Example Scenarios
This system can be applied to multiple industry case scenarios, i have listed some below:
- A customer requests for details on late fees, and the system calculates overdue days.
- The system provides alerts when an overpayment occurs.
- The customer account credit system automatically adjusts for a scenario of an over-payment.

# Contribution
If you’d like to contribute or suggest improvements, feel free to fork the repository and create a pull request. Feedback is always welcome!

# License
This project is completely open-source.
