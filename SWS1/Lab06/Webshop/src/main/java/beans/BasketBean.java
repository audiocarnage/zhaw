package beans;

import helpClasses.Product;

import java.util.HashMap;

public class BasketBean {

	private HashMap<String, Product> reservedProducts;

	public HashMap<String, Product> getReservedProducts() {
		return reservedProducts;
	}
	
	public void setReservedProducts(HashMap<String, Product> reservedProducts) {
		this.reservedProducts = reservedProducts;
	}
}
