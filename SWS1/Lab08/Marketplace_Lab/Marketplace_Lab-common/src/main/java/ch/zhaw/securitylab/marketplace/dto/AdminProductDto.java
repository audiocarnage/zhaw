package ch.zhaw.securitylab.marketplace.dto;

import ch.zhaw.securitylab.marketplace.model.Product;
import java.math.BigDecimal;

public class AdminProductDto {

    private String code;
    private String description;
    private BigDecimal price;
    private String username;

    public AdminProductDto() {
    }

    public AdminProductDto(Product product) {
        code = product.getCode();
        description = product.getDescription();
        price = product.getPrice();
        username = product.getUsername();
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
