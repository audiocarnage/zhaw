package ch.zhaw.securitylab.marketplace.facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import ch.zhaw.securitylab.marketplace.model.Product;

@Stateless
public class ProductFacade extends AbstractFacade<Product> {

    @PersistenceContext(unitName = "marketplace")
    private EntityManager entityManager;

    public ProductFacade() {
        super(Product.class);
    }

    @Override
    protected EntityManager getEntityManager() {
        return entityManager;
    }
    
    public Product findById(int id) {
        Query query = entityManager.createNamedQuery("Product.findById");
        query.setParameter("productID", id);
        return getSingleResultOrNull(query);
    }

    public List<Product> findByDescription(String description) {
        Query query = entityManager.createNamedQuery("Product.findByDescription");
        query.setParameter("description", "%" + description + "%");
        return query.getResultList();
    }

    public Product findByCode(String code) {
        Query query = entityManager.createNamedQuery("Product.findByCode");
        query.setParameter("code", code);
        return getSingleResultOrNull(query);
    }
    
}
