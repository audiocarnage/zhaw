package ch.zhaw.securitylab.marketplace.rest;

import ch.zhaw.securitylab.marketplace.dto.PurchaseDto;
import java.security.InvalidParameterException;
import java.util.List;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import ch.zhaw.securitylab.marketplace.facade.PurchaseFacade;
import ch.zhaw.securitylab.marketplace.model.Purchase;
import java.util.ArrayList;
import javax.enterprise.context.RequestScoped;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

@RequestScoped
@Path("admin/purchases")
public class AdminPurchaseRest {

    @Inject
    private PurchaseFacade purchaseFacade;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<PurchaseDto> get() {
        List<Purchase> purchases = purchaseFacade.findAll();
        List<PurchaseDto> purchaseDtoList = new ArrayList<>();
        for (Purchase purchase : purchases) {
            purchaseDtoList.add(new PurchaseDto(purchase));
        }
        return purchaseDtoList;
    }

    @DELETE
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void delete(@PathParam("id") @Min(value = 1, message = "The purchaseID must be between 1 and 999'999")
            @Max(value = 999999, message = "The PurchaseID must be between 1 and 999'999") String id) {
        Purchase purchase;
        purchase = purchaseFacade.findById(Integer.parseInt(id));
        if (purchase != null) {
            purchaseFacade.remove(purchase);
        } else {
            throw new InvalidParameterException("The purchase with PurchaseID = '" + id + "' does not exist");
        }
    }
}
