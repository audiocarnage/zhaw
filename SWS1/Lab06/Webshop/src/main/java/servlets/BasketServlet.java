package servlets;

import helpClasses.BadParameterException;
import helpClasses.DBAccessClient;
import helpClasses.MessageFactory;
import helpClasses.ParamCheck;
import helpClasses.Product;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.BasketBean;

public class BasketServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessClient access;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		if (request.getParameter("addToBasket.x") != null) {
			addToBasket(request, response);
		} else if (request.getParameter("showBasket") != null) {
			showBasket(request, response);
		} else if (request.getParameter("deleteFromBasket") != null) {
			deleteFromBasket(request, response);
		} else if (request.getParameter("purchaseProducts") != null) {
			purchaseProducts(request, response);
		}
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}

	private void purchaseProducts(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		HashMap<String, Product> reservedProducts = getReservedProducts(request);
		String shopUserID = (String) request.getSession().getAttribute(
				"shopUserID");
		if (reservedProducts != null) {
			access = new DBAccessClient();
			long timeStamp = System.currentTimeMillis()/1000;
			// jeden Eintrag im Warenkorb in die Tabelle purchase eintragen
			for (Map.Entry<String, Product> entry : reservedProducts.entrySet()) {
				Product product = entry.getValue();
				access.purchaseProducts(shopUserID, entry.getKey(), product
						.getAmount(), timeStamp);
			}
		}
		// wenn alles bestellt, Warenkorb loeschen
		request.getSession().removeAttribute("basketBean");
		String msg = "Thank you for your order";
		MessageFactory.setInfoList(msg, request);
		getServletContext().getRequestDispatcher(
				response.encodeURL("/home.action")).forward(request, response);
	}

	private void deleteFromBasket(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		String productID = request.getParameter("productID");
		HashMap<String, Product> reservedProducts = getReservedProducts(request);
		Product product;
		// gelingt das Entfernen aus der Liste?
		if ((product = reservedProducts.remove(productID)) != null) {
			access = new DBAccessClient();
			// auch entfernte Anzahl wieder in der Tabelle product korrigieren
			access.undoReserveProduct(productID, product.getAmount());
		}
		if (reservedProducts.isEmpty()) {
			request.getSession().removeAttribute("basketBean");
		}
		getServletContext().getRequestDispatcher(
				response.encodeURL("/basket.action?showBasket=true")).forward(
				request, response);

	}

	private synchronized void addToBasket(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		access = new DBAccessClient();
		String productID = request.getParameter("productID");
		String shopUserID = (String) request.getSession().getAttribute(
				"shopUserID");
		// Produkt reservieren. Nicht OK wenn Stueckzahl nicht vorhanden
		try {
			Integer quantity = ParamCheck.checkAmount(request
					.getParameter("quantity"));
			access.reserveProduct(productID, quantity, shopUserID);
			HashMap<String, Product> reservedProducts = getReservedProducts(request);
			if (reservedProducts == null) {
				reservedProducts = new HashMap<String, Product>();
				// BasketBean mit den reservedProducts in Session-Kontext
				// einf�gen
				setReservedProducts(request, reservedProducts);
			}
			// falls von diesem Produkt bereits eine Anzahl im Warenkorb ist
			if (reservedProducts.containsKey(productID)) {
				// Alte Anzahl holen
				int oldQuantity = reservedProducts.get(productID).getAmount();
				// Anzahl neu setzen
				reservedProducts.get(productID).setAmount(
						quantity + oldQuantity);
			} else {
				// es ist ein neues Product, das hinzugef�gt werden muss
				ResultSet rs = access.getProductDetails(productID);
				rs.next();
				// die einzelnen Werte einf�gen
				Product product = new Product();
				product.setProductID(rs.getInt(1));
				product.setProductName(rs.getString(2));
				product.setDescription(rs.getString(3));
				product.setPriceUnit(rs.getDouble(4));
				product.setAmount(quantity);
				reservedProducts.put(productID, product);
			}
			// Product could be added to cart
			String msg = "Product added to shopping cart";
			MessageFactory.setInfoList(msg, request);
		} catch (ServletException exc) {
			if (exc.getCause() instanceof SQLException
					&& ((SQLException) exc.getCause()).getErrorCode() == 1369) {
				String msg = "Desired amount not available";
				MessageFactory.setErrorList(msg, request);
			} else {
				throw exc;
			}
		} catch (SQLException e) {
			throw new ServletException("SQL-Exception", e);
		} catch (BadParameterException e) {
			MessageFactory.setErrorList(e.getMessage(), request);
		} finally {
			access.closeConnection();
		}
		getServletContext().getRequestDispatcher(
				response.encodeURL("/home.action")).forward(request, response);
	}

	private void showBasket(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		HashMap<String, Product> reservedProducts = getReservedProducts(request);
		if (reservedProducts == null || reservedProducts.isEmpty()) {
			String msg = "Your shopping cart is empty";
			MessageFactory.setInfoList(msg, request);
		}
		getServletContext().getRequestDispatcher(
				response.encodeURL("/jsp/basket.jsp")).forward(request,
				response);
	}

	private HashMap<String, Product> getReservedProducts(
			HttpServletRequest request) {
		BasketBean basketBean = (BasketBean) request.getSession().getAttribute(
				"basketBean");
		return basketBean == null ? null : basketBean.getReservedProducts();
	}

	private void setReservedProducts(HttpServletRequest request,
			HashMap<String, Product> reservedProducts) {
		BasketBean basketBean = new BasketBean();
		basketBean.setReservedProducts(reservedProducts);
		request.getSession().setAttribute("basketBean", basketBean);
	}
}
