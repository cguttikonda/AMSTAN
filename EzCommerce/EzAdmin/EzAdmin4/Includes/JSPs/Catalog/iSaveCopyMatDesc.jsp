<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page">
</jsp:useBean>

<%
// Get the input parameters from the previous screen
String SourceLang = request.getParameter("SourceLang");
String DestLang = request.getParameter("DestLang");

// Copy Material Descriptions
//AdminObject.copyMatDesc(servlet, SourceLang, DestLang );
EzCatalogParams catalogParams = new EzCatalogParams();
Session.prepareParams(catalogParams);
catalogParams.setLanguage(SourceLang);
catalogParams.setToLanguage(DestLang );
Object ret = catalogObj.copyMatDesc(catalogParams);


// Copy Product Group Descriptions
//AdminObject.copyProdGroupDesc(servlet, SourceLang, DestLang );
ret = catalogObj.copyProdGroupDesc(catalogParams);

response.sendRedirect("../Catalog/ezCopyMatDesc.jsp");
%>