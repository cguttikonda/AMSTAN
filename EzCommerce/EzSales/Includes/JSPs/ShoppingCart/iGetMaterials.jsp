

<%@ page import="ezc.ezprojections.params.*" %>
<jsp:useBean id="ProjManager" class="ezc.ezprojections.client.EzProjectionsManager" />
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
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
