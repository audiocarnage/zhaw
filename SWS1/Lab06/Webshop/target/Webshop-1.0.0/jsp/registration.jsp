<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de" lang="de">

<head>
<title>Registration to access the shop</title>
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
			<p id="titel1">Registration to access the shop</p>
			<form method="POST" action='<%=response.encodeURL("registration.action") %>'>
				<p>User name: <input type="text" class="input1" name="userName"/></p>
				<p>Password: <input type="password" class="input1" name="userPassword"/></p>
				<p>
					<input type="submit" class="button" name="registerNewUser" value="Submit"/>
					<input type="reset" class="button" value="Reset"/>
				</p>
			</form>
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