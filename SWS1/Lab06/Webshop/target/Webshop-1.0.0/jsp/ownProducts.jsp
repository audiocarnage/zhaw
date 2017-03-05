<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="productsBean"
	class="beans.ProductsBean"
	scope="session" />
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
			<p id="titel1">Your own products</p>

			<table id="list1">
				<tr>
					<th>Product name</th>
					<th>Price per piece</th>
					<th>In stock</th>
					<th>Description</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>
	
				<form method="POST" action='<%=response.encodeURL("editOffer.action") %>'>
					<input type="hidden" name="action" value="add"/>	
					<tr>		
						<td><input width="" type="text" name="name" /></td>
						<td><input style="width: 50px;" type="text" name="price" /></td>
						<td><input style="width: 50px;" type="text" name="amount" /></td>
						<td><input type="text" name="description" /></td>
						<td><input type="submit" class="button" value="Add"/></td>
						<td></td>
					</tr>
				</form>					
				<c:forEach var="item" items="${productsBean.products}">
					<form method="POST" action='<%=response.encodeURL("editOffer.action") %>'>	
						<input type="hidden" class="input1" name="action" value="edit"/>			
						<input type="hidden" name="id" value='${item.productID}'/>
					<tr>
						<td><input type="text" name="name" value="${item.productName}" /></td>
						<td><input type="text" style="width: 50px;" name="price" value="${item.priceUnit}"/></td>
						<td><input type="text" style="width: 50px;" name="amount" value="${item.amount}" /></td>
						<td><input type="text" name="description" value="${item.description}" /></td>
						<td><input type="image" src="images/b_edit.png" value="Change"/></td>
					</form>
					<form method="POST" action='<%=response.encodeURL("editOffer.action") %>'>
						<input type="hidden" name="action" value="delete"/>	
						<input type="hidden" name="id" value='${item.productID}'/>
						<td>
							<input type="image" src="images/b_drop.png" value="Delete" onClick="if(!confirm(&quot;Really delete ${item.productName}?&quot;)) return false;" />	
						</td>
					</form>
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