<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iConfirmDelFavNew.jsp"%>

<%
	response.sendRedirect("../BusinessCatalog/ezListFavGroupsDT.jsp");
%>
