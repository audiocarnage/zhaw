<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="productsBean"
	class="beans.ProductsBean"
	scope="session" />
<jsp:useBean id="ratingBean"
	class="beans.RatingBean"
	scope="session" />

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
			<p id="titel1">Product overview</p>
			<table id="list1">
				<tr>
					<th>Product name</th>
					<th>Description</th>
					<th>Price per piece</th>
					<th>In stock</th>
					<th>Rating</th>
					<c:if test="${authorisation=='1'}">
						<th>Amount</th>
					</c:if>
				</tr>
				<c:forEach var="item" items="${productsBean.products}">
				<tr>
					<c:set var="productID" value="${item.productID}" scope="page"/>
					<td>
						<a href="productDetails.action?productID=${productID}">
						<c:out value="${item.productName}"/></a>
					</td>
					<td>
						<c:out value="${item.description}"/>
					</td>
					<td>
						<c:out value="${item.priceUnit}"/>
					</td>
					<td>
						<c:out value="${item.amount}"/>
					</td>
					<!-- Get average customer rating -->
					<td>
						<% 
							int avgRating = ratingBean.getAverageMark((Integer)pageContext.getAttribute("productID"));
							if (avgRating == 0) out.print("-");
							else out.print(avgRating);
						%>
					</td>
					<c:if test="${authorisation=='1'}">
					<td>
						<form method="GET" action='<%=response.encodeURL("basket.action") %>'>
							<input type="text" class="input2" value="1" name="quantity"/>
							<input type="hidden" name="productID" value="${productID}"/>
							<input type="image" name="addToBasket" value="addToBasket" src="images/basket_icon.gif"/>
						</form>
					</td>
					</c:if>
				</tr>
				</c:forEach>
			</table>
		</div>
		<!--End Content-->
	</div>
	<!--End Wrapper-->
	<!--Navigation -->
		<%@ include file="navigation.jsp" %>
	<!--End Navigation-->
	
	<!-- Footer -->
		<%@ include file="footer.jsp" %>
	<!--End Footer-->
</div>
<!--End Container-->

</body>

</html>	