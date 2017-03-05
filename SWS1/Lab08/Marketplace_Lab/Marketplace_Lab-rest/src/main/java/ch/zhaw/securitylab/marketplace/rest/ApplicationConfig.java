package ch.zhaw.securitylab.marketplace.rest;

import java.util.HashSet;
import java.util.Set;
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

@ApplicationPath("rest")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new HashSet<>();
        addRestResourceClasses(resources);
        return resources;
    }
    
    /**
     * Do not modify addRestResourceClasses() method. It is automatically
     * populated with all resources defined in the project. If required, comment
     * out calling this method in getClasses().
     */
    private void addRestResourceClasses(Set<Class<?>> resources) {
        resources.add(ch.zhaw.securitylab.marketplace.rest.AdminProductRest.class);
        resources.add(ch.zhaw.securitylab.marketplace.rest.AdminPurchaseRest.class);
        resources.add(ch.zhaw.securitylab.marketplace.rest.AuthenticationRest.class);
        resources.add(ch.zhaw.securitylab.marketplace.rest.ConstraintViolationExceptionMapper.class);
        resources.add(ch.zhaw.securitylab.marketplace.rest.CustomExceptionMapper.class);
        resources.add(ch.zhaw.securitylab.marketplace.rest.ProductRest.class);
        resources.add(ch.zhaw.securitylab.marketplace.rest.PurchaseRest.class);
    }
}
