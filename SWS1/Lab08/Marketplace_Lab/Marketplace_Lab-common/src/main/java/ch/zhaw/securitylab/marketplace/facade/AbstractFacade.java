package ch.zhaw.securitylab.marketplace.facade;

import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.ValidationException;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;

public abstract class AbstractFacade<T> implements Serializable {

    private static final long serialVersionUID = 1L;
    private final Class<T> entityClass;

    /**
     * Constructs a new {@link AbstractFacade} from a given {@link Class}.
     *
     * @param entityClass
     */
    public AbstractFacade(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    /**
     *
     * @return the {@link EntityManager}.
     */
    protected abstract EntityManager getEntityManager();

    /**
     *
     * @param query
     * @return a single result or otherwise null.
     */
    @SuppressWarnings("unchecked")
    public T getSingleResultOrNull(Query query) {
        query.setMaxResults(1);
        List<T> list = query.getResultList();
        if (list.isEmpty()) {
            return null;
        }
        return list.get(0);
    }

    /**
     *
     * @return the first entity found.
     */
    public T getFirst() {
        return find(1);
    }

    /**
     * Creates an entity. If a {@link ConstraintViolation} occurs it will be
     * forwarded to System.err. Otherwise it is pretty hard to find a
     * {@link ConstraintViolation} during the development.
     *
     * @param entity
     */
    public void create(T entity) {
        //checkConstraintsViolations(entity);
        getEntityManager().persist(entity);
    }

    /**
     * Creates a {@link Collection} of entities.
     *
     * @param entities
     */
    public void create(Collection<T> entities) {
        for (T entity : entities) {
            this.create(entity);
        }
    }

    /**
     * Edits an entity. If a {@link ConstraintViolation} occurs it will be
     * forwarded to System.err. Otherwise it is pretty hard to find a
     * {@link ConstraintViolation} during the development.
     *
     * @param entity
     */
    public void edit(T entity) {
        //checkConstraintsViolations(entity);
        getEntityManager().merge(entity);
    }

    /**
     * Edits a {@link Collection} of entities.
     *
     * @param entities
     */
    public void edit(Collection<T> entities) {
        for (T entity : entities) {
            this.edit(entity);
        }
    }

    /**
     * Removes an an entity.
     *
     * @param entity
     */
    public void remove(T entity) {
        getEntityManager().remove(getEntityManager().merge(entity));
    }

    /**
     * Removes a {@link Collection} of entities.
     *
     * @param entities
     */
    public void remove(Collection<T> entities) {
        for (T entity : entities) {
            this.remove(entity);
        }
    }

    /**
     *
     * @param id
     * @return an entity identified by the given id.
     */
    public T find(Object id) {
        return getEntityManager().find(entityClass, id);
    }

    /**
     *
     * @return a {@link List} of all entities.
     */
    public List<T> findAll() {
        CriteriaQuery criteriaQuery = getEntityManager().getCriteriaBuilder().createQuery();
        criteriaQuery.select(criteriaQuery.from(entityClass));
        return getEntityManager().createQuery(criteriaQuery).getResultList();
    }

    /**
     *
     * @param range
     * @return a {@link List} of all entities within a range.
     */
    public List<T> findRange(int[] range) {
        CriteriaQuery criteriaQuery = getEntityManager().getCriteriaBuilder().createQuery();
        criteriaQuery.select(criteriaQuery.from(entityClass));
        Query query = getEntityManager().createQuery(criteriaQuery);
        query.setMaxResults(range[1] - range[0] + 1);
        query.setFirstResult(range[0]);
        return query.getResultList();
    }

    /**
     *
     * @return the count of all entities.
     */
    public int count() {
        CriteriaQuery criteriaQuery = getEntityManager().getCriteriaBuilder().createQuery();
        Root<T> root = criteriaQuery.from(entityClass);
        criteriaQuery.select(getEntityManager().getCriteriaBuilder().count(root));
        Query query = getEntityManager().createQuery(criteriaQuery);
        return ((Long) query.getSingleResult()).intValue();
    }

    /**
     * Detaches an entity.
     *
     * @param entity
     */
    public void detach(Object entity) {
        getEntityManager().detach(entity);
    }

    protected void checkConstraintsViolations(T entity) {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        Validator validator = factory.getValidator();
        Set<ConstraintViolation<T>> constraintViolations = validator.validate(entity);
        if (constraintViolations.size() > 0) {
            StringBuilder errorMessage = new StringBuilder();
            Iterator<ConstraintViolation<T>> iterator = constraintViolations.iterator();
            while (iterator.hasNext()) {
                ConstraintViolation<T> constraintViolation = iterator.next();
                System.err.println(constraintViolation.getRootBeanClass().getName() + "." + constraintViolation.getPropertyPath() + " " + constraintViolation.getMessage());
                if (errorMessage.length() > 0) {
                    errorMessage.append(", ");
                }
                errorMessage.append(constraintViolation.getMessage());
            }
            throw new ValidationException(errorMessage.toString());
        }
    }
}
