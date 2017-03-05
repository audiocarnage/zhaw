package helpClasses;

public class Product {

	private int productID, amount;
	private String productName, description;
	private double priceUnit;
	
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public double getPriceUnit() {
		return priceUnit;
	}
	public void setPriceUnit(double priceUnit) {
		this.priceUnit = priceUnit;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductID() {
		return productID;
	}
	public void setProductID(int productID) {
		this.productID = productID;
	}
}
