package helpClasses;

public class Rating {
	
	private int shopUserID, productID, mark;
	private String commentary, userName;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String username) {
		this.userName = username;
	}
	public String getCommentary() {
		return commentary;
	}
	public void setCommentary(String commentary) {
		this.commentary = commentary;
	}
	public int getMark() {
		return mark;
	}
	public void setMark(int mark) {
		this.mark = mark;
	}
	public int getProductID() {
		return productID;
	}
	public void setProductID(int productID) {
		this.productID = productID;
	}
	public int getShopUserID() {
		return shopUserID;
	}
	public void setShopUserID(int shopUserID) {
		this.shopUserID = shopUserID;
	}

}
