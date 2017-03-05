package helpClasses;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;

public class DBAccessAdmin extends DBAccess {

	public DBAccessAdmin() throws ServletException {
		super();
	}
	
	public ResultSet getAllClients() throws ServletException {
		try {
			// Ausführen eines SQL-Statements via JDBC
			Statement stmt = connection.createStatement();
			rs = stmt
					.executeQuery("select * from shopuser where authorisation ='1' or authorisation ='0'");
			return rs;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public ResultSet getClient(String id) throws ServletException {
		try {
			// Ausführen eines SQL-Statements via JDBC
			Statement stmt = connection.createStatement();
			rs = stmt
					.executeQuery("select * from shopuser where authorisation ='1' or authorisation ='0' and shopuser_id="
							+ id);
			return rs;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}
	
	public ResultSet getAllSellers() throws ServletException {
		try {
			// Ausführen eines SQL-Statements via JDBC
			Statement stmt = connection.createStatement();
			rs = stmt
					.executeQuery("select * from shopuser where authorisation ='2'");
			return rs;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	//Es wird nur der Verkäufer gelöscht, Produkte und Angebote bleiben bestehen
	public Boolean deleteSeller(String id) throws ServletException {
		try {
			// Ausführen eines SQL-Statements via JDBC
			Statement stmt = connection.createStatement();

			Boolean res = stmt
					.execute("delete from shopuser where shopuser_id=" + id);
			return res;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public Boolean addSeller(String name, String password)
			throws ServletException {
		try {
			// Ausführen eines SQL-Statements via JDBC
			Statement stmt = connection.createStatement();
			Boolean res = stmt
					.execute("INSERT INTO `shopuser` "
							+ "(`shopuser_id`, `username`, `userpassword`, `authorisation`) "
							+ "VALUES (NULL, '" + name + "', '" + password
							+ "', 2)");
			return res;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	//Es wird nur der Client gel�scht, Kommentare, Bewertungen von diesem Client bleiben bestehen
	public Boolean deleteClient(String id) throws ServletException {
		try {
			// Ausf�hren eines SQL-Statements via JDBC
			Statement stmt = connection.createStatement();

			Boolean res = stmt
					.execute("delete from shopuser where shopuser_id=" + id);
			return res;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public Boolean editSeller(String id, String name, String password)
			throws ServletException {
		try {
			// Ausf�hren eines SQL-Statements via JDBC
			Statement stmt = connection.createStatement();

			Boolean res = stmt.execute("UPDATE `shopuser` SET `username` = '"
					+ name + "',`userpassword` = '" + password
					+ "' WHERE `shopuser_id` =" + id);
			return res;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public Boolean editClient(String id, String name, String password)
			throws ServletException {
		try {
			// Ausf�hren eines SQL-Statements via JDBC
			Statement stmt = connection.createStatement();

			Boolean res = stmt.execute("UPDATE `shopuser` SET `username` = '"
					+ name + "',`userpassword` = '" + password
					+ "' WHERE `shopuser_id` =" + id);
			return res;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public Boolean activateClient(String id) throws ServletException {
		try {
			// Ausf�hren eines SQL-Statements via JDBC
			Statement stmt = connection.createStatement();

			Boolean res = stmt
					.execute("UPDATE `shopuser` SET `authorisation` = '1'"
							+ "WHERE `shopuser_id` =" + id);
			return res;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

	public Boolean deactivateClient(String id) throws ServletException {
		try {
			// Ausf�hren eines SQL-Statements via JDBC
			Statement stmt = connection.createStatement();
			Boolean res = stmt
					.execute("UPDATE `shopuser` SET `authorisation` = '0'"
							+ "WHERE `shopuser_id` =" + id);
			return res;
		} catch (SQLException exc) {
			throw new ServletException("SQL-Exception", exc);
		}
	}

}
