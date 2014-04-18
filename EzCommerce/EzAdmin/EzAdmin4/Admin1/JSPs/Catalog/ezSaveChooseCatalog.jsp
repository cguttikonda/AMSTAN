<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>

<%
String catalogType = request.getParameter("ChooseCatalog");

if(catalogType.equals("Customer")){
	//Redirect to Customer Catalog Page
	response.sendRedirect("../Catalog/ezAddCatalogNumber.jsp");
}else{
	//Redirect to Vendor Catalog Page
	response.sendRedirect("../Catalog/ezAddVendorCatalog.jsp");
}
%>

<html>
<head>
<Title></Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
</body>
</html>
