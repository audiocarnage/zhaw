/************************************************************************************
* Set the credit card number in Purchase to encrypted credit card numbers
*************************************************************************************/

SET SQL_SAFE_UPDATES = 0;

USE marketplace;

UPDATE Purchase SET CreditCardNumber = 'jE9cBwBynmsQLw1N5avp2xW1Vg0W1vOi4V+W6h2xsm10VrpjrPY8OukN/rdl0MhH';

SET SQL_SAFE_UPDATES = 1;