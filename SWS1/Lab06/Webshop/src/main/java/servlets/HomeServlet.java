package servlets;

import helpClasses.DBAccessClient;
import helpClasses.Product;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.ProductsBean;

public class HomeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessClient access;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		
		// Read all products from DB and store them in the products bean
		access = new DBAccessClient();
		ResultSet rs = access.getAllProducts();
		ArrayList<Product> products = new ArrayList<Product>();
		ProductsBean productsBean = new ProductsBean();
		try {
			while (rs.next()) {	
				Product product = new Product();
				product.setProductID(rs.getInt(1));
				product.setProductName(rs.getString(2));
				product.setDescription(rs.getString(3));
				product.setPriceUnit(rs.getDouble(4));
				product.setAmount(rs.getInt(5));
				products.add(product);
			}
			productsBean.setProducts(products);
			HttpSession session = request.getSession(true);
			
			// Store the products bean in the session
			session.setAttribute("productsBean", productsBean);
		} catch (SQLException e) {
			throw new ServletException("SQL-Exception", e);
		} finally {
			access.closeConnection();
		}
		
		// Include all ratings to the session
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(
				"/productRating.action?getAllRatings=true");
		dispatcher.include(request, response);

		// Forward the request to the JSP
		dispatcher = getServletContext().getRequestDispatcher("/jsp/main.jsp");
		dispatcher.forward(request, response);

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}
}
