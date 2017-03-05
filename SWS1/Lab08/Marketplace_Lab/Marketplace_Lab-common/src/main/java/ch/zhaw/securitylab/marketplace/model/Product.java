package ch.zhaw.securitylab.marketplace.model;

import java.io.Serializable;
import java.math.BigDecimal;
import javax.persistence.*;
import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

@Entity
@Table(name = "Product")
@NamedQueries({
    @NamedQuery(name = "Product.findById", query = "Select p FROM Product p WHERE p.productID = :productID"),
    @NamedQuery(name = "Product.findByDescription", query = "SELECT p FROM Product p WHERE p.description LIKE :description"),
    @NamedQuery(name = "Product.findByCode", query = "SELECT p FROM Product p WHERE p.code = :code")})
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    private int productID;
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
    private String username;

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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof Product)) {
            return false;
        }
        Product other = (Product) obj;
        return productID == other.productID;
    }
}
