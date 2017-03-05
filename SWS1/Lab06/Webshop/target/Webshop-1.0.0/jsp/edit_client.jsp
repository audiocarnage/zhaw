<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="clientBean"	class="beans.ClientBean"	scope="session" />


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
			<p id="titel1">Edit customer</p>
			<!--
			seller mit id nummer aus sellerList lesen 
			falls attribut add true ist nicht nicht rauslesen
			falls attribut add false ist formular vorfüllen
			-->
			<%
			String act = (String)request.getParameter("action");
			
			if(act!= null && act.equals("gotoedit")){
				String id = (String)request.getParameter("id");
				int intId = Integer.parseInt(id);
				ArrayList<Client> sellerList = clientBean.getClients();
				
				for (Iterator<Client> it = sellerList.iterator(); it.hasNext(); )
				{
					Client temp = (Client)it.next();
					if(temp.getClientID()==intId){
					%>
					<form method="GET" action='<%=response.encodeURL("editClient.action") %>'>	
						<input type="hidden" name="action" value="edit"/>				
						<p>ID: <%=temp.getClientID()%><input type="hidden" name="id" value="<%=temp.getClientID()%> "/></p>
						<p>User name: <input type="text" class="input1" name="name" value="<%=temp.getClientName()%>"/></p>
						<p>Password: <input type="password" class="input1" name="password" value="<%=temp.getClientPassword()%>"/></p>
						<p>
							<input type="submit" class="button" value="Submit"/>
							<input type="reset" class="button" value="Reset"/>
						</p>
					</form>
					<%

					}
				}
			}
			%>
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