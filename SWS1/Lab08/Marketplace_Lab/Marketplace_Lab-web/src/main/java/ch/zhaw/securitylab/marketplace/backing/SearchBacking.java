package ch.zhaw.securitylab.marketplace.backing;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.inject.Inject;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import ch.zhaw.securitylab.marketplace.facade.ProductFacade;
import ch.zhaw.securitylab.marketplace.model.Product;
import javax.validation.constraints.Size;

@Named
@SessionScoped
public class SearchBacking implements Serializable {

    private static final long serialVersionUID = 1L;
    @Inject
    private ProductFacade productFacade;
    @Size(max=50, message = "The search string must not be longer than 50 characters")
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
        products = productFacade.findByDescription(searchString);
        return "/view/public/search";
    }

    public int getCount() {
        return products.size();
    }
}
