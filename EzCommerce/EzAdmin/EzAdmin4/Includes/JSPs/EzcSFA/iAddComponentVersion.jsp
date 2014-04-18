<%@ include file="../../Lib/iEzMain1.jsp" %>
<%
	String comp_code=request.getParameter("cCode");
	ReturnObjFromRetrieve retComponentsList=null;
	int ComponentsListCount=0;
	ezc.ezparam.EzcParams ezcparams = new ezc.ezparam.EzcParams(false);
	EziComponentsParams ezicomponenentsparams= new EziComponentsParams();
	ezcparams.setObject(ezicomponenentsparams);
	Session.prepareParams(ezcparams);
	retComponentsList =(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentsList(ezcparams);
	if(retComponentsList != null)
		ComponentsListCount = retComponentsList.getRowCount();

	ezc.ezparam.EzcParams ezcparams1 = new ezc.ezparam.EzcParams(false);
	EziComponentVersionHistoryParams ezicomponentversionhistoryparams= new EziComponentVersionHistoryParams();
	ReturnObjFromRetrieve retComponentVersionHistoryList=null;
	int ComponentVersionHistoryListCount=0;
	ezicomponentversionhistoryparams.setCode(comp_code);
	ezcparams1.setObject(ezicomponentversionhistoryparams);
	Session.prepareParams(ezcparams1);
	retComponentVersionHistoryList =(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentVersionHistoryList(ezcparams1);

	if(retComponentVersionHistoryList != null)
	{
			ComponentVersionHistoryListCount = retComponentVersionHistoryList.getRowCount();
	}

%>

