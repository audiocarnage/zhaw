package ch.zhaw.securitylab.marketplace.service;

import ch.zhaw.securitylab.marketplace.facade.ProductFacade;
import ch.zhaw.securitylab.marketplace.model.Product;
import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;


@RequestScoped
public class AdminProductService {

    @Inject
    private ProductFacade productFacade;
    
    /**
     * Inserts product into the database if no product with the same code
     * already exists.
     * 
     * @param product The product to insert
     * @return true if the product was inserted, false otherwise
     */
    public boolean insertProduct(Product product) {
        Product p = productFacade.findByCode(product.getCode());
        if (p != null)
            return false;
        productFacade.create(product);
        return true;
    }
}
