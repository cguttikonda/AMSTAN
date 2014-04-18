<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />
<%
	ReturnObjFromRetrieve retCat=null;
	int retCatCnt = 0;

	EzcParams ezcpparams = new EzcParams(false);
	EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
	cnetParams.setQuery("order by cds_Cat.CatID");
	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
	
	retCat = (ReturnObjFromRetrieve)CnetManager.ezGetCnetCategories(ezcpparams);
	if(retCat!=null)
		retCatCnt = retCat.getRowCount();
	
	//out.println("retCat>>>>"+retCat.toEzcString());
%>