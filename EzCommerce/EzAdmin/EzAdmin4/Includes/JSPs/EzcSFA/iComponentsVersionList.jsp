<%@ include file="../../Lib/iEzMain1.jsp" %>
<%
	ReturnObjFromRetrieve retList=null,retComponentsList=null,retComponentsVersionsList=null;
	int ComponentsListCount=0,ComponentsVersionListCount=0,retListCount=0;
	String compCode = "",versionNumber="",isChecked="",databaseValue ="",user="";
	if(request.getParameter("cCode")!=null)
		compCode=request.getParameter("cCode");
	if(request.getParameter("vCode")!=null)
		versionNumber=request.getParameter("vCode");
	if(request.getParameter("user")!=null)
		user=request.getParameter("user");
	


	//////// To get the list of components

	ezc.ezparam.EzcParams ezcparams1 = new ezc.ezparam.EzcParams(false);
	EziComponentsParams ezicomponenentsparams= new EziComponentsParams();
	ezcparams1.setObject(ezicomponenentsparams);
	Session.prepareParams(ezcparams1);
	retComponentsList =(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentsList(ezcparams1);
	if(retComponentsList != null)
		ComponentsListCount = retComponentsList.getRowCount();

	if(compCode != null && !"".equals(compCode))
	{
		ezc.ezparam.EzcParams ezcparams2 = new ezc.ezparam.EzcParams(false);
		EziComponentVersionHistoryParams eziComponentVersionHistoryParams= new EziComponentVersionHistoryParams();
		eziComponentVersionHistoryParams.setCode(compCode);


		ezcparams2.setObject(eziComponentVersionHistoryParams);
		Session.prepareParams(ezcparams2);
		System.out.println("VERSION LIST");
		retComponentsVersionsList =(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentVersionHistoryList(ezcparams2);
		if(retComponentsVersionsList != null)
		{
			ComponentsVersionListCount = retComponentsVersionsList.getRowCount();
		}
	}

	if( compCode != null && !"".equals(compCode) &&  versionNumber != null && !"".equals(versionNumber))
	{

		ezc.ezparam.EzcParams ezcparams3 = new ezc.ezparam.EzcParams(false);
		EziComponentsVersionsParams ezicomponentsversionnumbers= new EziComponentsVersionsParams();
		ezicomponentsversionnumbers.setComponent(compCode);
		if(!"ALL".equals(versionNumber))
			ezicomponentsversionnumbers.setVersion(versionNumber);
		if(!"All".equals(user.trim()))
		ezicomponentsversionnumbers.setClient(user.trim());
		ezcparams3.setObject(ezicomponentsversionnumbers);
		Session.prepareParams(ezcparams3);
		System.out.println("CODE LIST");
		retList =(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentsVersionsList(ezcparams3);
		if(retList != null)
		{
			retListCount = retList.getRowCount();
		}
	}
%>

