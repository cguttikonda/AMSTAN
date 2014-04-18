<%@ include file="../Misc/iMain.jsp" %>
<%
	ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
	EziComponentsVersionsParams componentsversionsparams= new EziComponentsVersionsParams();
	ReturnObjFromRetrieve retComponentsVersionsDetails=null,dateRet=null;
        String compVersionId = request.getParameter("chk1");

	    componentsversionsparams.setCompNo(compVersionId);
	    mainParams1.setObject(componentsversionsparams);
	    Session.prepareParams(mainParams1);
	    retComponentsVersionsDetails=(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentsVersionsDetails(mainParams1);


		Vector cols=new Vector();
		Vector colTypes=new Vector();
		cols.add("ECV_LAST_UPDATED_ON");
		colTypes.add("DATE");
		global.setColNames(cols);
		global.setColTypes(colTypes);

		try
		{
			dateRet=global.getGlobal(retComponentsVersionsDetails);
		}
		catch(Exception e)
		{
			out.println("Exception in Global date ");
		}




	String comp_code=request.getParameter("cCode");
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
