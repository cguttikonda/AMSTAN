<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iRemoveCustomCatalog.jsp"%>
<%
// Call the EzCatalog.jsp for showing the Custom Catalog
response.sendRedirect("../BusinessCatalog/ezCatalog.jsp");
%>


