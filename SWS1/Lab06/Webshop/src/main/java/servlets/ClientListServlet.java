package servlets;

import helpClasses.Client;
import helpClasses.DBAccessAdmin;

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

public class ClientListServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessAdmin access;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		access = new DBAccessAdmin();
		ArrayList<String> errorList = new ArrayList<String>();
		HttpSession session = request.getSession(true);
		
		ResultSet rs = access.getAllClients();
		ArrayList<Client> clients = new ArrayList<Client>();
		ClientBean clientBean = new ClientBean();
		try {
			while (rs.next()) {
				//System.out.println(rs.getString(1));
				// die einzelnen Produkte in Bean speichern
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
			errorList.add("Customer list could not be geberated.");
			request.setAttribute("errorList", errorList);
			access.closeConnection();
		} finally {
			access.closeConnection();
		}
		getServletContext().getRequestDispatcher(
				response.encodeURL("/jsp/admin_client_view.jsp")).forward(request, response);

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}

}
