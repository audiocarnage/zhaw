package ch.zhaw.securitylab.marketplace.dto;

import ch.zhaw.securitylab.marketplace.validation.CreditCardCheck;
import java.util.ArrayList;
import java.util.List;
import javax.validation.constraints.Pattern;

public class CheckoutDto {
    
    @Pattern(regexp = "^[a-zA-Z']{2,32}$",
            message = "Please insert a valid first name (between 2 and 32 characters)")
    private String firstname;
    @Pattern(regexp = "^[a-zA-Z']{2,32}$",
            message = "Please insert a valid last name (between 2 and 32 characters)")
    private String lastname;
    @CreditCardCheck
    private String creditCardNumber;
    List<String> productCodes;

    public CheckoutDto() {
        productCodes = new ArrayList<>();
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getCreditCardNumber() {
        return creditCardNumber;
    }

    public void setCreditCardNumber(String creditCardNumber) {
        this.creditCardNumber = creditCardNumber;
    }

    public List<String> getProductCodes() {
        return productCodes;
    }

    public void setProductCodes(List<String> productCodes) {
        this.productCodes = productCodes;
    }
}
