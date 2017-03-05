package ch.zhaw.securitylab.marketplace.facade;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import ch.zhaw.securitylab.marketplace.model.Purchase;
import javax.persistence.Query;

@Stateless
public class PurchaseFacade extends AbstractFacade<Purchase> {

    @PersistenceContext(unitName = "marketplace")
    private EntityManager entityManager;

    public PurchaseFacade() {
        super(Purchase.class);
    }

    @Override
    protected EntityManager getEntityManager() {
        return entityManager;
    }

    public Purchase findById(int id) {
        Query query = entityManager.createNamedQuery("Purchase.findById");
        query.setParameter("purchaseID", id);
        return getSingleResultOrNull(query);
    }

}
