<%@ include file="../../Lib/iEzMain1.jsp" %>
<%
	ezc.ezparam.EzcParams ezcparams = new ezc.ezparam.EzcParams(false);
	EziComponentsVersionsParams ezicomponentsversionsparams= new EziComponentsVersionsParams();
	ReturnObjFromRetrieve retComponentsVersionsList=null;
	int ComponentsVersionListCount=0;
	ezcparams.setObject(ezicomponentsversionsparams);
	Session.prepareParams(ezcparams);
	retComponentsVersionsList =(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentsVersionsList(ezcparams);
	if(retComponentsVersionsList != null)
		ComponentsVersionListCount = retComponentsVersionsList.getRowCount();




	ezc.ezparam.EzcParams ezcparams1 = new ezc.ezparam.EzcParams(false);
	EziComponentVersionHistoryParams ezicomponentversionhistoryparams= new EziComponentVersionHistoryParams();
	ReturnObjFromRetrieve retComponentVersionHistoryList=null;
	int ComponentVersionHistoryListCount=0;
	ezcparams1.setObject(ezicomponentversionhistoryparams);
	Session.prepareParams(ezcparams1);
	retComponentVersionHistoryList =(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentVersionHistoryList(ezcparams1);
	if(retComponentVersionHistoryList != null)
		ComponentVersionHistoryListCount = retComponentVersionHistoryList.getRowCount();
%>

