<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="clientBean"	
	class="beans.ClientBean"	
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
			<p id="titel1">List of all customers</p>
			
			<table id="list1">
				<tr>	
					<th>Name</th>
					<th>ID</th>
					<th>Authorisation</th>
					<th>Change auth.</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>
				<c:forEach var="client" items="${clientBean.clients}">
				<tr>
					<td>
						<!--<c:out value="${client.clientName}"/>-->
						${client.clientName}
					</td>
					<td>
						<c:out value="${client.clientID}"/>
					</td>
					<td>
						<c:out value="${client.authorisation}" />					
					</td>
					<c:choose>
						<c:when test="${client.authorisation=='0'}">
							<td>
								<a href="editClient.action?id=${client.clientID}&action=activate">activate</a>
							</td>					
						</c:when>
						<c:otherwise>
							<td>
								<!-- falls client auth = 1 link für set auth sonst link 2-->
								<a href="editClient.action?id=${client.clientID}&action=deactivate">deactivate</a>
							</td>
						</c:otherwise>
					</c:choose>
					<td>
						<a href="editClient.action?id=${client.clientID}&action=gotoedit"><img src="images/b_edit.png"/></a>
					</td>
					<td>
						<a href="editClient.action?id=${client.clientID}&action=delete" 
							onClick="if(!confirm(&quot;Really delete ${client.clientName}?&quot;)) return false;">
								<img src="images/b_drop.png"/>
						</a>
					</td>
				</tr>
				</c:forEach>
			</table> 
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