package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/** Dieses Servlet erzeugt dynamischen Inhalt aus Datenbank-Daten */
public class LogoutServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/** Service-Methode zur Verarbeitung von Post-Requests */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.invalidate();

		getServletContext().getRequestDispatcher(
				response.encodeURL("/home.action")).forward(request, response);

	}

	/** Bearbeiten von GET-Requests analog zu POST */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// Weiterleiten des Requests an die Methode doGet()
		doPost(request, response);
	}

}