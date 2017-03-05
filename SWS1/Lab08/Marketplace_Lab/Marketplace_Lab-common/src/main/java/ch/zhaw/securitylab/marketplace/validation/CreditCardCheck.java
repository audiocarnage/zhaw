package ch.zhaw.securitylab.marketplace.validation;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import javax.validation.Constraint;
import javax.validation.Payload;
import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.*;

@Target({METHOD, FIELD})
@Retention(RUNTIME)
@Documented
@Constraint(validatedBy = CreditCardValidator.class)
public @interface CreditCardCheck {

    String message() default "Please insert a valid credit card number (16 digits)";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
