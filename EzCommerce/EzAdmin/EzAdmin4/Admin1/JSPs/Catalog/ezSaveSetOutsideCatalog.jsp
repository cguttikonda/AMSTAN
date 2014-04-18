<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page">
</jsp:useBean>

<%
String catalogNumber = request.getParameter("OutCatalog");
EzCatalogParams catalogParams = new EzCatalogParams();
Session.prepareParams(catalogParams);
//catalogParams.setSysKey(sys_key);
catalogParams.setCatalogNumber(catalogNumber);
//Call for setting the outside catalog
//AdminObject.setOutSideCatalog(servlet, catalogNumber);

Object ret = catalogObj.setOutSideCatalog(catalogParams);
//Redirect to Set Page
response.sendRedirect("../Catalog/ezSetOutsideCatalog.jsp?saved=Y");
%>

<html>
<head>
<Title>Untitled Document</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">

</body>
</html>
