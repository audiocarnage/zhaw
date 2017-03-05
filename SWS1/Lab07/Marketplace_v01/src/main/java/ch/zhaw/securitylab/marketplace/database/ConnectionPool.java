package ch.zhaw.securitylab.marketplace.database;

import javax.sql.DataSource;
import java.sql.Connection;
import javax.naming.InitialContext;

public class ConnectionPool {

    private static DataSource dataSource = null;

    static {
        try {
            dataSource = (DataSource) new InitialContext().lookup("jdbc/marketplace");
        } catch (Exception e) {
            // Do nothing
        }
    }

    public static Connection getConnection() {
        try {
            return dataSource.getConnection();
        } catch (Exception e) {
            return null;
        }
    }

    public static void freeConnection(Connection c) {
        try {
            c.close();
        } catch (Exception e) {
            // Do nothing
        }
    }
}
