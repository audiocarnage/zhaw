package servlets;

import helpClasses.DBAccessClient;
import helpClasses.MessageFactory;
import helpClasses.Rating;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.RatingBean;

public class ProductRatingServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessClient access;

	/** Service method to process post requests */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String productID = request.getParameter("productID");
		access = new DBAccessClient();

		if (request.getParameter("addNewRating") != null && request.getParameter("getAllRatings") == null) {
			String commentary = request.getParameter("commentary");
			String mark = request.getParameter("mark");
			String shopUserID = (String) request.getSession().getAttribute(
					"shopUserID");
			access.addNewRating(shopUserID, productID, mark, commentary);
			MessageFactory.setInfoList("Thank you for your rating", request);
			getServletContext().getRequestDispatcher(
					response.encodeURL("/home.action?getAllRatings=true")).forward(request,
					response);
		}
		if (productID != null && request.getParameter("getRating") != null) {
			
			// Get ratings for a single product and store them in the bean
			ResultSet rs = access.getRatingsByProductID(productID);
			RatingBean ratingBean = new RatingBean();
			ArrayList<Rating> ratingList = new ArrayList<Rating>();
			try {
				while (rs.next()) {
					
					// Store ratings in a bean
					Rating rating = new Rating();
					rating.setShopUserID(rs.getInt(1));
					rating.setProductID(rs.getInt(2));
					rating.setMark(rs.getInt(3));
					rating.setCommentary(rs.getString(4));
					rating.setUserName(rs.getString(5));
					ratingList.add(rating);
				}
				ratingBean.setRatingList(ratingList);
				request.getSession().setAttribute("ratingBean", ratingBean);
			} catch (SQLException e) {
				throw new ServletException("SQL-Exception", e);
			}
		}
		if (request.getParameter("getAllRatings") != null) {
			
			// Get ratings for all products and store them in the bean
			ResultSet rs = access.getAllRatings();
			ArrayList<Rating> allRatings = new ArrayList<Rating>();
			RatingBean ratingBean = new RatingBean();
			try {
				while (rs.next()) {
					Rating rating = new Rating();
					rating.setShopUserID(rs.getInt(1));
					rating.setProductID(rs.getInt(2));
					rating.setMark(rs.getInt(3));
					rating.setCommentary(rs.getString(4));
					allRatings.add(rating);
				}
				ratingBean.setAllRatings(allRatings);
				HttpSession session = request.getSession(true);
				session.setAttribute("ratingBean", ratingBean);
			} catch (SQLException e) {
				throw new ServletException("SQL-Exception", e);
			}
		}
	}

	/** Process GET requests in the same way as post requests */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doPost(request, response);
	}

	/** Release DB ressources */
	public void destroy() {
		try {
			access.closeConnection();
		} catch (ServletException exc) {
			log("SQL-Exception in destroy()", exc);
		}
	}
}