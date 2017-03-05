<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% java.lang.String userName = (String) session.getAttribute("userName");
	if (userName == null) {
		userName = "Guest";
		session.setAttribute("authorisation", "0");
	}
	String authorisation = (String) session.getAttribute("authorisation");
%> 
	<div id="header">
		Welcome
		<c:choose>
			<c:when test="${authorisation=='0'}">
				<c:out value="${userName}"/>
				<div id="loginform">
					<form method="GET" action='<%=response.encodeURL("login.action") %>'>
						<label>User name: </label> <input type="text" class="input1" name="name"/>
						<label>Password: </label> <input type="password" class="input1" name="password"/>
						<input type="submit" class="button" value="Login"/>
					</form>
				</div>
			</c:when>
			<c:otherwise>
				<c:out value="${userName}"/>
				<a href="logout.action"> Log off</a>
			</c:otherwise>
		</c:choose>
		<c:if test="${requestScope.errorList != null}" >
			<div id="showerror">
				<c:forEach var="error" items="${requestScope.errorList}">
					<c:out value="${error}"/>
				</c:forEach>
			</div>
		</c:if>
		<c:if test="${requestScope.infoList != null}" >
			<div id="showinfo">
				<c:forEach var="info" items="${requestScope.infoList}">
					<c:out value="${info}"/>
				</c:forEach>
			</div>
		</c:if>
		<a href="index.html">

		<!-- <img src="pictures/logo_header_01.jpg" width="230" height="100" alt="Uebersicht" /> -->
		</a>
	</div>

