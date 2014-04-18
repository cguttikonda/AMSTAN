<%-- changes in this code will effect
	1. ezCreateBulkSales.jsp
	2. ezAddSales.jsp
--%>
<%@ page import="ezc.ezprojections.params.*" %>
<jsp:useBean id="ProjManager" class="ezc.ezprojections.client.EzProjectionsManager" />
<%
	ReturnObjFromRetrieve retpro=null;
	String skey=(String) session.getValue("SalesAreaCode");

	EzcParams ezcpparams = new EzcParams(true);
	EziProjectionHeaderParams inparamsProj=new EziProjectionHeaderParams();
	inparamsProj.setSystemKey(skey);
	inparamsProj.setUserCatalog((String) session.getValue("CatalogCode"));
	ezcpparams.setObject(inparamsProj);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
	
	//retpro = (ReturnObjFromRetrieve)ProjManager.ezGetMaterialsByCountry(ezcpparams);
	
%>