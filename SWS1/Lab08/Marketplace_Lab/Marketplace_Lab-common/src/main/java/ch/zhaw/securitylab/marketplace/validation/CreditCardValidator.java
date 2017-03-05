package ch.zhaw.securitylab.marketplace.validation;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class CreditCardValidator implements ConstraintValidator<CreditCardCheck, String> {

    @Override
    public void initialize(CreditCardCheck constraintAnnotation) {}

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        String numberValue = value.replaceAll("\\D", ""); // remove non-digits
        return checkRawFormat(value) && luhnCheck(numberValue);
    }

    private boolean checkRawFormat(String number) {
        return number.matches("^\\d{4}[ ]?\\d{4}[ ]?\\d{4}[ ]?\\d{4}$");
    }

    private boolean luhnCheck(String cardNumber) {
        int sum = 0;

        for (int i = cardNumber.length() - 1; i >= 0; i -= 2) {
            sum += Integer.parseInt(cardNumber.substring(i, i + 1));
            if (i > 0) {
                int d = 2 * Integer.parseInt(cardNumber.substring(i - 1, i));
                if (d > 9) {
                    d -= 9;
                }
                sum += d;
            }
        }
        return sum % 10 == 0;
    }
}
