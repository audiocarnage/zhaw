package ch.zhaw.securitylab.marketplace.backing;

import javax.inject.Inject;
import javax.inject.Named;
import ch.zhaw.securitylab.marketplace.service.AdminProductService;
import ch.zhaw.securitylab.marketplace.util.Message;
import ch.zhaw.securitylab.marketplace.model.Product;
import javax.enterprise.context.RequestScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;

@Named
@RequestScoped
public class AddProductBacking {

    @Inject
    private AdminProductService productService;
    private Product product = new Product();

    public Product getProduct() {
        return product;
    }

    public String addProduct() {
        FacesContext context = FacesContext.getCurrentInstance();
        HttpServletRequest request = (HttpServletRequest) context.getExternalContext().getRequest();
        product.setUsername(request.getRemoteUser());
        if (productService.insertProduct(product)) {
            Message.setMessage("The product could successfully be added");
            return "/view/admin/admin";
        } else {
            Message.setMessage("The product could not be added as a product with the same code already exists");
            return "/view/admin/product/addproduct";
        }
    }
}
