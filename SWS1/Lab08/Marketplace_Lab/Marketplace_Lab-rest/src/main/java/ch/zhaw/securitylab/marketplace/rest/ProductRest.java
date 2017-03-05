package ch.zhaw.securitylab.marketplace.rest;

import java.util.List;
import javax.inject.Inject;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import ch.zhaw.securitylab.marketplace.facade.ProductFacade;
import ch.zhaw.securitylab.marketplace.model.Product;
import ch.zhaw.securitylab.marketplace.dto.ProductDto;
import java.util.ArrayList;
import javax.enterprise.context.RequestScoped;
import javax.validation.constraints.Size;

@RequestScoped
@Path("products")
public class ProductRest {

    @Inject
    private ProductFacade productFacade;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<ProductDto> getFiltered(@Size(max=50, message = "The search string must not be longer than 50 characters") @DefaultValue("") @QueryParam("filter") String filter) {
        List<Product> products = productFacade.findByDescription(filter);
        List<ProductDto> productDtoList = new ArrayList<>();
        for (Product product : products) {
            productDtoList.add(new ProductDto(product));
        }
        return productDtoList;
    }
}
