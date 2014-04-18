<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />
<%
	ReturnObjFromRetrieve retCat=null;
	int retCatCnt = 0;

	EzcParams ezcpparams = new EzcParams(true);
	EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
	cnetParams.setQuery("order by cds_Cat.CatID");
	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
	
	retCat = (ReturnObjFromRetrieve)CnetManager.ezGetCnetCategories(ezcpparams);
	log4j.log("retCat>>>>"+retCat.toEzcString(),"I");
	if(retCat!=null)
		retCatCnt = retCat.getRowCount();
	
%>