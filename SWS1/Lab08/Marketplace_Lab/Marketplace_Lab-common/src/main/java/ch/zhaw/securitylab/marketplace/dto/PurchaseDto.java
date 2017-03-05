package ch.zhaw.securitylab.marketplace.dto;

import ch.zhaw.securitylab.marketplace.model.Purchase;
import java.math.BigDecimal;

public class PurchaseDto {
    private String firstname;
    private String lastname;
    private String creditCardNumber;
    private BigDecimal totalPrice;

    public PurchaseDto() {
    }

    public PurchaseDto(Purchase purchase) {
        firstname = purchase.getFirstname();
        lastname = purchase.getFirstname();
        creditCardNumber = purchase.getCreditCardNumber();
        totalPrice = purchase.getTotalPrice();
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

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }
}
