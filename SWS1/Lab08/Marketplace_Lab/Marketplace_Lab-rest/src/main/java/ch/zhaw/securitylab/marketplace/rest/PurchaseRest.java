package ch.zhaw.securitylab.marketplace.rest;

import ch.zhaw.securitylab.marketplace.dto.CheckoutDto;
import ch.zhaw.securitylab.marketplace.facade.ProductFacade;
import ch.zhaw.securitylab.marketplace.facade.PurchaseFacade;
import ch.zhaw.securitylab.marketplace.model.Product;
import ch.zhaw.securitylab.marketplace.model.Purchase;
import java.security.InvalidParameterException;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import java.math.BigDecimal;
import javax.enterprise.context.RequestScoped;
import javax.validation.Valid;

@RequestScoped
@Path("purchases")
public class PurchaseRest {

    @Inject
    private PurchaseFacade purchaseFacade;
    @Inject
    private ProductFacade productFacade;

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void post(@Valid CheckoutDto checkoutDto) {
        BigDecimal totalPrice = new BigDecimal(0.0);
        BigDecimal price;
        Product product;
        int validProductIds = 0;

        for (String productCode : checkoutDto.getProductCodes()) {
            product = productFacade.findByCode(productCode);
            if (product != null) {
                totalPrice = totalPrice.add(product.getPrice());
                validProductIds++;
            }
        }
        if (validProductIds > 0) {
            Purchase purchase = new Purchase();
            purchase.setFirstname(checkoutDto.getFirstname());
            purchase.setLastname(checkoutDto.getLastname());
            purchase.setCreditCardNumber(checkoutDto.getCreditCardNumber());
            purchase.setTotalPrice(totalPrice);
            purchaseFacade.create(purchase);
        } else {
            throw new InvalidParameterException("The purchase could not be completed because no valid product codes were submitted");
        }
    }
}
