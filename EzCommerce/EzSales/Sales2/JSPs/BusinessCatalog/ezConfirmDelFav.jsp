<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iConfirmDelFav.jsp"%>
<%
//Redirect to delete groups page
response.sendRedirect("../BusinessCatalog/ezListFavGroups.jsp");
%>
