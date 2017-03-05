package servlets;

import helpClasses.DBAccessClient;
import helpClasses.MessageFactory;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/** Dieses Servlet erzeugt dynamischen Inhalt aus Datenbank-Daten */
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessClient access;

	/** Service-Methode zur Verarbeitung von Post-Requests */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		try {
			String userName = request.getParameter("name");
			String userPassword = request.getParameter("password");
			
			HttpSession session = request.getSession(true);
			
			// Session is destroyed after 10 minutes of inactivity
			session.setMaxInactiveInterval(600);
			access = new DBAccessClient();

			ResultSet rs = access.getUserByName(userName);

			if (rs.next() && rs.getString(1).equals(userPassword)) {
				session.setAttribute("userName", userName);
				session.setAttribute("shopUserID", rs.getString(2));
				String authorisation = rs.getString(3);
				session.setAttribute("authorisation", authorisation);
				if (authorisation.equals("3")) {
					getServletContext().getRequestDispatcher(
							response.encodeURL("/clientList.action")).forward(
							request, response);
				} else if (authorisation.equals("2")) {
					getServletContext().getRequestDispatcher(
							response.encodeURL("/home.action")).forward(
							request, response);
				} else if (authorisation.equals("1")) {
					getServletContext().getRequestDispatcher(
							response.encodeURL("/home.action")).forward(
							request, response);

				} else if (authorisation.equals("0")) {
					// als Kunde angemeldet, aber den Status 1 noch nicht
					// erhalten, somit noch kein Einloggen erlaubt
					session.removeAttribute("userName");
					String error = "Your account hasn't been activated yet - please be patient";
					MessageFactory.setErrorList(error, request);
					getServletContext().getRequestDispatcher(
							response.encodeURL("/home.action")).forward(
							request, response);
				}
			} else {
				String error = "Login failed, user name or password incorrect";
				MessageFactory.setErrorList(error, request);
				getServletContext().getRequestDispatcher(
						response.encodeURL("/home.action")).forward(request,
						response);
			}
		} catch (SQLException e) {
			throw new ServletException("SQL-Exception", e);
		}
	}

	/** Bearbeiten von GET-Requests analog zu POST */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// Weiterleiten des Requests an die Methode doGet()
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