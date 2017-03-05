package helpClasses;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;

public class DBAccessSeller extends DBAccess {

	public DBAccessSeller() throws ServletException {
		super();
	}

	public ResultSet getOwnProducts(String userID) throws ServletException {
		try {
			Statement stmt = connection.createStatement();
			rs = stmt
					.executeQuery("SELECT  offer.product_id, productname, description, price_unit, amount FROM product "
							+ "INNER JOIN offer ON "
							+ "(offer.product_id= product.product_id) "
							+ "WHERE shopuser_id= " + userID);
			return rs;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public Boolean addOffer(String userID, String name, Double price,
			Integer amount, String description) throws ServletException {
		try {
			// Transaktion
			connection.setAutoCommit(false);
			Statement stmt = connection.createStatement();
			stmt
					.execute(
							"INSERT INTO `product` "
									+ "(`product_id`, `productname`, `description`, `price_unit`, `amount`)"
									+ " VALUES (NULL, '" + name + "', '"
									+ description + "', " + price + ", "
									+ amount + ");", stmt.RETURN_GENERATED_KEYS);

			ResultSet generatedKeys = stmt.getGeneratedKeys();
			int lastId = -1;
			if (generatedKeys.next()) {
				System.out.println(generatedKeys.getInt(1));
				lastId = generatedKeys.getInt(1);
			}
			stmt.execute("INSERT INTO `offer` "
					+ "(product_id, shopuser_id, date) " + "VALUES ('" + lastId
					+ "', '" + userID + "', UNIX_TIMESTAMP() )");
			connection.commit();
		} catch (SQLException e1) {
			try {
				connection.rollback();
				throw e1;
			} catch (SQLException e2) {
				throw new ServletException("SQL-Exception", e2);
			}
		} finally {
			try {
				connection.setAutoCommit(true);
			} catch (SQLException e) {
				throw new ServletException("SQL-Exception", e);
			}
		}
		return true;
	}

	public Boolean editOffer(String id, String name, Double price,
			Integer amount, String description) throws ServletException {
		try {

			// Ausführen eines SQL-Statements via JDBC
			Statement stmt = connection.createStatement();
			Boolean res = stmt
					.execute("UPDATE `webshop`.`product` SET `productname` = '"
							+ name + "',`description` = '" + description
							+ "',`price_unit` = '" + price + "',`amount` = '"
							+ amount + "' WHERE `product`.`product_id` =" + id
							+ " LIMIT 1 ;");
			return res;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public Boolean deleteOffer(String id) throws ServletException {
		try {
			// Ausführen eines SQL-Statements via JDBC
			// Transaktion
			connection.setAutoCommit(false);
			Statement stmt = connection.createStatement();
			stmt.execute("delete from offer where product_id=" + id);
			stmt.execute("delete from product where product_id=" + id);
			connection.commit();
		} catch (SQLException e1) {
			try {
				connection.rollback();
				throw e1;
			} catch (SQLException e2) {
				throw new ServletException("SQL-Exception", e2);
			}
		} finally {
			try {
				connection.setAutoCommit(true);
			} catch (SQLException e) {
				throw new ServletException("SQL-Exception", e);
			}
		}
		return true;
	}
}
