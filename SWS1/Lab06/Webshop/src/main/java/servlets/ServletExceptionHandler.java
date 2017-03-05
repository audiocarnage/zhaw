package servlets;

import helpClasses.MessageFactory;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ServletExceptionHandler extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/** Service-Methode zur Verarbeitung von Post-Requests */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		Throwable throwable = (Throwable) request
				.getAttribute("javax.servlet.error.exception");
		String servletName = (String) request
				.getAttribute("javax.servlet.error.servlet_name");
		String requestUri = (String) request
				.getAttribute("javax.servlet.error.request_uri");

		String authorisation = (String) request.getSession().getAttribute(
				"authorisation");

		if (authorisation.equals("3")) {
			ArrayList<String> errorList = MessageFactory.setErrorList(
					"The servlet name associated with throwing the exception: "
							+ servletName, request);
			errorList.add("The type of exception: "
					+ throwable.getClass().getName());
			errorList.add("The request URI: " + requestUri);
			errorList.add("The type of exception: "
					+ throwable.getClass().getName());

		} else {
			String msg = "An error occured. Please inform the administrator";
			MessageFactory.setErrorList(msg, request);
		}
		getServletContext().getRequestDispatcher("/home.action").forward(
				request, response);
	}

	/** Bearbeiten von GET-Requests analog zu POST */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doPost(request, response);
	}
}
