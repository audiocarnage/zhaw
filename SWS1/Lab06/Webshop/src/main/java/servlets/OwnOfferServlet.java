package servlets;

import helpClasses.DBAccessSeller;
import helpClasses.Product;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.ProductsBean;

public class OwnOfferServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessSeller access;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		String userID = (String) session.getAttribute("shopUserID");
		access = new DBAccessSeller();
		ResultSet rs = access.getOwnProducts(userID);

		ArrayList<Product> products = new ArrayList<Product>();
		ProductsBean productsBean = new ProductsBean();
		try {
			while (rs.next()) {
				// die gefundenen Produkte in Bean speichern
				Product product = new Product();
				product.setProductID(rs.getInt(1));
				product.setProductName(rs.getString(2));
				product.setDescription(rs.getString(3));
				product.setPriceUnit(rs.getDouble(4));
				product.setAmount(rs.getInt(5));
				products.add(product);
			}
			productsBean.setProducts(products);
			session.setAttribute("productsBean", productsBean);
		} catch (SQLException e) {
			throw new ServletException("SQL-Exception", e);
		}

		getServletContext().getRequestDispatcher(
				response.encodeURL("/jsp/ownProducts.jsp")).forward(request,
				response);

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}

	/** Wird verwendet um belegte Ressourcen freizugeben */
	public void destroy() {
		try {
			// Freigeben von Datenbank-Ressourcen
			access.closeConnection();
		} catch (ServletException exc) {
			log("SQL-Exception in destroy()", exc);
		}
	}

}
