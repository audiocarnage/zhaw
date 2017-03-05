package helpClasses;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;

public class DBAccessClient extends DBAccess {

	public DBAccessClient() throws ServletException {
		super();
	}

	public boolean reserveProduct(String productID, Integer quantity,
			String shopUserID) throws ServletException {
		try {
			boolean result = false;
			Statement stmt = connection.createStatement();
			result = stmt.execute("UPDATE v_product SET amount = (amount - "
					+ quantity + ") WHERE product_id = " + productID);
			return result;
		} catch (SQLException exc) {
			throw new ServletException(exc);
		}
	}

	public boolean undoReserveProduct(String productID, Integer quantity)
			throws ServletException {
		boolean result;
		try {
			Statement stmt = connection.createStatement();
			result = stmt.execute("UPDATE v_product SET amount = (amount + "
					+ quantity + ") WHERE product_id = " + productID);
			return result;
		} catch (SQLException exc) {
			throw new ServletException(exc);
		}

	}

	public boolean purchaseProducts(String shopUserID, String productID,
			Integer quantity, Long timeStamp) throws ServletException {
		boolean result;
		try {
			Statement stmt = connection.createStatement();
			result = stmt
					.execute("INSERT INTO purchase (shopuser_id, product_id, amount, date) "
							+ "VALUES ("
							+ shopUserID
							+ ", "
							+ productID
							+ ", "
							+ quantity + "," + timeStamp + ")");
			return result;
		} catch (SQLException exc) {
			throw new ServletException(exc);
		}
	}

	public ResultSet getAllRatings() throws ServletException {
		try {
			Statement stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT * FROM rating");
			return rs;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public ResultSet getRatingsByProductID(String productID)
			throws ServletException {
		try {
			Statement stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT r.shopuser_id, product_id, mark, commentary, username FROM rating AS r, shopuser AS s WHERE r.shopuser_id= s.shopuser_id AND r.product_id = "
							       + productID);
			return rs;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public boolean addNewRating(String shopUserID, String productID,
			String mark, String commentary) throws ServletException {
		boolean result;
		try {
			Statement stmt = connection.createStatement();
			result = stmt
					.execute("INSERT INTO rating (shopuser_id, product_id, mark, commentary) "
							+ "VALUES ("
							+ shopUserID
							+ ","
							+ productID
							+ ","
							+ mark + ",'" + commentary + "')");
			return result;
		} catch (SQLException exc) {
			throw new ServletException(exc);
		}
	}

	public boolean registerNewUser(String userName, String userPassword)
			throws ServletException {
		int result;
		try {
			Statement stmt = connection.createStatement();
			result = stmt
					.executeUpdate("INSERT INTO shopuser (username, userpassword, authorisation) "
							+ "VALUES ('"
							+ userName
							+ "','"
							+ userPassword
							+ "', 0)");
			return result == 1;
		} catch (SQLException exc) {
			throw new ServletException(exc);
		}
	}
}
