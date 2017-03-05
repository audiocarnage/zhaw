package helpClasses;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;

public abstract class DBAccess {

	protected Connection connection;

	protected ResultSet rs;

	public DBAccess() throws ServletException {
		init();
	}

	private void init() throws ServletException {
		try {
			String driver = "com.mysql.jdbc.Driver";
			String dbURL = "jdbc:mysql://localhost/webshop";
			String dbUser = "webshop_user";
			String dbPass = "changeit";

			// Load database driver via ClassLoader
			Class.forName(driver);

			// Connect to DB
			connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

		} catch (Exception exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public ResultSet getAllProducts() throws ServletException {
		try {
			Statement stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT * FROM product");
			return rs;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public ResultSet getUserByName(String userName) throws ServletException {
		try {
			Statement stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT userpassword, shopuser_id, authorisation FROM shopuser WHERE username = '"
					+ userName + "'");
			return rs;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public ResultSet searchProducts(String searchTerm) throws ServletException {
		try {
			Statement stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT * FROM product WHERE productname LIKE '%"
					+ searchTerm + "%'");
			return rs;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public ResultSet getProductDetails(String productID) throws ServletException {
		try {
			Statement stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT * FROM product WHERE product_id = "
					+ productID);
			return rs;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public void closeConnection() throws ServletException {
		try {
			if (rs != null) {
				rs.close();
			}
			if (connection != null) {
				connection.close();
			}
		} catch (Exception e) {
			throw new ServletException("SQL-Exception", e);
		}
	}
}
