package ch.zhaw.securitylab.marketplace.backing;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.inject.Inject;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import ch.zhaw.securitylab.marketplace.database.ProductDatabase;
import ch.zhaw.securitylab.marketplace.model.Product;

@Named
@SessionScoped
public class SearchBacking implements Serializable {

    private static final long serialVersionUID = 1L;
    @Inject
    private ProductDatabase productDatabase;
    private String searchString;
    private List<Product> products = new ArrayList<>();

    public String getSearchString() {
        return searchString;
    }

    public void setSearchString(String searchString) {
        this.searchString = searchString;
    }

    public List<Product> getProducts() {
        return products;
    }

    public String search() {
        products = productDatabase.searchProducts(searchString);
        return "/view/public/search";
    }

    public int getCount() {
        return products.size();
    }
}
