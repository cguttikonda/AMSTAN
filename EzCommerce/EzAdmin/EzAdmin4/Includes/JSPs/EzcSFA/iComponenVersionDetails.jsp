<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../Lib/iEzMain.jsp" %>
<%
	ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
	EziComponentsVersionsParams componentsversionsparams= new EziComponentsVersionsParams();
	ReturnObjFromRetrieve retComponentsVersionsDetails=null;
        String c_Code= request.getParameter("c_Code");
	String v_No= request.getParameter("v_No");

	    componentsversionsparams.setComponent(c_Code);
	    componentsversionsparams.setCompNo(v_No);
	    mainParams1.setObject(componentsversionsparams);
	    Session.prepareParams(mainParams1);
	    retComponentsVersionsDetails=(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentsVersionsDetails(mainParams1);

	ReturnObjFromRetrieve retComponentsList=null;
	int ComponentsListCount=0;
	ezc.ezparam.EzcParams ezcparams = new ezc.ezparam.EzcParams(false);
	EziComponentsParams ezicomponenentsparams= new EziComponentsParams();
	ezcparams.setObject(ezicomponenentsparams);
	Session.prepareParams(ezcparams);
	retComponentsList =(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentsList(ezcparams);
	if(retComponentsList != null)
		ComponentsListCount = retComponentsList.getRowCount();

		String Client="";
	    if("1".equals(retComponentsVersionsDetails.getFieldValueString(0,"ECV_CLIENT")))
	    	Client="Reddys";
	    if("2".equals(retComponentsVersionsDetails.getFieldValueString(0,"ECV_CLIENT")))
		Client="Ranbaxy";
	    if("3".equals(retComponentsVersionsDetails.getFieldValueString(0,"ECV_CLIENT")))
	    	Client="Siris";

		String Component="";
		for(int i=0;i<ComponentsListCount;i++)
		{
		if(c_Code.equals(retComponentsList.getFieldValueString(i,"CODE")))
		{
		Component=retComponentsList.getFieldValueString(i,"DESCRIPTION");
		}
		}

%>
