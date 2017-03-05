package ch.zhaw.securitylab.marketplace.backing;

import ch.zhaw.securitylab.marketplace.facade.PurchaseFacade;
import javax.inject.Inject;
import javax.inject.Named;
import ch.zhaw.securitylab.marketplace.model.Purchase;
import ch.zhaw.securitylab.marketplace.service.CartService;
import ch.zhaw.securitylab.marketplace.util.Message;
import javax.enterprise.context.RequestScoped;

@Named
@RequestScoped
public class CheckoutBacking {

    @Inject
    private PurchaseFacade purchaseFacade;
    @Inject
    private CartService cartService;
    private Purchase purchase = new Purchase();

    public Purchase getPurchase() {
        return purchase;
    }

    public String completePurchase() {
        purchase.setTotalPrice(cartService.getTotalPrice());
        try {
            purchaseFacade.create(purchase);
            Message.setMessage("Your purchase has been completed, thank you for shopping with us");
        } catch (Exception e) {
            Message.setMessage("A problem occurred, please try again later");
        } finally {
            cartService.empty();
        }
        return "/view/public/search";
    }
}
