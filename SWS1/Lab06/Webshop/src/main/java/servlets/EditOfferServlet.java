package servlets;

import helpClasses.BadParameterException;
import helpClasses.DBAccessSeller;
import helpClasses.MessageFactory;
import helpClasses.ParamCheck;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EditOfferServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessSeller access;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(true);
		String userID = (String) session.getAttribute("shopUserID");
		access = new DBAccessSeller();

		String action = (String) request.getParameter("action");
		String id = (String) request.getParameter("id");
		String name = (String) request.getParameter("name");
		String price = (String) request.getParameter("price");
		String amount = (String) request.getParameter("amount");
		String description = (String) request.getParameter("description");

		access = new DBAccessSeller();

		if (action.equals("add")) {
			try {
				ParamCheck.checkName(name);
				Double priceDouble = ParamCheck.checkPrice(price);
				Integer amountInt = ParamCheck.checkAmount(amount);
				access.addOffer(userID, name, priceDouble,
						amountInt, description);
				String msg = "New product added";
				MessageFactory.setInfoList(msg, request);
			} catch (BadParameterException e) {
				MessageFactory.setErrorList(e.getMessage(), request);
				getServletContext().getRequestDispatcher(
						response.encodeURL("/ownOffer.action")).forward(
						request, response);
				return;
			}
		} else if (action.equals("edit")) {
			try {
				ParamCheck.checkName(name);
				Double priceDouble = ParamCheck.checkPrice(price);
				Integer amountInt = ParamCheck.checkAmount(amount);
				access.editOffer(id, name, priceDouble,
						amountInt, description);
				String msg = "Changes done";
				MessageFactory.setInfoList(msg, request);
			} catch (BadParameterException e) {
				MessageFactory.setErrorList(e.getMessage(), request);
				getServletContext().getRequestDispatcher(
						response.encodeURL("/ownOffer.action")).forward(
						request, response);
				return;
			}
		}
		if (action.equals("delete")) {
			access.deleteOffer(id);
			String msg = "Product deleted";
			MessageFactory.setInfoList(msg, request);
		}
		getServletContext().getRequestDispatcher(
				response.encodeURL("/home.action")).forward(request, response);
		return;
	}
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
	}

}
