<%@ page import="java.util.*,ezc.ezparam.*,ezc.fedex.freight.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="EzFreightManager" class="ezc.fedex.freight.client.EzFreightManager" scope="page"/>
<%
	
	int stCnt = 0;
	EziServiceTypeParams eziStParams = new EziServiceTypeParams();
	EzcParams params = new EzcParams(false);
	
	eziStParams.setType("GET_ALL_SERVICE_TYPES");
	eziStParams.setExt1("");
	params.setObject(eziStParams);
	Session.prepareParams(params);
	ReturnObjFromRetrieve stRet = (ReturnObjFromRetrieve)EzFreightManager.ezGetType(params);
	
	if(stRet!=null)
		stCnt = stRet.getRowCount();
%>