<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="sellerBean"	class="beans.SellerBean"	scope="session" />

<%@ page import= "helpClasses.*"%>
<%@ page import= "java.util.*" %>


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de" lang="de">

<head>
<title>TopShop</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>

<body>

<div id="container">
	<!-- Header -->
		<%@ include file="header.jsp" %>
	<!--End Header-->
	<!-- Wrapper -->

	<div id="wrapper">
		<div id="content">
			<p id="titel1">List of all sellers</p>
			<table id="list1">	
			<tr>
				<th>Name</th>
				<th>ID</th>
				<th>Edit</th>
				<th>Delete</th>
			</tr>
			<c:forEach var="seller" items="${sellerBean.sellers}">
			<tr>
				<td>
					<c:out value="${seller.sellerName}"/> 
				</td>
				<td>
					<c:out value="${seller.sellerID}"/>
				</td>
				<td>
					<a href="editSeller.action?id=${seller.sellerID}&action=gotoedit"><img src="images/b_edit.png"/></a>
				</td>
				<td>
					<a href="editSeller.action?id=${seller.sellerID}&action=delete"
						onClick="if(!confirm(&quot;${seller.sellerName} Confirm delete?&quot;)) return false;">
							<img src="images/b_drop.png"/>
					</a>
				</td>
			</tr>
			</c:forEach>
			</table>
			<p>
				<a href="editSeller.action?id=${seller.sellerID}&action=gotoadd">Add new seller</a>
			</p> 
		</div>
		<!--End Content-->
	</div>
	<!--End Wrapper-->
	<!--Navigation -->
		<%@ include file="admin_navigation.jsp" %>
	<!--End Navigation-->

	<!-- Footer -->
		<%@ include file="footer.jsp" %>
	<!--End Footer-->
</div>
<!--End Container-->

</body>

</html>	