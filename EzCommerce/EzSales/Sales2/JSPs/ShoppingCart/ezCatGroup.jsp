<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iCatGroup.jsp"%>
<%
	//Redirect to List Groups Page
	response.sendRedirect("../BusinessCatalog/ezListFavGroupsDT.jsp");             
%> 
