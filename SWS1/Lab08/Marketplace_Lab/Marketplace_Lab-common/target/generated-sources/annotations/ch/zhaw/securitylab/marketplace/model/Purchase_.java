package ch.zhaw.securitylab.marketplace.model;

import java.math.BigDecimal;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2016-12-23T12:39:26")
@StaticMetamodel(Purchase.class)
public class Purchase_ { 

    public static volatile SingularAttribute<Purchase, String> firstname;
    public static volatile SingularAttribute<Purchase, BigDecimal> totalPrice;
    public static volatile SingularAttribute<Purchase, String> creditCardNumber;
    public static volatile SingularAttribute<Purchase, Integer> purchaseID;
    public static volatile SingularAttribute<Purchase, String> lastname;

}