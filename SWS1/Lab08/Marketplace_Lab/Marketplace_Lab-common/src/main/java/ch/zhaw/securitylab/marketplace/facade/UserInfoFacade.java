package ch.zhaw.securitylab.marketplace.facade;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import ch.zhaw.securitylab.marketplace.model.UserInfo;

@Stateless
public class UserInfoFacade extends AbstractFacade<UserInfo> {

    private static final long serialVersionUID = 1L;

    @PersistenceContext(unitName = "marketplace")
    private EntityManager entityManager;

    public UserInfoFacade() {
        super(UserInfo.class);
    }

    @Override
    protected EntityManager getEntityManager() {
        return entityManager;
    }

    public UserInfo findByUsername(String username) {
        Query query = entityManager.createNamedQuery("UserInfo.findByUsername");
        query.setParameter("username", username);
        return getSingleResultOrNull(query);
    }
}
