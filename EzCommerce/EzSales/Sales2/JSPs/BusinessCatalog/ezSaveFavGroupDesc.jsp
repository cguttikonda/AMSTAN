<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iSaveFavGroupDesc.jsp"%>
<%
//Redirect to display group description page
response.sendRedirect("../BusinessCatalog/ezListFavGroupsDT.jsp");
%>
