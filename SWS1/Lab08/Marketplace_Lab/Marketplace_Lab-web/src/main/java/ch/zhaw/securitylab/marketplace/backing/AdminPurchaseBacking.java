package ch.zhaw.securitylab.marketplace.backing;

import java.util.List;
import javax.inject.Inject;
import javax.inject.Named;
import javax.annotation.PostConstruct;
import ch.zhaw.securitylab.marketplace.facade.PurchaseFacade;
import ch.zhaw.securitylab.marketplace.model.Purchase;
import javax.enterprise.context.RequestScoped;

@Named
@RequestScoped
public class AdminPurchaseBacking {

    @Inject
    private PurchaseFacade purchaseFacade;
    private List<Purchase> purchases;

    @PostConstruct
    private void init() {
        purchases = purchaseFacade.findAll();
    }

    public List<Purchase> getPurchases() {
        return purchases;
    }

    public int getCount() {
        return purchases.size();
    }

    public String remove(Purchase purchase) {
        purchaseFacade.remove(purchase);
        purchases.remove(purchase);
        return "/view/admin/admin";
    }
}
