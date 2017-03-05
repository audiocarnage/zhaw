<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div id="left">
		<form method="GET" action='<%=response.encodeURL("productSearch.action") %>'>
			<input type="text" class="input1" name="searchTerm"/>
			<input type="submit" class="button" value="Search"/>
		</form>
		<div id="sidebar">
			<ul>
				<li><a href="home.action">Home</a></li>
				<c:if test="${authorisation=='1'}">
					<li><a href="accountEdit.action?action=gotoedit">My profile</a></li>
					<li><a href="basket.action?showBasket=true">Shopping cart</a></li>
				</c:if>
				<c:if test="${authorisation=='2'}">
					<li><a href="ownOffer.action">My products</a></li>
				</c:if>
				<c:if test="${authorisation=='0'}">
					<li><a href="registration.action?showRegisterForm=true">Register</a></li>
				</c:if>
				
			</ul>
		</div>
		<!--End Sidebar-->
	</div>