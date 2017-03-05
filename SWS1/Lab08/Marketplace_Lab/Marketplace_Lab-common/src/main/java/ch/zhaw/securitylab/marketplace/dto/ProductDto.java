package ch.zhaw.securitylab.marketplace.dto;

import ch.zhaw.securitylab.marketplace.model.Product;
import java.math.BigDecimal;
import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class ProductDto {

    @Pattern(regexp = "^[a-zA-Z0-9]{4}$", 
            message = "Please insert a valid code (4 letters/digits)")
    private String code;
    @Pattern(regexp = "^[a-zA-Z0-9\\s,'-]{10,100}$", 
            message = "Please insert a valid description (10-100 characters: letters/digits/-/,'\')")
    private String description;
    
    @DecimalMin(value = "0.0", 
            message = "Valid price must not be negative")
    @DecimalMax(value = "999999.99", 
            message = "Please enter a price smaller than 1'000'000.00")
    @Digits(integer=6, fraction=2, 
            message = "Valid price must be max 6 integer digits and max 2 fraction digits")
    @NotNull
    private BigDecimal price;

    public ProductDto() {
    }

    public ProductDto(Product product) {
        code = product.getCode();
        description = product.getDescription();
        price = product.getPrice();
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}
