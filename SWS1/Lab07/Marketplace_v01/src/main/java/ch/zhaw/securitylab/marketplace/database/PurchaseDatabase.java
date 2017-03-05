package ch.zhaw.securitylab.marketplace.database;

import ch.zhaw.securitylab.marketplace.model.Purchase;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.*;
import javax.enterprise.context.RequestScoped;

@RequestScoped
public class PurchaseDatabase {

    public int insert(Purchase purchase) {
        Connection connection = ConnectionPool.getConnection();

        String query
                = "INSERT INTO Purchase (Firstname, Lastname, CreditCardNumber, TotalPrice) "
                + "VALUES ('" + purchase.getFirstname() + "', '" + purchase.getLastname() + "', '"
                + purchase.getCreditCardNumber() + "', " + purchase.getTotalPrice() + ")";
        try (Statement statement = connection.createStatement()) {
            return statement.executeUpdate(query);
        } catch (SQLException e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            throw new RuntimeException("Offending SQL query: " + query + "\n" + sw.toString());
        } finally {
            ConnectionPool.freeConnection(connection);
        }
    }
}
