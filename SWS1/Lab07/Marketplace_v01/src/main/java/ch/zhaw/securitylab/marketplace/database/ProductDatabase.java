package ch.zhaw.securitylab.marketplace.database;

import ch.zhaw.securitylab.marketplace.model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.enterprise.context.RequestScoped;

@RequestScoped
public class ProductDatabase {

    public List<Product> searchProducts(String searchString) {
        Connection connection = ConnectionPool.getConnection();
        List<Product> products = new ArrayList<>();

        String query = "SELECT * FROM Product WHERE Description LIKE '%" + searchString + "%'";
        try (Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery(query);) {
            Product product;
            while (rs.next()) {
                product = new Product();
                product.setCode(rs.getString("Code"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                products.add(product);
            }
        } catch (SQLException e) {
            // Returns an empty list
        } finally {
            ConnectionPool.freeConnection(connection);
        }
        return products;
    }
}
