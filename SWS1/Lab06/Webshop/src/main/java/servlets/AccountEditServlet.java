package servlets;

import helpClasses.BadParameterException;

import helpClasses.Client;
import helpClasses.DBAccessAdmin;
import helpClasses.MessageFactory;
import helpClasses.ParamCheck;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.ClientBean;

public class AccountEditServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessAdmin access;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(true);
		String id = (String) session.getAttribute("shopUserID");

		String action = request.getParameter("action");
		String name = request.getParameter("name");
		String password = request.getParameter("password");

		ArrayList<String> errorList = new ArrayList<String>();

		access = new DBAccessAdmin();
		if (action.equals("edit")) {
			try {
				ParamCheck.checkNameAndPassword(name, password);
				access.editClient(id, name, password);
				request.getSession().setAttribute("userName", name);
				String msg = "changes done";
				MessageFactory.setInfoList(msg, request);
			} catch (BadParameterException paramExc) {
				MessageFactory.setErrorList(paramExc.getMessage(), request);
				String url = "/accountEdit.action?action=gotoedit";
				getServletContext().getRequestDispatcher(
						response.encodeURL(url)).forward(request, response);
				return;
			} catch (ServletException exc) {
				if (exc.getCause() instanceof SQLException
						&& ((SQLException) exc.getCause()).getErrorCode() == 1062) {
					String msg = name
							+ " already exists. Please choose another name";
					MessageFactory.setErrorList(msg, request);
					String url = "/accountEdit.action?action=gotoedit";
					getServletContext().getRequestDispatcher(
							response.encodeURL(url)).forward(request, response);
					return;
				} else {
					throw exc;
				}
			}
		}
		if (action.equals("gotoedit")) {
			ArrayList<Client> clients = new ArrayList<Client>();
			ResultSet rs = access.getClient(id);
			ClientBean clientBean = new ClientBean();
			try {
				while (rs.next()) {

					Client client = new Client();
					client.setClientID(rs.getInt(1));
					client.setClientName(rs.getString(2));
					client.setClientPassword(rs.getString(3));
					client.setAuthorisation(rs.getInt(4));
					clients.add(client);

				}
				clientBean.setClients(clients);
				session.setAttribute("clientBean", clientBean);
			} catch (SQLException e) {
				access.closeConnection();
				errorList.add("Error when accessing the customer data.");
				request.setAttribute("errorList", errorList);
				getServletContext().getRequestDispatcher(
						response.encodeURL("/home.action")).forward(request,
						response);
				return;
			}

			getServletContext().getRequestDispatcher(
					response.encodeURL("/jsp/profil.jsp?action=gotoedit&id="
							+ id)).forward(request, response);
			return;

		}

		getServletContext().getRequestDispatcher(
				response.encodeURL("/home.action")).forward(request, response);
		return;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);

	}
	
	/** Wird verwendet um belegte Ressourcen freizugeben */
	@Override
	public void destroy() {
		try {
			// Freigeben von Datenbank-Ressourcen
			access.closeConnection();
		} catch (ServletException exc) {
			log("SQL-Exception in destroy()", exc);
		}
	}

}
