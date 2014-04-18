<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iCatGroupDD.jsp"%>
<%
	//Redirect to List Groups Page
	response.sendRedirect("../BusinessCatalog/ezListFavGroups.jsp");         
%>
