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

public class EditClientServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessAdmin access;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String id = (String) request.getParameter("id").trim();
		String action = (String) request.getParameter("action");

		String name = (String) request.getParameter("name");
		String password = (String) request.getParameter("password");

		access = new DBAccessAdmin();
		//Bewertungen von Kunden werden nicht gel�scht
		if (action.equals("delete")) {
			access.deleteClient(id);
			MessageFactory.setInfoList("Customer deleted", request);
		}
		if (action.equals("edit")) {
			try {
				ParamCheck.checkNameAndPassword(name, password);
				access.editClient(id, name, password);
				MessageFactory.setInfoList("Changes completed", request);
			} catch (BadParameterException e) {
				MessageFactory.setErrorList(e.getMessage(), request);
				String url = "/editClient.action?id=" + id + "&action=gotoedit";
				getServletContext().getRequestDispatcher(
						response.encodeURL(url)).forward(request, response);
				return;
			} catch (ServletException exc) {
				if (exc.getCause() instanceof SQLException
						&& ((SQLException) exc.getCause()).getErrorCode() == 1062) {
					String msg = "The user name " + name
					+ " already exists, please pick another name";
					MessageFactory.setErrorList(msg, request);
					String url = "/editClient.action?id=" + id
							+ "&action=gotoedit";
					getServletContext().getRequestDispatcher(
							response.encodeURL(url)).forward(request, response);
					return;
				} else {
					throw exc;
				}
			}
		}
		if (action.equals("activate")) {
			access.activateClient(id);
			MessageFactory.setInfoList("Activation completed", request);
		}
		if (action.equals("deactivate")) {
			access.deactivateClient(id);
			MessageFactory.setInfoList("Deactivation completed", request);
		}
		if (action.equals("gotoedit")) {
			getServletContext().getRequestDispatcher(
					response.encodeURL("/jsp/edit_client.jsp")).forward(
					request, response);
			return;
		}
		getServletContext().getRequestDispatcher(
				response.encodeURL("/clientList.action")).forward(request,
				response);
		return;
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

}
