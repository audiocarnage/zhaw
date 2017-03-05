package ch.zhaw.securitylab.marketplace.backing;

import ch.zhaw.securitylab.marketplace.facade.ProductFacade;
import java.util.List;
import javax.inject.Inject;
import javax.inject.Named;
import javax.annotation.PostConstruct;
import ch.zhaw.securitylab.marketplace.model.Product;
import javax.enterprise.context.RequestScoped;

@Named
@RequestScoped
public class AdminProductBacking {

    @Inject
    private ProductFacade productFacade;
    private List<Product> products;

    @PostConstruct
    public void init() {
        products = productFacade.findAll();
    }

    public List<Product> getProducts() {
        return products;
    }

    public int getCount() {
        return products.size();
    }

    public String remove(Product product) {
        productFacade.remove(product);
        products.remove(product);
        return "/view/admin/admin";
    }
}
