<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="basketBean"
	class="beans.BasketBean"
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
			<p id="titel1">Shopping cart</p>
			<p class="subtitle2">
				The following products are currently in your shopping cart:
			</p>
			<c:if test="${basketBean.reservedProducts != null}">
				<table id="list1">
					<tr>
						<th>Product name</th>
						<th>Description</th>
						<th>Price per piece</th>
						<th>Amount</th>
						<th>Remove</th>
					</tr>
					<c:forEach var="item" items="${basketBean.reservedProducts}">
					<tr>
						<td>
							<a href="productDetails.action?productID=${item.key}">${item.value.productName}</a>
						</td>
						<td>
							<c:out value="${item.value.description}"/> 
						</td>
						<td>
							<c:out value="${item.value.priceUnit}"/>
						</td>
						<td>
							<c:out value="${item.value.amount}"/>
						</td>
						<td>
							<a href="basket.action?deleteFromBasket=true&productID=${item.key}"><img src="images/b_drop.png"/></a>	
						</td>
					</tr>
					</c:forEach>
						<tr>
							<td>
								<a href="basket.action?purchaseProducts=true">Kaufen</a>
							</td>
						</tr>	
				</table>
			</c:if>
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