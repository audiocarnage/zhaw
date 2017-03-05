package servlets;

import helpClasses.DBAccessClient;
import helpClasses.Product;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProductDetailsServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessClient access;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		
		// Read product details from DB
		access = new DBAccessClient();
		String productID = request.getParameter("productID");
		ResultSet rs = access.getProductDetails(productID);
		Product product = new Product();
		try {
			while (rs.next()) {	
				product.setProductID(rs.getInt(1));
				product.setProductName(rs.getString(2));
				product.setDescription(rs.getString(3));
				product.setPriceUnit(rs.getDouble(4));
				product.setAmount(rs.getInt(5));
			}
			HttpSession session = request.getSession(true);
			
			// Add product bean to session
			session.setAttribute("productBean", product);
		} catch (SQLException e) {
			throw new ServletException("SQL-Exception", e);
		} finally {
			access.closeConnection();
		}
		
		// Include ratings of this product to the session
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(
				"/productRating.action?productID=" + productID + "&getRating=true");
		dispatcher.include(request, response);
		
		// Forward the request to the JSP
		dispatcher = getServletContext().getRequestDispatcher(
				"/jsp/product_details.jsp");
		dispatcher.forward(request, response);
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}

}
