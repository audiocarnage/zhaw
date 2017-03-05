package ch.zhaw.securitylab.marketplace.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.enterprise.context.SessionScoped;
import ch.zhaw.securitylab.marketplace.model.Product;
import java.math.BigDecimal;

@SessionScoped
public class CartService implements Serializable {

    private static final long serialVersionUID = 1L;
    private final List<Product> products;

    public CartService() {
        products = new ArrayList<>();
    }

    public List<Product> getProducts() {
        return products;
    }

    public int getCount() {
        return products.size();
    }

    public void empty() {
        products.clear();
    }

    public BigDecimal getTotalPrice() {
        BigDecimal total = new BigDecimal(0.0);
        for (int i = 0; i < products.size(); i++) {
            total = total.add(products.get(i).getPrice());
        }
        return total;
    }

    public void addProduct(Product product) {
        if ((product != null) && !(products.contains(product))) {
            products.add(product);
        }
    }
}
