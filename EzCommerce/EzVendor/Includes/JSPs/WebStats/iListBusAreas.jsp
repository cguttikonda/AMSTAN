<%--
***************************************************************
       /* =====================================
        * Copyright Notice 
	* This file contains proprietary information of Answerthink Ind Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 
	=====================================*/

       /* =====================================
        * Author : Girish Pavan Cherukuri
	* Team : EzcSuite
	* Date : 16-09-2005
	* Copyright (c) 2005-2006 
	=====================================*/
***************************************************************
--%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	
	// Start Declarations
	
		final String SYSTEM_KEY 		= "ESKD_SYS_KEY";
		final String SYSTEM_KEY_DESC_LANGUAGE 	= "ESKD_LANG";
		final String SYSTEM_KEY_DESCRIPTION 	= "ESKD_SYS_KEY_DESC";
		final String SYSTEM_NUMBER 		= "ESKD_SYS_NO";
		
	//End Declarations
	
	String WebSysKey	= request.getParameter("WebSysKey");
	String fromDate		= request.getParameter("FromDate");
	String toDate		= request.getParameter("ToDate");
	String areaFlag 	= request.getParameter("Area");

	if(fromDate==null || fromDate.equals("null"))	fromDate="";
	if(toDate==null || toDate.equals("null")) toDate="";
	String areaLabel = "";

	// Key Variables
	ReturnObjFromRetrieve ret = null;

	//Get All Catalog Areas
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	if ( areaFlag.equals("C") )
	{
		ret = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
		areaLabel = "Sales Areas";
	}
	else if ( areaFlag.equals("V") )
	{
		ret = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);	
		areaLabel = "Purchase Areas";
	}
	else if ( areaFlag.equals("S") )
	{
		ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
		eds.setAreaFlag(areaFlag);
		eds.setSyncFlag("N");
		snkparams.setEzDescStructure(eds);
		ret = (ReturnObjFromRetrieve) sysManager.getBusinessAreas(sparams);
		areaLabel = "Service Areas";
	}
	
	String[] sortArr={"ESKD_SYS_KEY"};
	ret.sort(sortArr,true);
	ret.check();
	
%>