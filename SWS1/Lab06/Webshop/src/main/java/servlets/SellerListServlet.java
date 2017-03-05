package servlets;

import helpClasses.DBAccessAdmin;
import helpClasses.Seller;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.SellerBean;

public class SellerListServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DBAccessAdmin access;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		
		HttpSession session = request.getSession(true);
		ArrayList<String> errorList = new ArrayList<String>();
		
		access = new DBAccessAdmin();
		ResultSet rs = access.getAllSellers();
		ArrayList<Seller> sellers = new ArrayList<Seller>();
		SellerBean sellerBean = new SellerBean();
		try {
			while (rs.next()) {
				// die einzelnen Produkte in Bean speichern
				Seller seller = new Seller();
				seller.setSellerID(rs.getInt(1));
				seller.setSellerName(rs.getString(2));
				seller.setSellerPassword(rs.getString(3));
				sellers.add(seller);
			}
			sellerBean.setSellers(sellers);
			session.setAttribute("sellerBean", sellerBean);
		} catch (SQLException e) {
			access.closeConnection();
			errorList = new ArrayList<String>();
			errorList.add("SQL FEHLER in SellerListServlet");
			request.setAttribute("errorList", errorList);
			getServletContext().getRequestDispatcher(
					response.encodeURL("/sellerList.action")).forward(request,response);
			return;
		} finally {
			access.closeConnection();
		}

		getServletContext().getRequestDispatcher(
				response.encodeURL("/jsp/admin_seller_view.jsp")).forward(request, response);

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}

}
