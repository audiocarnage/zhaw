package ch.zhaw.securitylab.marketplace.backing;

import ch.zhaw.securitylab.marketplace.database.PurchaseDatabase;
import java.io.Serializable;
import javax.inject.Inject;
import javax.inject.Named;
import ch.zhaw.securitylab.marketplace.model.Purchase;
import ch.zhaw.securitylab.marketplace.service.CartService;
import ch.zhaw.securitylab.marketplace.util.Message;
import javax.enterprise.context.RequestScoped;

@Named
@RequestScoped
public class CheckoutBacking implements Serializable {

    private static final long serialVersionUID = 1L;
    @Inject
    private PurchaseDatabase purchaseDatabase;
    @Inject
    private CartService cartService;
    private Purchase purchase = new Purchase();

    public Purchase getPurchase() {
        return purchase;
    }

    public String completePurchase() {
        purchase.setTotalPrice(cartService.getTotalPrice());
        if (purchaseDatabase.insert(purchase) > 0) {
            Message.setMessage("Your purchase has been completed, thank you for shopping with us");
        } else {
            Message.setMessage("A problem occurred, please try again later");
        }
        cartService.empty();
        return "/view/public/search";
    }
}
