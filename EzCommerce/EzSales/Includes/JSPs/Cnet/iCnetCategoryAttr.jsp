<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />
<%
	String categoryID = request.getParameter("categoryID");
	String categoryDesc = request.getParameter("categoryDesc");

	ReturnObjFromRetrieve retObj=null;
	int attrCnt = 0;
	 
	EzcParams ezcpparams = new EzcParams(true);
	EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
	cnetParams.setStatus("GET_ATTR_CATEGORY");
	cnetParams.setCategoryID(categoryID);
	cnetParams.setQuery("order by cds_Cat.AtrID");
	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
	retObj = (ReturnObjFromRetrieve)CnetManager.ezGetCnetAttrValuesByStatus(ezcpparams);
	
	if(retObj!=null)
		attrCnt = retObj.getRowCount();
	log4j.log("retObj>>>>>>"+retObj.toEzcString(),"I");
	
	
%>	