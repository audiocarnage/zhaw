package servlets;

import helpClasses.BadParameterException;
import helpClasses.DBAccessAdmin;
import helpClasses.MessageFactory;
import helpClasses.ParamCheck;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EditSellerServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessAdmin access;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String id = (String) request.getParameter("id").trim();
		String action = (String) request.getParameter("action");

		String name = (String) request.getParameter("name");
		String password = (String) request.getParameter("password");

		access = new DBAccessAdmin();


		// Offers from the seller are not deleted
		if (action.equals("delete")) {
			access.deleteSeller(id);
			MessageFactory.setInfoList("Seller deleted", request);
		}
		if (action.equals("edit")) {
			try {
				ParamCheck.checkNameAndPassword(name, password);
				access.editSeller(id, name, password);
				MessageFactory.setInfoList("Changes stored to database", request);
			} catch (BadParameterException e) {
				MessageFactory.setErrorList(e.getMessage(), request);
				String url = "/editSeller.action?id=" + id + "&action=gotoedit";
				getServletContext().getRequestDispatcher(
						response.encodeURL(url)).forward(request, response);
				return;
			} catch (ServletException exc) {
				if (exc.getCause() instanceof SQLException
						&& ((SQLException) exc.getCause()).getErrorCode() == 1062) {
					String msg = "The user name " + name
					+ " already exists, please pick another name";
					MessageFactory.setErrorList(msg, request);
					String url = "/editSeller.action?id=" + id
							+ "&action=gotoedit";
					getServletContext().getRequestDispatcher(
							response.encodeURL(url)).forward(request, response);
					return;
				} else {
					throw exc;
				}
			}
		}

		if (action.equals("add")) {
			try {
				ParamCheck.checkNameAndPassword(name, password);
				access.addSeller(name, password);
				MessageFactory.setInfoList("Added new seller", request);
			} catch (BadParameterException e) {
				MessageFactory.setErrorList(e.getMessage(), request);
				String url = "/editSeller.action?action=gotoadd";
				getServletContext().getRequestDispatcher(
						response.encodeURL(url)).forward(request, response);
				return;
			} catch (ServletException exc) {
				if (exc.getCause() instanceof SQLException
						&& ((SQLException) exc.getCause()).getErrorCode() == 1062) {
					String msg = "The user name " + name
					+ " already exists, please pick another name";
					MessageFactory.setErrorList(msg, request);
					String url = "/editSeller.action?action=gotoadd";
					getServletContext().getRequestDispatcher(
							response.encodeURL(url)).forward(request, response);
					return;
				} else {
					throw exc;
				}
			}
		}
		if (action.equals("gotoedit")) {
			getServletContext().getRequestDispatcher(
					response.encodeURL("/jsp/edit_seller.jsp")).forward(
					request, response);
			return;
		}

		if (action.equals("gotoadd")) {
			getServletContext().getRequestDispatcher(
					response.encodeURL("/jsp/edit_seller.jsp")).forward(
					request, response);
			return;
		}
		getServletContext().getRequestDispatcher(
				response.encodeURL("/sellerList.action")).forward(request,
				response);
		return;

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
