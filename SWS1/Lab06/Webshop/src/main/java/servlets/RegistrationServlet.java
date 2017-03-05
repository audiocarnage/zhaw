package servlets;

import helpClasses.BadParameterException;
import helpClasses.DBAccessClient;
import helpClasses.MessageFactory;
import helpClasses.ParamCheck;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegistrationServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessClient access;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		if (request.getParameter("showRegisterForm") != null) {
			getServletContext().getRequestDispatcher(
					response.encodeURL("/jsp/registration.jsp")).forward(
					request, response);
		} else if (request.getParameter("registerNewUser") != null) {
			access = new DBAccessClient();
			String userName = request.getParameter("userName");
			String userPassword = request.getParameter("userPassword");
			try {
				ParamCheck.checkNameAndPassword(userName, userPassword);
				access.registerNewUser(userName, userPassword);
				
				// Registration was successful
				MessageFactory.setInfoList(
						"Thank you for registering at our shop", request);
				getServletContext().getRequestDispatcher(
						response.encodeURL("/home.action")).forward(request,
						response);
			} catch (BadParameterException paramExc) {
				MessageFactory.setErrorList(paramExc.getMessage(), request);
				String url = "/registration.action?showRegisterForm=true";
				getServletContext().getRequestDispatcher(
						response.encodeURL(url)).forward(request, response);
			} catch (ServletException exc) {
				if (exc.getCause() instanceof SQLException
						&& ((SQLException) exc.getCause()).getErrorCode() == 1062) {
					String msg = "The user name " + userName
							+ " already exists, please pick another name";
					MessageFactory.setErrorList(msg, request);
					String url = "/registration.action?showRegisterForm=true";
					getServletContext().getRequestDispatcher(
							response.encodeURL(url)).forward(request, response);
				} else {
					throw exc;
				}
			}
		}

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
