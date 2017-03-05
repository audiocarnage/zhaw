package ch.zhaw.securitylab.marketplace.rest;

import ch.zhaw.securitylab.marketplace.dto.AdminProductDto;
import ch.zhaw.securitylab.marketplace.dto.ProductDto;
import java.util.List;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import ch.zhaw.securitylab.marketplace.facade.ProductFacade;
import ch.zhaw.securitylab.marketplace.model.Product;
import ch.zhaw.securitylab.marketplace.service.AdminProductService;
import java.security.AccessControlException;
import java.security.InvalidParameterException;
import java.util.ArrayList;
import javax.enterprise.context.RequestScoped;
import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.POST;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.SecurityContext;

@RequestScoped
@Path("admin/products")
public class AdminProductRest {

    @Inject
    private ProductFacade productFacade;
    @Inject
    AdminProductService productService;
    @Context SecurityContext securityContext;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<AdminProductDto> get() {
        List<Product> products = productFacade.findAll();
        List<AdminProductDto> adminProductDtoList = new ArrayList<>();
        for (Product product : products) {
            adminProductDtoList.add(new AdminProductDto(product));
        }
        return adminProductDtoList;
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void post(@Valid ProductDto productDto) {
        if (productFacade.findByDescription(productDto.getDescription()) == null)
            throw new InvalidParameterException("The product could not be created because the submitted product description already exists.");
        
        Product product = new Product();
        product.setCode(productDto.getCode());
        product.setDescription(productDto.getDescription());
        product.setPrice(productDto.getPrice());
        product.setUsername(securityContext.getUserPrincipal().getName());
        
        if (!productService.insertProduct(product)) {
            throw new InvalidParameterException("The product could not be added as a product with the same code already exists.");    
        }
    }

    @DELETE
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void delete(@PathParam("id") @Min(value = 1, message = "The purchaseID must be between 1 and 999'999")
            @Max(value = 999999, message = "The PurchaseID must be between 1 and 999'999") String id) {
        Product product = productFacade.findById(Integer.parseInt(id));
        String user = securityContext.getUserPrincipal().getName();
        
        if (product != null && !product.getUsername().equals(user))
            throw new AccessControlException("Access denied, only the own products can be deleted");
        
        if (product != null)
            productFacade.remove(product);
        else
            throw new InvalidParameterException("The product with ProductID = '" + id + "' does not exist");
    }
}
