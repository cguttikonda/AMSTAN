<%@ include file="../../Lib/iEzMain1.jsp" %>
<%
	ReturnObjFromRetrieve retComponentsList=null;
	int ComponentsListCount=0;
	ezc.ezparam.EzcParams ezcparams = new ezc.ezparam.EzcParams(false);
	EziComponentsParams ezicomponenentsparams= new EziComponentsParams();
	ezcparams.setObject(ezicomponenentsparams);
	Session.prepareParams(ezcparams);
	retComponentsList =(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentsList(ezcparams);
	if(retComponentsList != null)
		ComponentsListCount = retComponentsList.getRowCount();
%>

