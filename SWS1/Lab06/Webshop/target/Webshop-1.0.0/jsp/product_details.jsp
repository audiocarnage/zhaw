<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="productBean"
	class="helpClasses.Product"
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
			<p id="titel1"><c:out value="${productBean.productName}"/></p>
			
			<p class="subtitle2">Description</p><p><c:out value="${productBean.description}"/></p>
			<p class="subtitle2">Price per piece</p><p>CHF <c:out value="${productBean.priceUnit}"/></p>
			<p class="subtitle2">In stock</p><p><c:out value="${productBean.amount}"/></p>
			<br />
			<c:if test="${authorisation=='1'}">
				<p class="subtitle2">Purchase</p>
				<form method="POST" action='<%=response.encodeURL("basket.action") %>'>
					<p>
						Anzahl: <input type="text" class="input2" value="1" name="quantity"/>
						<input type="hidden" name="productID" value="${productBean.productID}"/>
						<input type="image" name="addToBasket" value="addToBasket" src="images/basket_icon.gif"/>
					</p>
				</form>
			</c:if>
			<p class="subtitle2">Ratings</p>
			<table id="list1">
				<c:forEach var="rating" items="${ratingBean.ratingList}">
				<tr>
					<c:if test="${rating.shopUserID == sessionScope.shopUserID}">
						<c:set var="ratingSet" value="true" scope="page"/>
					</c:if>
						<td>
							Rating from  
							<c:out value="${rating.userName}" /><br/>
							Mark: <c:out value="${rating.mark}"/><br/>
							Comment: <c:out value="${rating.commentary}"/>
						</td>
				</tr>
				</c:forEach>
			</table>
			<br />
			<c:if test="${authorisation=='1' && !ratingSet}">
				<form method="POST" action='<%=response.encodeURL("productRating.action") %>'>
					<p>Your comment:<br/>
						<textarea name="commentary" cols="70" rows="5"></textarea>
					</p>
					<p>
						Note: 
						<select name="mark">
							<c:forEach var="i" begin="1" end="10" step="1">
							   <option value="<c:out value="${i}"/>"><c:out value="${i}"/></option>
							</c:forEach>
						</select>
					</p>
					<input type="hidden" name="productID" value="<c:out value='${productBean.productID}'/>"/>		
					<p>
						<input type="submit" class="button" name="addNewRating" value="Submit rating"/>
					</p>
				</form>
			</c:if>
			<p><a href="home.action">Back to product overview</a></p>
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